-- Add stripe_customer_id parameter to create_payment_record function

CREATE OR REPLACE FUNCTION create_payment_record(
  workshop_id_param UUID,
  user_id_param UUID,
  stripe_payment_intent_id_param TEXT,
  stripe_session_id_param TEXT,
  stripe_customer_id_param TEXT,
  amount_cents_param INTEGER,
  currency_param TEXT DEFAULT 'EUR',
  analysis_month_param TEXT DEFAULT NULL,
  description_param TEXT DEFAULT NULL
)
RETURNS UUID AS $$
DECLARE
  payment_id UUID;
  current_month TEXT;
BEGIN
  -- Usar el mes actual si no se proporciona
  current_month := COALESCE(analysis_month_param, TO_CHAR(NOW(), 'YYYY-MM'));
  
  -- Insertar registro de pago
  INSERT INTO payments (
    workshop_id,
    user_id,
    stripe_payment_intent_id,
    stripe_session_id,
    stripe_customer_id,
    amount_cents,
    currency,
    status,
    analysis_month,
    analyses_purchased,
    unit_price_cents,
    description
  ) VALUES (
    workshop_id_param,
    user_id_param,
    stripe_payment_intent_id_param,
    stripe_session_id_param,
    stripe_customer_id_param,
    amount_cents_param,
    currency_param,
    'pending',
    current_month,
    1, -- Por defecto 1 análisis
    amount_cents_param, -- Por ahora el precio unitario es igual al total
    description_param
  ) RETURNING id INTO payment_id;
  
  RETURN payment_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;