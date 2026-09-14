-- Solucionar conflicto de sobrecarga de funciones update_payment_status
-- Eliminar todas las versiones anteriores y mantener solo la más completa

-- Eliminar versión original (4 parámetros)
DROP FUNCTION IF EXISTS update_payment_status(
  stripe_payment_intent_id_param TEXT,
  new_status TEXT,
  payment_method_param TEXT,
  stripe_fee_cents_param INTEGER
);

-- Eliminar versión con session_id (5 parámetros)
DROP FUNCTION IF EXISTS update_payment_status(
  stripe_payment_intent_id_param TEXT,
  new_status TEXT,
  payment_method_param TEXT,
  stripe_fee_cents_param INTEGER,
  stripe_session_id_param TEXT
);

-- Recrear la función final con todos los parámetros (6 parámetros)
-- Esta es la versión más completa que debe mantenerse
CREATE OR REPLACE FUNCTION update_payment_status(
  stripe_payment_intent_id_param TEXT,
  new_status TEXT,
  payment_method_param TEXT DEFAULT NULL,
  stripe_fee_cents_param INTEGER DEFAULT NULL,
  stripe_session_id_param TEXT DEFAULT NULL,
  stripe_customer_id_param TEXT DEFAULT NULL
)
RETURNS BOOLEAN AS $$
DECLARE
  payment_record payments;
BEGIN
  -- Actualizar el estado del pago
  UPDATE payments 
  SET 
    status = new_status,
    payment_method = COALESCE(payment_method_param, payment_method),
    stripe_fee_cents = COALESCE(stripe_fee_cents_param, stripe_fee_cents),
    stripe_session_id = COALESCE(stripe_session_id_param, stripe_session_id),
    stripe_customer_id = COALESCE(stripe_customer_id_param, stripe_customer_id),
    net_amount_cents = CASE 
      WHEN stripe_fee_cents_param IS NOT NULL 
      THEN amount_cents - stripe_fee_cents_param 
      ELSE net_amount_cents 
    END,
    paid_at = CASE WHEN new_status = 'succeeded' THEN NOW() ELSE paid_at END,
    updated_at = NOW()
  WHERE stripe_payment_intent_id = stripe_payment_intent_id_param
  RETURNING * INTO payment_record;
  
  -- Si el pago fue exitoso, actualizar el estado en user_monthly_usage
  IF new_status = 'succeeded' AND payment_record.id IS NOT NULL THEN
    PERFORM mark_payment_completed(stripe_payment_intent_id_param);
  END IF;
  
  RETURN FOUND;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;