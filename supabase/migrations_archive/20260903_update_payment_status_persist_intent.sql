-- update_payment_status localiza el pago por stripe_session_id, pero no guardaba
-- nunca el payment intent real. payment-session inserta la fila antes de que
-- Stripe lo haya asignado y usa `session.payment_intent || session.id` como
-- fallback, asi que la columna podia quedarse con un `cs_...` para siempre.
--
-- Consecuencias de eso:
--   * update_payment_status_by_intent('pi_...') no encontraba la fila, dejando
--     inservible el handler de payment_intent.payment_failed.
--   * mark_payment_completed() buscaba un `cs_...` en user_monthly_usage.
--   * el trigger de balance registraba ese `cs_...` en el historial de compras.
--
-- Anadimos stripe_payment_intent_id_param al final y con DEFAULT NULL para que la
-- resolucion por nombre de PostgREST siga siendo univoca y la llamada de dos
-- argumentos de checkout.session.expired no se rompa.

-- La firma pasa de 6 a 7 argumentos: hay que soltar la de 6 para no dejar una
-- sobrecarga ambigua. Solo afecta a la variante por sesion
-- (TEXT, TEXT, TEXT, INTEGER, INTEGER, TEXT); la variante por payment intent
-- (TEXT, TEXT, TEXT, INTEGER, TEXT, TEXT) tiene otra firma y no se toca.
DROP FUNCTION IF EXISTS update_payment_status(TEXT, TEXT, TEXT, INTEGER, INTEGER, TEXT);

CREATE OR REPLACE FUNCTION update_payment_status(
  session_id_param TEXT,
  new_status TEXT,
  payment_method_param TEXT DEFAULT NULL,
  stripe_fee_cents_param INTEGER DEFAULT NULL,
  net_amount_cents_param INTEGER DEFAULT NULL,
  stripe_customer_id_param TEXT DEFAULT NULL,
  stripe_payment_intent_id_param TEXT DEFAULT NULL
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
    stripe_payment_intent_id = COALESCE(stripe_payment_intent_id_param, stripe_payment_intent_id),
    paid_at = CASE WHEN new_status = 'completed' THEN NOW() ELSE paid_at END,
    updated_at = NOW()
  WHERE stripe_session_id = session_id_param
  RETURNING * INTO payment_record;

  -- Si encontramos el pago, devolver user_id y payment_id
  IF payment_record.id IS NOT NULL THEN
    -- Si el pago fue exitoso, actualizar el estado en user_monthly_usage.
    -- Se lee de payment_record para usar el intent ya actualizado por el UPDATE.
    IF new_status = 'completed' THEN
      PERFORM mark_payment_completed(payment_record.stripe_payment_intent_id);
    END IF;

    -- Devolver los datos necesarios para el webhook
    RETURN QUERY SELECT payment_record.user_id, payment_record.id;
  ELSE
    -- Si no se encontró el pago, devolver NULL. El webhook detecta este caso y
    -- reconstruye la fila desde session.metadata.
    RETURN QUERY SELECT NULL::UUID, NULL::UUID;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

COMMENT ON FUNCTION update_payment_status(TEXT, TEXT, TEXT, INTEGER, INTEGER, TEXT, TEXT) IS
  'Actualiza un pago localizandolo por stripe_session_id y persiste el payment intent real. '
  'La invoca stripe-webhook en checkout.session.completed y checkout.session.expired. '
  'Devuelve (NULL, NULL) si no existe la fila, sin lanzar excepcion.';

-- Refrescar la cache de esquema de PostgREST para que vea la nueva firma.
NOTIFY pgrst, 'reload schema';
