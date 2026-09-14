-- Update get_current_monthly_usage to include paid analyses balance
CREATE OR REPLACE FUNCTION get_current_monthly_usage()
RETURNS JSONB AS $$
DECLARE
  current_year INTEGER := EXTRACT(YEAR FROM NOW());
  current_month INTEGER := EXTRACT(MONTH FROM NOW());
  usage_record user_monthly_usage;
  paid_balance_record RECORD;
  free_limit INTEGER;
  actual_total_analyses INTEGER := 0;
  actual_free_analyses INTEGER := 0;
  actual_paid_analyses INTEGER := 0;
  user_workshop_id UUID;
  remaining_paid_analyses INTEGER := 0;
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
  
  -- Obtener balance de análisis pagados
  SELECT * INTO paid_balance_record 
  FROM get_paid_analyses_balance(auth.uid()) 
  LIMIT 1;
  
  IF paid_balance_record IS NOT NULL THEN
    remaining_paid_analyses := paid_balance_record.remaining_analyses;
  ELSE
    remaining_paid_analyses := 0;
  END IF;
  
  -- Obtener registro de uso mensual (crear si no existe) para obtener payment_status y total_amount_due
  SELECT * INTO usage_record FROM get_or_create_monthly_usage(current_year, current_month);
  
  RETURN jsonb_build_object(
    'total_analyses', actual_total_analyses,
    'free_analyses_used', actual_free_analyses,
    'paid_analyses_count', actual_paid_analyses,
    'free_analyses_limit', free_limit,
    'remaining_free_analyses', GREATEST(0, free_limit - actual_free_analyses),
    'remaining_paid_analyses', remaining_paid_analyses,
    'total_amount_due', usage_record.total_amount_due,
    'payment_status', usage_record.payment_status,
    'year', current_year,
    'month', current_month
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Update increment_analysis_count to consume paid analyses when free analyses are exhausted
CREATE OR REPLACE FUNCTION increment_analysis_count()
RETURNS JSONB AS $$
DECLARE
  current_year INTEGER := EXTRACT(YEAR FROM NOW());
  current_month INTEGER := EXTRACT(MONTH FROM NOW());
  usage_record user_monthly_usage;
  free_limit INTEGER;
  additional_price DECIMAL;
  billing_enabled BOOLEAN;
  current_total_analyses INTEGER := 0;
  user_workshop_id UUID;
  is_free_analysis BOOLEAN := FALSE;
  amount_to_charge DECIMAL := 0;
  paid_analysis_consumed BOOLEAN := FALSE;
  remaining_paid_analyses INTEGER := 0;
BEGIN
  -- Obtener configuraciones del sistema
  SELECT (get_system_setting('monthly_free_analyses_limit')->>'value')::INTEGER INTO free_limit;
  SELECT (get_system_setting('additional_analysis_price')->>'value')::DECIMAL INTO additional_price;
  SELECT (get_system_setting('billing_enabled')->>'value')::BOOLEAN INTO billing_enabled;
  
  -- Obtener el workshop_id del usuario actual
  SELECT workshop_id INTO user_workshop_id 
  FROM profiles 
  WHERE id = auth.uid();
  
  -- Contar análisis reales del mes actual
  SELECT COUNT(*) INTO current_total_analyses
  FROM analysis 
  WHERE workshop_id = user_workshop_id
    AND EXTRACT(YEAR FROM created_at) = current_year
    AND EXTRACT(MONTH FROM created_at) = current_month;
  
  -- Determinar si este análisis es gratuito, de pago con balance, o requiere pago
  IF current_total_analyses < free_limit THEN
    -- Análisis gratuito
    is_free_analysis := TRUE;
  ELSE
    -- Análisis de pago - intentar consumir del balance primero
    SELECT consume_paid_analysis(auth.uid()) INTO paid_analysis_consumed;
    
    IF paid_analysis_consumed THEN
      -- Se consumió un análisis del balance pagado
      is_free_analysis := FALSE;
      amount_to_charge := 0;
    ELSE
      -- No hay balance pagado, cobrar si la facturación está habilitada
      IF billing_enabled THEN
        amount_to_charge := additional_price;
      END IF;
    END IF;
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
  
  -- Obtener análisis pagados restantes después de la operación
  SELECT remaining_analyses INTO remaining_paid_analyses
  FROM get_paid_analyses_balance(auth.uid())
  LIMIT 1;
  
  IF remaining_paid_analyses IS NULL THEN
    remaining_paid_analyses := 0;
  END IF;
  
  -- Retornar información sobre el análisis
  RETURN jsonb_build_object(
    'is_free', is_free_analysis,
    'paid_analysis_consumed', paid_analysis_consumed,
    'amount_charged', amount_to_charge,
    'total_analyses', current_total_analyses + 1,
    'free_analyses_used', LEAST(current_total_analyses + 1, free_limit),
    'free_analyses_limit', free_limit,
    'remaining_paid_analyses', remaining_paid_analyses
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to check if user can create analysis (considering both free and paid analyses)
CREATE OR REPLACE FUNCTION can_user_create_analysis()
RETURNS JSONB AS $$
DECLARE
  current_year INTEGER := EXTRACT(YEAR FROM NOW());
  current_month INTEGER := EXTRACT(MONTH FROM NOW());
  free_limit INTEGER;
  billing_enabled BOOLEAN;
  current_total_analyses INTEGER := 0;
  user_workshop_id UUID;
  remaining_paid_analyses INTEGER := 0;
  can_create BOOLEAN := FALSE;
  reason TEXT := '';
BEGIN
  -- Obtener configuraciones del sistema
  SELECT (get_system_setting('monthly_free_analyses_limit')->>'value')::INTEGER INTO free_limit;
  SELECT (get_system_setting('billing_enabled')->>'value')::BOOLEAN INTO billing_enabled;
  
  -- Obtener el workshop_id del usuario actual
  SELECT workshop_id INTO user_workshop_id 
  FROM profiles 
  WHERE id = auth.uid();
  
  -- Contar análisis reales del mes actual
  SELECT COUNT(*) INTO current_total_analyses
  FROM analysis 
  WHERE workshop_id = user_workshop_id
    AND EXTRACT(YEAR FROM created_at) = current_year
    AND EXTRACT(MONTH FROM created_at) = current_month;
  
  -- Obtener análisis pagados restantes
  SELECT remaining_analyses INTO remaining_paid_analyses
  FROM get_paid_analyses_balance(auth.uid())
  LIMIT 1;
  
  IF remaining_paid_analyses IS NULL THEN
    remaining_paid_analyses := 0;
  END IF;
  
  -- Determinar si puede crear análisis
  IF current_total_analyses < free_limit THEN
    -- Tiene análisis gratuitos disponibles
    can_create := TRUE;
    reason := 'free_analysis_available';
  ELSIF remaining_paid_analyses > 0 THEN
    -- Tiene análisis pagados disponibles
    can_create := TRUE;
    reason := 'paid_analysis_available';
  ELSIF billing_enabled THEN
    -- Puede pagar por análisis adicional
    can_create := TRUE;
    reason := 'payment_required';
  ELSE
    -- No puede crear más análisis
    can_create := FALSE;
    reason := 'limit_reached_billing_disabled';
  END IF;
  
  RETURN jsonb_build_object(
    'can_create', can_create,
    'reason', reason,
    'free_analyses_used', LEAST(current_total_analyses, free_limit),
    'free_analyses_limit', free_limit,
    'remaining_free_analyses', GREATEST(0, free_limit - current_total_analyses),
    'remaining_paid_analyses', remaining_paid_analyses,
    'billing_enabled', billing_enabled
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant permissions for the new function
GRANT EXECUTE ON FUNCTION can_user_create_analysis() TO authenticated;