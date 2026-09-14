-- Simplificar la tabla user_monthly_usage eliminando campos redundantes
-- Ahora que contamos directamente desde la tabla analysis, estos campos ya no son necesarios

-- Eliminar columnas redundantes que ahora se calculan dinámicamente
ALTER TABLE user_monthly_usage 
DROP COLUMN IF EXISTS analyses_count,
DROP COLUMN IF EXISTS free_analyses_used,
DROP COLUMN IF EXISTS paid_analyses_count;

-- Actualizar la función get_or_create_monthly_usage para no inicializar estos campos
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
  
  -- Si no existe, crear uno nuevo
  IF NOT FOUND THEN
    INSERT INTO user_monthly_usage (
      user_id, 
      year, 
      month,
      total_amount_due,
      payment_status
    ) VALUES (
      auth.uid(), 
      current_year, 
      current_month,
      0,
      'pending'
    ) RETURNING * INTO usage_record;
  END IF;
  
  RETURN usage_record;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Comentario explicativo sobre el nuevo enfoque
COMMENT ON TABLE user_monthly_usage IS 'Tabla simplificada para seguimiento de pagos mensuales. Los conteos de análisis se calculan dinámicamente desde la tabla analysis.';
COMMENT ON COLUMN user_monthly_usage.total_amount_due IS 'Monto total adeudado por análisis de pago del mes';
COMMENT ON COLUMN user_monthly_usage.payment_status IS 'Estado del pago: pending, paid, overdue';
COMMENT ON COLUMN user_monthly_usage.stripe_payment_intent_id IS 'ID del payment intent de Stripe para este mes';