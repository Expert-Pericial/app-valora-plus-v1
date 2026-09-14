-- Arreglos necesarios para que el webhook de Stripe funcione end-to-end.
--
-- 1. mark_payment_completed tenía el parámetro con el mismo nombre que la columna
--    user_monthly_usage.stripe_payment_intent_id, así que el WHERE era una referencia
--    ambigua y Postgres abortaba la función en tiempo de ejecución. Como
--    update_payment_status la invoca en cada pago completado, el webhook devolvía 500
--    y Stripe reintentaba indefinidamente.
--
-- 2. update_payment_status_by_intent no existía, pero stripe-webhook la llama al
--    procesar payment_intent.payment_failed.

-- ---------------------------------------------------------------------------
-- 1. mark_payment_completed: renombrar el parámetro
-- ---------------------------------------------------------------------------
-- CREATE OR REPLACE no permite cambiar el nombre de un parámetro, hay que soltarla.
DROP FUNCTION IF EXISTS mark_payment_completed(TEXT);

CREATE OR REPLACE FUNCTION mark_payment_completed(payment_intent_id_param TEXT)
RETURNS BOOLEAN AS $$
BEGIN
  UPDATE user_monthly_usage
  SET
    payment_status = 'paid',
    updated_at = NOW()
  WHERE stripe_payment_intent_id = payment_intent_id_param;

  RETURN FOUND;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

COMMENT ON FUNCTION mark_payment_completed(TEXT) IS
  'Marca como pagado el registro mensual asociado a un payment intent de Stripe.';

-- ---------------------------------------------------------------------------
-- 2. update_payment_status_by_intent
-- ---------------------------------------------------------------------------
-- Equivalente a update_payment_status pero localizando el pago por
-- stripe_payment_intent_id en lugar de por stripe_session_id. La usa el webhook
-- para payment_intent.payment_failed, donde Stripe no envía la checkout session.
CREATE OR REPLACE FUNCTION update_payment_status_by_intent(
  payment_intent_id_param TEXT,
  new_status TEXT
)
RETURNS TABLE(user_id UUID, payment_id UUID) AS $$
DECLARE
  payment_record payments;
BEGIN
  UPDATE payments
  SET
    status = new_status,
    paid_at = CASE WHEN new_status = 'completed' THEN NOW() ELSE paid_at END,
    updated_at = NOW()
  WHERE stripe_payment_intent_id = payment_intent_id_param
  RETURNING * INTO payment_record;

  IF payment_record.id IS NOT NULL THEN
    IF new_status = 'completed' THEN
      PERFORM mark_payment_completed(payment_record.stripe_payment_intent_id);
    END IF;

    RETURN QUERY SELECT payment_record.user_id, payment_record.id;
  ELSE
    RETURN QUERY SELECT NULL::UUID, NULL::UUID;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

COMMENT ON FUNCTION update_payment_status_by_intent(TEXT, TEXT) IS
  'Actualiza el estado de un pago localizándolo por payment intent de Stripe.';
