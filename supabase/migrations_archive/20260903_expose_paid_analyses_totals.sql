-- get_current_monthly_usage ya consultaba get_paid_analyses_balance (que devuelve
-- total_purchased y total_used), pero solo exponia remaining_analyses en el JSON.
-- use-analysis-balance.ts leia `total_paid_analyses`, una clave que nunca existio,
-- asi que totalPaidAnalysesPurchased era siempre 0 y la linea
-- "X usados de Y comprados" de la tarjeta de balance no se renderizaba jamas.
--
-- Anadimos las dos claves que faltaban. `paid_analyses_count` se deja intacta
-- porque significa otra cosa (analisis de ESTE mes por encima del limite gratuito)
-- y la consume use-monthly-usage.ts.
--
--   total_paid_analyses       -> total historico de analisis comprados
--   total_paid_analyses_used  -> total historico de analisis pagados consumidos

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
  total_paid_purchased INTEGER := 0;
  total_paid_used INTEGER := 0;
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
    total_paid_purchased := paid_balance_record.total_purchased;
    total_paid_used := paid_balance_record.total_used;
  ELSE
    remaining_paid_analyses := 0;
    total_paid_purchased := 0;
    total_paid_used := 0;
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
    'total_paid_analyses', total_paid_purchased,
    'total_paid_analyses_used', total_paid_used,
    'total_amount_due', usage_record.total_amount_due,
    'payment_status', usage_record.payment_status,
    'year', current_year,
    'month', current_month
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

COMMENT ON FUNCTION get_current_monthly_usage() IS
  'Devuelve el balance de analisis del usuario actual. Los gratuitos se cuentan por '
  'taller (analysis.workshop_id); el saldo pagado es por usuario (auth.uid()).';
