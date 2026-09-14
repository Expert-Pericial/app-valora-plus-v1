-- Crear tabla para almacenar información de pagos de Stripe
CREATE TABLE IF NOT EXISTS stripe_payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  payment_intent_id TEXT UNIQUE NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  currency VARCHAR(3) DEFAULT 'EUR',
  status VARCHAR(50) NOT NULL, -- requires_payment_method, requires_confirmation, requires_action, processing, requires_capture, canceled, succeeded
  description TEXT,
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear índices para optimizar consultas
CREATE INDEX IF NOT EXISTS idx_stripe_payments_user_id ON stripe_payments(user_id);
CREATE INDEX IF NOT EXISTS idx_stripe_payments_payment_intent ON stripe_payments(payment_intent_id);
CREATE INDEX IF NOT EXISTS idx_stripe_payments_status ON stripe_payments(status);

-- Función para crear un payment intent de Stripe (simulada - se implementará con Edge Functions)
CREATE OR REPLACE FUNCTION create_stripe_payment_intent(
  amount_cents INTEGER,
  currency_code TEXT DEFAULT 'eur',
  description_text TEXT DEFAULT NULL
)
RETURNS JSONB AS $$
DECLARE
  payment_record stripe_payments;
  mock_payment_intent_id TEXT;
BEGIN
  -- Generar un ID simulado para el payment intent (en producción esto vendrá de Stripe)
  mock_payment_intent_id := 'pi_mock_' || gen_random_uuid()::TEXT;
  
  -- Insertar registro de pago
  INSERT INTO stripe_payments (
    user_id, 
    payment_intent_id, 
    amount, 
    currency, 
    status, 
    description,
    metadata
  ) VALUES (
    auth.uid(),
    mock_payment_intent_id,
    amount_cents / 100.0,
    currency_code,
    'requires_payment_method',
    description_text,
    jsonb_build_object(
      'user_id', auth.uid(),
      'created_by', 'system',
      'type', 'additional_analysis'
    )
  ) RETURNING * INTO payment_record;
  
  -- Retornar información del payment intent
  RETURN jsonb_build_object(
    'payment_intent_id', payment_record.payment_intent_id,
    'amount', payment_record.amount,
    'currency', payment_record.currency,
    'status', payment_record.status,
    'client_secret', 'pi_mock_secret_' || gen_random_uuid()::TEXT -- En producción esto vendrá de Stripe
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función para actualizar el estado de un payment intent
CREATE OR REPLACE FUNCTION update_stripe_payment_status(
  payment_intent_id_param TEXT,
  new_status TEXT
)
RETURNS BOOLEAN AS $$
BEGIN
  UPDATE stripe_payments 
  SET 
    status = new_status,
    updated_at = NOW()
  WHERE payment_intent_id = payment_intent_id_param;
  
  -- Si el pago fue exitoso, actualizar el estado en user_monthly_usage
  IF new_status = 'succeeded' THEN
    PERFORM mark_payment_completed(payment_intent_id_param);
  END IF;
  
  RETURN FOUND;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función para procesar un análisis con verificación de pago
CREATE OR REPLACE FUNCTION process_analysis_with_payment_check()
RETURNS JSONB AS $$
DECLARE
  usage_info JSONB;
  payment_info JSONB;
  billing_enabled BOOLEAN;
BEGIN
  -- Verificar si la facturación está habilitada
  SELECT (get_system_setting('billing_enabled')->>'value')::BOOLEAN INTO billing_enabled;
  
  -- Incrementar el conteo de análisis
  SELECT increment_analysis_count() INTO usage_info;
  
  -- Si no es gratuito y la facturación está habilitada, crear payment intent
  IF NOT (usage_info->>'is_free')::BOOLEAN AND billing_enabled THEN
    SELECT create_stripe_payment_intent(
      ((usage_info->>'amount_charged')::DECIMAL * 100)::INTEGER, -- Convertir a centavos
      'eur',
      'Análisis adicional - ' || TO_CHAR(NOW(), 'MM/YYYY')
    ) INTO payment_info;
    
    -- Actualizar el registro de uso mensual con el payment intent ID
    UPDATE user_monthly_usage 
    SET stripe_payment_intent_id = payment_info->>'payment_intent_id'
    WHERE user_id = auth.uid() 
      AND year = EXTRACT(YEAR FROM NOW())
      AND month = EXTRACT(MONTH FROM NOW());
  END IF;
  
  -- Retornar información completa
  RETURN jsonb_build_object(
    'usage_info', usage_info,
    'payment_info', COALESCE(payment_info, '{}'::JSONB),
    'requires_payment', NOT (usage_info->>'is_free')::BOOLEAN AND billing_enabled
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función para obtener historial de pagos del usuario
CREATE OR REPLACE FUNCTION get_user_payment_history()
RETURNS JSONB AS $$
DECLARE
  payments JSONB;
BEGIN
  SELECT jsonb_agg(
    jsonb_build_object(
      'id', sp.id,
      'amount', sp.amount,
      'currency', sp.currency,
      'status', sp.status,
      'description', sp.description,
      'created_at', sp.created_at,
      'month_year', TO_CHAR(sp.created_at, 'MM/YYYY')
    ) ORDER BY sp.created_at DESC
  ) INTO payments
  FROM stripe_payments sp
  WHERE sp.user_id = auth.uid();
  
  RETURN COALESCE(payments, '[]'::JSONB);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Políticas RLS para stripe_payments
ALTER TABLE stripe_payments ENABLE ROW LEVEL SECURITY;

-- Los usuarios pueden ver solo sus propios pagos
CREATE POLICY "Users can view their own payments" ON stripe_payments
  FOR SELECT USING (user_id = auth.uid());

-- Los admins pueden ver todos los pagos
CREATE POLICY "Admins can view all payments" ON stripe_payments
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = auth.uid() 
      AND profiles.role = 'admin'
    )
  );

-- Solo el sistema puede insertar/actualizar pagos (a través de funciones SECURITY DEFINER)
CREATE POLICY "System can manage payments" ON stripe_payments
  FOR ALL USING (FALSE); -- Bloquear acceso directo, solo a través de funciones

-- Trigger para actualizar updated_at
CREATE OR REPLACE FUNCTION update_stripe_payments_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_stripe_payments_updated_at
  BEFORE UPDATE ON stripe_payments
  FOR EACH ROW
  EXECUTE FUNCTION update_stripe_payments_updated_at();

-- Agregar configuraciones adicionales para Stripe
INSERT INTO system_settings (setting_key, setting_value, description) VALUES
  ('stripe_publishable_key', '{"value": ""}', 'Clave pública de Stripe para el frontend'),
  ('stripe_webhook_secret', '{"value": ""}', 'Secret para validar webhooks de Stripe'),
  ('payment_success_redirect', '{"value": "/my-account?payment=success"}', 'URL de redirección después de pago exitoso'),
  ('payment_cancel_redirect', '{"value": "/my-account?payment=cancelled"}', 'URL de redirección después de cancelar pago')
ON CONFLICT (setting_key) DO NOTHING;