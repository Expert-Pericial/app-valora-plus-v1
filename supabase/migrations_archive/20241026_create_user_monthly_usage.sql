-- Crear tabla para el seguimiento del uso mensual de análisis por usuario
CREATE TABLE IF NOT EXISTS user_monthly_usage (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  year INTEGER NOT NULL,
  month INTEGER NOT NULL,
  analyses_count INTEGER DEFAULT 0,
  free_analyses_used INTEGER DEFAULT 0,
  paid_analyses_count INTEGER DEFAULT 0,
  total_amount_due DECIMAL(10,2) DEFAULT 0,
  payment_status VARCHAR(20) DEFAULT 'pending', -- pending, paid, overdue
  stripe_payment_intent_id TEXT, -- ID del payment intent de Stripe
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, year, month)
);

-- Crear índices para optimizar consultas
CREATE INDEX IF NOT EXISTS idx_user_monthly_usage_user_id ON user_monthly_usage(user_id);
CREATE INDEX IF NOT EXISTS idx_user_monthly_usage_year_month ON user_monthly_usage(year, month);
CREATE INDEX IF NOT EXISTS idx_user_monthly_usage_payment_status ON user_monthly_usage(payment_status);
CREATE INDEX IF NOT EXISTS idx_user_monthly_usage_stripe_payment ON user_monthly_usage(stripe_payment_intent_id);

-- Función para obtener o crear el registro de uso mensual del usuario actual
CREATE OR REPLACE FUNCTION get_or_create_monthly_usage(target_year INTEGER DEFAULT NULL, target_month INTEGER DEFAULT NULL)
RETURNS user_monthly_usage AS $$
DECLARE
  current_year INTEGER := COALESCE(target_year, EXTRACT(YEAR FROM NOW()));
  current_month INTEGER := COALESCE(target_month, EXTRACT(MONTH FROM NOW()));
  usage_record user_monthly_usage;
BEGIN
  -- Intentar obtener el registro existente
  SELECT * INTO usage_record 
  FROM user_monthly_usage 
  WHERE user_id = auth.uid() 
    AND year = current_year 
    AND month = current_month;
  
  -- Si no existe, crearlo
  IF NOT FOUND THEN
    INSERT INTO user_monthly_usage (user_id, year, month)
    VALUES (auth.uid(), current_year, current_month)
    RETURNING * INTO usage_record;
  END IF;
  
  RETURN usage_record;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función para incrementar el conteo de análisis
CREATE OR REPLACE FUNCTION increment_analysis_count()
RETURNS JSONB AS $$
DECLARE
  current_year INTEGER := EXTRACT(YEAR FROM NOW());
  current_month INTEGER := EXTRACT(MONTH FROM NOW());
  usage_record user_monthly_usage;
  free_limit INTEGER;
  additional_price DECIMAL(10,2);
  is_free_analysis BOOLEAN := FALSE;
  amount_to_charge DECIMAL(10,2) := 0;
  current_total_analyses INTEGER := 0;
  user_workshop_id UUID;
BEGIN
  -- Obtener configuraciones del sistema
  SELECT (get_system_setting('monthly_free_analyses_limit')->>'value')::INTEGER INTO free_limit;
  SELECT (get_system_setting('additional_analysis_price')->>'value')::DECIMAL INTO additional_price;
  
  -- Obtener el workshop_id del usuario actual
  SELECT workshop_id INTO user_workshop_id 
  FROM profiles 
  WHERE id = auth.uid();
  
  -- Contar análisis reales del mes actual (antes de crear el nuevo)
  SELECT COUNT(*) INTO current_total_analyses
  FROM analysis 
  WHERE workshop_id = user_workshop_id
    AND EXTRACT(YEAR FROM created_at) = current_year
    AND EXTRACT(MONTH FROM created_at) = current_month;
  
  -- Determinar si este análisis es gratuito o de pago basado en el conteo real
  IF current_total_analyses < free_limit THEN
    is_free_analysis := TRUE;
  ELSE
    amount_to_charge := additional_price;
  END IF;
  
  -- Obtener o crear registro de uso mensual
  SELECT * INTO usage_record FROM get_or_create_monthly_usage(current_year, current_month);
  
  -- Solo actualizar el total_amount_due si hay cargo
  IF amount_to_charge > 0 THEN
    UPDATE user_monthly_usage 
    SET 
      total_amount_due = total_amount_due + amount_to_charge,
      updated_at = NOW()
    WHERE user_id = auth.uid() 
      AND year = current_year 
      AND month = current_month;
  END IF;
  
  -- Retornar información sobre el análisis
  RETURN jsonb_build_object(
    'is_free', is_free_analysis,
    'amount_charged', amount_to_charge,
    'total_analyses', current_total_analyses + 1,
    'free_analyses_used', LEAST(current_total_analyses + 1, free_limit),
    'free_analyses_limit', free_limit
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función para obtener el uso mensual actual del usuario
CREATE OR REPLACE FUNCTION get_current_monthly_usage()
RETURNS JSONB AS $$
DECLARE
  current_year INTEGER := EXTRACT(YEAR FROM NOW());
  current_month INTEGER := EXTRACT(MONTH FROM NOW());
  usage_record user_monthly_usage;
  free_limit INTEGER;
  actual_total_analyses INTEGER := 0;
  actual_free_analyses INTEGER := 0;
  actual_paid_analyses INTEGER := 0;
  user_workshop_id UUID;
BEGIN
  -- Obtener configuraciones del sistema
  SELECT (get_system_setting('monthly_free_analyses_limit')->>'value')::INTEGER INTO free_limit;
  
  -- Obtener el workshop_id del usuario actual
  SELECT workshop_id INTO user_workshop_id 
  FROM profiles 
  WHERE id = auth.uid();
  
  -- Contar análisis reales del mes actual desde la tabla analysis
  SELECT COUNT(*) INTO actual_total_analyses
  FROM analysis 
  WHERE workshop_id = user_workshop_id
    AND EXTRACT(YEAR FROM created_at) = current_year
    AND EXTRACT(MONTH FROM created_at) = current_month;
  
  -- Calcular análisis gratuitos y de pago basado en el límite
  actual_free_analyses := LEAST(actual_total_analyses, free_limit);
  actual_paid_analyses := GREATEST(0, actual_total_analyses - free_limit);
  
  -- Obtener registro de uso mensual (crear si no existe) para obtener payment_status y total_amount_due
  SELECT * INTO usage_record FROM get_or_create_monthly_usage(current_year, current_month);
  
  RETURN jsonb_build_object(
    'total_analyses', actual_total_analyses,
    'free_analyses_used', actual_free_analyses,
    'paid_analyses_count', actual_paid_analyses,
    'free_analyses_limit', free_limit,
    'remaining_free_analyses', GREATEST(0, free_limit - actual_free_analyses),
    'total_amount_due', usage_record.total_amount_due,
    'payment_status', usage_record.payment_status,
    'year', current_year,
    'month', current_month
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función para marcar un pago como completado
CREATE OR REPLACE FUNCTION mark_payment_completed(stripe_payment_intent_id TEXT)
RETURNS BOOLEAN AS $$
BEGIN
  UPDATE user_monthly_usage 
  SET 
    payment_status = 'paid',
    updated_at = NOW()
  WHERE stripe_payment_intent_id = stripe_payment_intent_id;
  
  RETURN FOUND;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Políticas RLS para user_monthly_usage
ALTER TABLE user_monthly_usage ENABLE ROW LEVEL SECURITY;

-- Los usuarios pueden ver y modificar solo sus propios registros
CREATE POLICY "Users can manage their own monthly usage" ON user_monthly_usage
  FOR ALL USING (user_id = auth.uid());

-- Los admins pueden ver todos los registros
CREATE POLICY "Admins can view all monthly usage" ON user_monthly_usage
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = auth.uid() 
      AND profiles.role = 'admin'
    )
  );

-- Trigger para actualizar updated_at
CREATE OR REPLACE FUNCTION update_user_monthly_usage_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_user_monthly_usage_updated_at
  BEFORE UPDATE ON user_monthly_usage
  FOR EACH ROW
  EXECUTE FUNCTION update_user_monthly_usage_updated_at();

-- Constraint para validar el estado de pago
ALTER TABLE user_monthly_usage 
ADD CONSTRAINT check_payment_status 
CHECK (payment_status IN ('pending', 'paid', 'overdue', 'failed'));

-- Constraint para validar mes y año
ALTER TABLE user_monthly_usage 
ADD CONSTRAINT check_month_range 
CHECK (month >= 1 AND month <= 12);

ALTER TABLE user_monthly_usage 
ADD CONSTRAINT check_year_range 
CHECK (year >= 2024 AND year <= 2100);