// @ts-nocheck
import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
  // Handle CORS preflight requests
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    // Create Supabase client
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? '',
      {
        global: {
          headers: { Authorization: req.headers.get('Authorization')! },
        },
      }
    )

    // Cliente con service role SOLO para escribir en `payments`. Las politicas RLS
    // de esa tabla no permiten INSERT al rol `authenticated`, asi que el insert con
    // la anon key siempre falla y el webhook se queda sin fila que actualizar.
    const supabaseAdmin = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // Get request body first
    const body = await req.json()
    const { amount, currency = 'eur', description = 'Payment', package_id, analyses_count } = body

    // El JWT es la unica fuente de identidad: aceptar un user_id del body permitiria
    // crear sesiones de pago a nombre de cualquier usuario.
    if (!req.headers.get('Authorization')) {
      return new Response(
        JSON.stringify({ error: 'Missing Authorization header' }),
        {
          status: 401,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        }
      )
    }

    const {
      data: { user },
    } = await supabaseClient.auth.getUser()

    if (!user) {
      return new Response(
        JSON.stringify({ error: 'No user found' }),
        {
          status: 401,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        }
      )
    }

    let packageData = null
    let finalAmount = amount
    let finalDescription = description
    let finalAnalysesCount = analyses_count || 1

    // If package_id is provided, get package details
    if (package_id) {
      const { data: packageInfo, error: packageError } = await supabaseClient
        .rpc('get_package_by_id', { package_id })
        .single()

      if (packageError || !packageInfo) {
        return new Response(
          JSON.stringify({ error: 'Package not found' }),
          {
            status: 404,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' },
          }
        )
      }

      packageData = packageInfo
      finalAmount = Number(packageInfo.total_price)
      finalDescription = `${packageInfo.name} - ${packageInfo.analyses_count} análisis`
      finalAnalysesCount = packageInfo.analyses_count
    }

    if (!finalAmount || finalAmount <= 0) {
      return new Response(
        JSON.stringify({ error: 'Invalid amount' }),
        {
          status: 400,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        }
      )
    }

    // Get user profile
    const { data: profile, error: profileError } = await supabaseClient
      .from('profiles')
      .select('*')
      .eq('id', user.id)
      .single()

    if (profileError || !profile) {
      return new Response(
        JSON.stringify({ error: 'Profile not found' }),
        {
          status: 404,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        }
      )
    }

    // payments.workshop_id es NOT NULL y referencia workshops(id): sin taller el
    // INSERT violaria la FK. Mejor cortar aqui que cobrar y no poder registrarlo.
    if (!profile.workshop_id) {
      return new Response(
        JSON.stringify({ error: 'El usuario no tiene un taller asignado; no se puede registrar el pago.' }),
        {
          status: 400,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        }
      )
    }

    // Initialize Stripe
    const stripe = new (await import('https://esm.sh/stripe@14.21.0')).default(
      Deno.env.get('STRIPE_SECRET_KEY') ?? '',
      {
        apiVersion: '2023-10-16',
      }
    )

    // Get success and cancel URLs from system settings
    const { data: settings } = await supabaseClient
      .from('system_settings')
      .select('stripe_success_url, stripe_cancel_url')
      .single()

    const baseSuccessUrl = settings?.stripe_success_url || `${req.headers.get('origin')}/payment-success`
    const baseCancelUrl = settings?.stripe_cancel_url || `${req.headers.get('origin')}/payment-cancel`
    
    // Add session_id parameter to URLs so Stripe can send it back
    const successUrl = `${baseSuccessUrl}?session_id={CHECKOUT_SESSION_ID}`
    const cancelUrl = `${baseCancelUrl}?session_id={CHECKOUT_SESSION_ID}`

    // Calculate unit price (already in cents from database)
    const unitPriceCents = packageData
      ? Math.round(Number(packageData.price_per_analysis))
      : Math.round(finalAmount)

    const analysisMonth = new Date().toISOString().slice(0, 7) // YYYY-MM

    // Create Stripe checkout session
    const session = await stripe.checkout.sessions.create({
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: currency,
            product_data: {
              name: finalDescription,
            },
            //unit_amount: Math.round(finalAmount * 100), // Convert to cents
            unit_amount: finalAmount,
          },
          quantity: 1,
        },
      ],
      mode: 'payment',
      success_url: successUrl,
      cancel_url: cancelUrl,
      customer_email: user.email,
      metadata: {
        user_id: user.id,
        workshop_id: profile.workshop_id,
        description: finalDescription,
        package_id: package_id || '',
        analyses_count: finalAnalysesCount.toString(),
        unit_price_cents: unitPriceCents.toString(),
        amount_cents: Math.round(finalAmount).toString(),
        currency: currency,
        analysis_month: analysisMonth,
      },
    })

    // Store payment record. Con service role para saltar RLS: sin esta fila el
    // webhook no tiene nada que marcar como pagado y el balance nunca se acredita.
    const { error: paymentError } = await supabaseAdmin
      .from('payments')
      .insert({
        user_id: user.id,
        workshop_id: profile.workshop_id,
        stripe_session_id: session.id,
        stripe_payment_intent_id: session.payment_intent || session.id, // Use session.id as fallback
        amount_cents: Math.round(finalAmount), // Already in cents from database
        currency: currency,
        status: 'pending',
        analysis_month: analysisMonth,
        analyses_purchased: finalAnalysesCount,
        unit_price_cents: unitPriceCents,
        description: finalDescription,
        package_id: package_id || null, // ✨ Agregar package_id al registro
      })

    if (paymentError) {
      // Fallar en cerrado: es mejor un pago que no arranca que uno cobrado y sin
      // registrar. No devolvemos la URL, asi que el usuario nunca llega a pagar.
      console.error('Error storing payment record:', paymentError)
      return new Response(
        JSON.stringify({
          error: 'No se pudo registrar el pago; no se ha iniciado el cobro.',
          details: paymentError.message,
        }),
        {
          status: 500,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        }
      )
    }

    return new Response(
      JSON.stringify({ 
        url: session.url,
        session_id: session.id 
      }),
      {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      }
    )

  } catch (error) {
    console.error('Error in payment-session function:', error)
    const errorMessage = error instanceof Error ? error.message : 'Unknown error occurred'
    
    return new Response(
      JSON.stringify({ error: errorMessage }),
      {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      }
    )
  }
})