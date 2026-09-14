-- Crear tabla payments mejorada para registrar todas las transacciones de Stripe
CREATE TABLE IF NOT EXISTS payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  workshop_id UUID REFERENCES workshops(id) NOT NULL,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  
  -- Datos de Stripe
  stripe_payment_intent_id TEXT UNIQUE NOT NULL,
  stripe_session_id TEXT,
  stripe_customer_id TEXT,
  
  -- Detalles del pago
  amount_cents INTEGER NOT NULL, -- en centavos
  currency TEXT DEFAULT 'EUR' NOT NULL,
  status TEXT NOT NULL, -- 'pending', 'succeeded', 'failed', 'canceled'
  
  -- Contexto del pago
  analysis_month TEXT NOT NULL, -- formato 'YYYY-MM'
  analyses_purchased INTEGER DEFAULT 1 NOT NULL, -- cuántos análisis se compraron
  unit_price_cents INTEGER NOT NULL, -- precio por análisis en centavos
  
  -- Metadatos
  payment_method TEXT, -- 'card', 'sepa_debit', etc.
  stripe_fee_cents INTEGER, -- comisión de Stripe
  net_amount_cents INTEGER, -- cantidad neta recibida
  description TEXT,
  
  -- Timestamps
  created_at TIMESTAMPTZ DEFAULT NOW(),
  paid_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Crear índices para optimizar consultas
CREATE INDEX IF NOT EXISTS idx_payments_workshop_id ON payments(workshop_id);
CREATE INDEX IF NOT EXISTS idx_payments_user_id ON payments(user_id);
CREATE INDEX IF NOT EXISTS idx_payments_stripe_payment_intent ON payments(stripe_payment_intent_id);
CREATE INDEX IF NOT EXISTS idx_payments_status ON payments(status);
CREATE INDEX IF NOT EXISTS idx_payments_analysis_month ON payments(analysis_month);

-- Políticas RLS para payments
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;

-- Los usuarios pueden ver solo los pagos de su workshop
CREATE POLICY "Users can view their workshop payments" ON payments
  FOR SELECT USING (
    workshop_id IN (
      SELECT workshop_id FROM profiles WHERE id = auth.uid()
    )
  );

-- Los admins pueden ver todos los pagos
CREATE POLICY "Admins can view all payments" ON payments
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = auth.uid() 
      AND profiles.role = 'admin'
    )
  );

-- Solo el sistema puede insertar/actualizar pagos (a través de funciones SECURITY DEFINER)
CREATE POLICY "System can manage payments" ON payments
  FOR ALL USING (FALSE); -- Bloquear acceso directo, solo a través de funciones

-- Trigger para actualizar updated_at
CREATE OR REPLACE FUNCTION update_payments_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_payments_updated_at
  BEFORE UPDATE ON payments
  FOR EACH ROW
  EXECUTE FUNCTION update_payments_updated_at();

-- Función para crear un registro de pago
CREATE OR REPLACE FUNCTION create_payment_record(
  workshop_id_param UUID,
  stripe_payment_intent_id_param TEXT,
  stripe_session_id_param TEXT,
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
    amount_cents,
    currency,
    status,
    analysis_month,
    analyses_purchased,
    unit_price_cents,
    description
  ) VALUES (
    workshop_id_param,
    auth.uid(),
    stripe_payment_intent_id_param,
    stripe_session_id_param,
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

-- Función para actualizar el estado de un pago
CREATE OR REPLACE FUNCTION update_payment_status(
  stripe_payment_intent_id_param TEXT,
  new_status TEXT,
  payment_method_param TEXT DEFAULT NULL,
  stripe_fee_cents_param INTEGER DEFAULT NULL
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

-- Función para obtener historial de pagos de un workshop
CREATE OR REPLACE FUNCTION get_workshop_payment_history(workshop_id_param UUID DEFAULT NULL)
RETURNS JSONB AS $$
DECLARE
  target_workshop_id UUID;
  payments_data JSONB;
BEGIN
  -- Si no se proporciona workshop_id, usar el del usuario actual
  IF workshop_id_param IS NULL THEN
    SELECT workshop_id INTO target_workshop_id
    FROM profiles 
    WHERE id = auth.uid();
  ELSE
    target_workshop_id := workshop_id_param;
  END IF;
  
  -- Verificar que el usuario tenga acceso al workshop
  IF NOT EXISTS (
    SELECT 1 FROM profiles 
    WHERE id = auth.uid() 
    AND (workshop_id = target_workshop_id OR role = 'admin')
  ) THEN
    RAISE EXCEPTION 'Access denied to workshop payments';
  END IF;
  
  SELECT jsonb_agg(
    jsonb_build_object(
      'id', p.id,
      'amount_cents', p.amount_cents,
      'amount_euros', ROUND(p.amount_cents / 100.0, 2),
      'currency', p.currency,
      'status', p.status,
      'description', p.description,
      'analysis_month', p.analysis_month,
      'analyses_purchased', p.analyses_purchased,
      'payment_method', p.payment_method,
      'created_at', p.created_at,
      'paid_at', p.paid_at
    ) ORDER BY p.created_at DESC
  ) INTO payments_data
  FROM payments p
  WHERE p.workshop_id = target_workshop_id;
  
  RETURN COALESCE(payments_data, '[]'::JSONB);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función para obtener estadísticas de pagos para admin
CREATE OR REPLACE FUNCTION get_payment_statistics()
RETURNS JSONB AS $$
DECLARE
  stats JSONB;
BEGIN
  -- Verificar que el usuario sea admin
  IF NOT EXISTS (
    SELECT 1 FROM profiles 
    WHERE id = auth.uid() AND role = 'admin'
  ) THEN
    RAISE EXCEPTION 'Access denied - admin only';
  END IF;
  
  SELECT jsonb_build_object(
    'total_revenue_cents', COALESCE(SUM(CASE WHEN status = 'succeeded' THEN amount_cents ELSE 0 END), 0),
    'total_revenue_euros', ROUND(COALESCE(SUM(CASE WHEN status = 'succeeded' THEN amount_cents ELSE 0 END), 0) / 100.0, 2),
    'total_payments', COUNT(*),
    'successful_payments', COUNT(*) FILTER (WHERE status = 'succeeded'),
    'pending_payments', COUNT(*) FILTER (WHERE status = 'pending'),
    'failed_payments', COUNT(*) FILTER (WHERE status IN ('failed', 'canceled')),
    'current_month_revenue_cents', COALESCE(SUM(CASE 
      WHEN status = 'succeeded' AND analysis_month = TO_CHAR(NOW(), 'YYYY-MM') 
      THEN amount_cents ELSE 0 END), 0),
    'workshops_with_payments', COUNT(DISTINCT workshop_id) FILTER (WHERE status = 'succeeded')
  ) INTO stats
  FROM payments;
  
  RETURN stats;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;