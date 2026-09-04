// @ts-nocheck
// Edge Function for Stripe webhooks - runs in Deno environment
import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import Stripe from 'https://esm.sh/stripe@14.21.0'

const stripe = new Stripe((Deno as any).env.get('STRIPE_SECRET_KEY') ?? '', {
  apiVersion: '2023-10-16',
})

serve(async (req: any) => {
  // Only accept POST requests
  if (req.method !== 'POST') {
    return new Response('Method not allowed', { status: 405 })
  }

  const signature = req.headers.get('stripe-signature')
  const webhookSecret = (Deno as any).env.get('STRIPE_WEBHOOK_SECRET')

  console.log('🔍 Webhook request received:', {
    method: req.method,
    hasSignature: !!signature,
    hasSecret: !!webhookSecret,
    contentType: req.headers.get('content-type')
  })

  if (!signature) {
    console.error('❌ Missing Stripe signature header')
    return new Response('Missing Stripe signature', { status: 400 })
  }

  if (!webhookSecret) {
    console.error('❌ Missing webhook secret environment variable')
    return new Response('Webhook not configured', { status: 500 })
  }

  let body: string
  try {
    body = await req.text()
    console.log('📥 Request body length:', body.length)
  } catch (error) {
    console.error('❌ Error reading request body:', error)
    return new Response('Invalid request body', { status: 400 })
  }

  let event: Stripe.Event
  try {
    // Verify webhook signature
    event = await stripe.webhooks.constructEventAsync(body, signature, webhookSecret)
    console.log('✅ Webhook signature verified successfully')
  } catch (error) {
    console.error('❌ Webhook signature verification failed:', error)
    return new Response('Invalid signature', { status: 400 })
  }

  try {
    // Create Supabase client with service role key for admin operations
    const supabaseClient = createClient(
      (Deno as any).env.get('SUPABASE_URL') ?? '',
      (Deno as any).env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    console.log('📨 Processing webhook event:', event.type)

    switch (event.type) {
      case 'checkout.session.completed': {
        const session = event.data.object as Stripe.Checkout.Session
        
        console.log('🎯 Processing checkout.session.completed:', {
          payment_intent: session.payment_intent,
          session_id: session.id,
          customer: session.customer,
          metadata: session.metadata
        })
        
        // Validate required fields
        if (!session.payment_intent) {
          console.error('❌ Missing payment_intent in session:', session.id)
          throw new Error('Missing payment_intent in checkout session')
        }
        
        // Try to get customer ID - it might be a string ID or null
        let customerId: string | null = null
        
        if (session.customer) {
          // If customer is a string, it's the customer ID
          if (typeof session.customer === 'string') {
            customerId = session.customer
            console.log('✅ Customer ID found in session:', customerId)
          } else {
            // If it's an object, get the ID from it
            customerId = (session.customer as any).id
            console.log('✅ Customer ID extracted from object:', customerId)
          }
        } else {
          console.log('⚠️ No customer ID in session - this might be a guest checkout')
          
          // Try to retrieve the session with expanded customer data
          try {
            const expandedSession = await stripe.checkout.sessions.retrieve(session.id, {
              expand: ['customer']
            })
            
            if (expandedSession.customer) {
              if (typeof expandedSession.customer === 'string') {
                customerId = expandedSession.customer
              } else {
                customerId = (expandedSession.customer as any).id
              }
              console.log('✅ Customer ID retrieved from expanded session:', customerId)
            }
          } catch (expandError) {
            console.error('❌ Error expanding session customer:', expandError)
          }
        }
        
        // Get payment method and calculate fees
        const paymentMethod = session.payment_method_types?.[0] || 'card'

        const paymentIntentId = typeof session.payment_intent === 'string'
          ? session.payment_intent
          : session.payment_intent.id

        // null (no 0) para que el COALESCE del RPC deje el valor previo intacto si
        // no conseguimos leer la comision, en vez de escribir ceros falsos.
        let stripeFee: number | null = null
        let netAmount: number | null = null

        if (session.payment_intent) {
          try {
            // La API 2023-10-16 ya no expone paymentIntent.charges: la comisión viaja
            // en latest_charge.balance_transaction, y hay que pedirla expandida.
            const paymentIntent = await stripe.paymentIntents.retrieve(
              paymentIntentId,
              { expand: ['latest_charge.balance_transaction'] }
            )

            const charge = paymentIntent.latest_charge as any
            const balanceTransaction = charge?.balance_transaction

            if (balanceTransaction) {
              stripeFee = typeof balanceTransaction === 'string'
                ? (await stripe.balanceTransactions.retrieve(balanceTransaction)).fee
                : balanceTransaction.fee
              netAmount = (paymentIntent.amount || 0) - stripeFee
            }
          } catch (feeError) {
            console.error('⚠️ Error calculating fees:', feeError)
            // Continue without fee data
          }
        }
        
        // Update payment status to completed using the new function
        const updateParams = {
          session_id_param: session.id,
          new_status: 'completed',
          payment_method_param: paymentMethod,
          stripe_fee_cents_param: stripeFee,
          net_amount_cents_param: netAmount,
          stripe_customer_id_param: customerId,
          stripe_payment_intent_id_param: paymentIntentId
        }

        console.log('🔄 Calling update_payment_status with params:', updateParams)

        const markCompleted = async () => {
          const { data, error } = await supabaseClient.rpc('update_payment_status', updateParams)

          if (error) {
            console.error('❌ Error updating payment status:', error)
            console.error('📋 Update params were:', updateParams)
            console.error('🔍 Error details:', {
              message: error.message,
              details: error.details,
              hint: error.hint,
              code: error.code
            })
            throw error
          }

          // El RPC devuelve (NULL, NULL) sin error cuando el UPDATE no encuentra
          // la fila, asi que hay que inspeccionar el resultado.
          const row = Array.isArray(data) ? data[0] : data
          return row?.payment_id ? row : null
        }

        let updateResult = await markCompleted()

        if (!updateResult) {
          // No existe la fila de `payments` para esta sesion (p.ej. el insert de
          // payment-session fallo). El pago ya esta cobrado, asi que la
          // reconstruimos desde los metadatos de la sesion y reintentamos.
          console.error('⚠️ No payment row found for session, self-healing from metadata:', session.id)

          const meta = session.metadata ?? {}

          if (!meta.user_id || !meta.workshop_id) {
            throw new Error(
              `No payment row for session ${session.id} and metadata is incomplete ` +
              `(user_id=${meta.user_id}, workshop_id=${meta.workshop_id}). Manual reconciliation required.`
            )
          }

          const analysesCount = parseInt(meta.analyses_count ?? '1', 10) || 1
          const amountCents = parseInt(meta.amount_cents ?? '', 10) || session.amount_total || 0

          const { error: insertError } = await supabaseClient
            .from('payments')
            .insert({
              user_id: meta.user_id,
              workshop_id: meta.workshop_id,
              stripe_session_id: session.id,
              stripe_payment_intent_id: paymentIntentId,
              amount_cents: amountCents,
              currency: meta.currency || session.currency || 'eur',
              status: 'pending', // 'pending' a proposito: el trigger de balance
              // solo se dispara en la transicion pending -> completed.
              analysis_month: meta.analysis_month || new Date().toISOString().slice(0, 7),
              analyses_purchased: analysesCount,
              unit_price_cents: parseInt(meta.unit_price_cents ?? '', 10) || Math.round(amountCents / analysesCount),
              description: meta.description || 'Pago reconstruido desde Stripe',
              package_id: meta.package_id || null,
            })

          if (insertError) {
            console.error('❌ Self-healing insert failed:', insertError)
            throw insertError
          }

          console.log('🩹 Payment row rebuilt from metadata, retrying status update')

          updateResult = await markCompleted()

          if (!updateResult) {
            throw new Error(`Payment row rebuilt but status update still found no row for session ${session.id}`)
          }
        }

        console.log('✅ Payment completed successfully:', paymentIntentId, 'Session ID:', session.id, 'Customer ID:', customerId)
        console.log('📊 Update result:', updateResult)

        // ✨ SIMPLIFIED WEBHOOK: El trigger automático se encarga del balance
        // Ya no necesitamos manejar manualmente el balance aquí
        // El trigger 'trigger_payment_completion_add_balance' se ejecutará automáticamente
        // cuando el status del payment cambie a 'completed' en la función update_payment_status

        console.log('🎯 Payment status updated to completed. Trigger will handle balance automatically.')

        break
      }

      case 'checkout.session.expired': {
        const session = event.data.object as Stripe.Checkout.Session
        
        console.log('🚫 Processing checkout.session.expired:', {
          payment_intent: session.payment_intent,
          session_id: session.id
        })
        
        // Only update if we have a session_id
        if (session.id) {
          const { error: updateError } = await supabaseClient
            .rpc('update_payment_status', {
              session_id_param: session.id,
              new_status: 'canceled'
            })

          if (updateError) {
            console.error('❌ Error updating payment status for expired session:', updateError)
            throw updateError
          }

          console.log('✅ Session expired, payment canceled:', session.id)
        } else {
          console.log('⚠️ No session_id in expired session, skipping update')
        }
        break
      }

      case 'payment_intent.payment_failed': {
        const paymentIntent = event.data.object as Stripe.PaymentIntent
        
        console.log('❌ Processing payment_intent.payment_failed:', paymentIntent.id)
        
        // Update payment status to failed using the payment_intent function
        const { error: updateError } = await supabaseClient
          .rpc('update_payment_status_by_intent', {
            payment_intent_id_param: paymentIntent.id,
            new_status: 'failed'
          })

        if (updateError) {
          console.error('❌ Error updating payment status for failed payment:', updateError)
          throw updateError
        }

        console.log('✅ Payment failed, status updated:', paymentIntent.id)
        break
      }

      default:
        console.log('Unhandled event type:', event.type)
    }

    return new Response(JSON.stringify({ received: true }), {
      headers: { 'Content-Type': 'application/json' },
      status: 200,
    })
  } catch (error) {
    console.error('❌ Webhook processing error:', error)
    
    // Return detailed error information for debugging
    const errorDetails = {
      error: 'Webhook handler failed',
      message: error instanceof Error ? error.message : 'Unknown error',
      details: error instanceof Error ? error.stack : String(error),
      timestamp: new Date().toISOString(),
      event_type: event?.type || 'unknown'
    }
    
    console.error('🔍 Error details being returned:', errorDetails)
    
    return new Response(
      JSON.stringify(errorDetails),
      {
        headers: { 'Content-Type': 'application/json' },
        status: 500, // Changed from 400 to 500 for processing errors
      }
    )
  }
})