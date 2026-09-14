-- Corregir la función update_payment_status para que funcione con session_id y devuelva user_id
-- Esta función es necesaria para que el webhook de Stripe pueda continuar con add_paid_analyses

CREATE OR REPLACE FUNCTION update_payment_status(
  session_id_param TEXT,
  new_status TEXT,
  payment_method_param TEXT DEFAULT NULL,
  stripe_fee_cents_param INTEGER DEFAULT NULL,
  net_amount_cents_param INTEGER DEFAULT NULL,
  stripe_customer_id_param TEXT DEFAULT NULL
)
RETURNS TABLE(user_id UUID, payment_id UUID) AS $$
DECLARE
  payment_record payments;
BEGIN
  -- Actualizar el estado del pago usando session_id
  UPDATE payments 
  SET 
    status = new_status,
    payment_method = COALESCE(payment_method_param, payment_method),
    stripe_fee_cents = COALESCE(stripe_fee_cents_param, stripe_fee_cents),
    stripe_customer_id = COALESCE(stripe_customer_id_param, stripe_customer_id),
    net_amount_cents = COALESCE(net_amount_cents_param, net_amount_cents),
    paid_at = CASE WHEN new_status = 'completed' THEN NOW() ELSE paid_at END,
    updated_at = NOW()
  WHERE stripe_session_id = session_id_param
  RETURNING * INTO payment_record;
  
  -- Si encontramos el pago, devolver user_id y payment_id
  IF payment_record.id IS NOT NULL THEN
    -- Si el pago fue exitoso, actualizar el estado en user_monthly_usage
    IF new_status = 'completed' THEN
      PERFORM mark_payment_completed(payment_record.stripe_payment_intent_id);
    END IF;
    
    -- Devolver los datos necesarios para el webhook
    RETURN QUERY SELECT payment_record.user_id, payment_record.id;
  ELSE
    -- Si no se encontró el pago, devolver NULL
    RETURN QUERY SELECT NULL::UUID, NULL::UUID;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;