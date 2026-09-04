# Configuración de Stripe para Valora Plus

Proyecto Supabase: `rygxfjsxvejrgymbxcfw`

## 1. Secretos de las Edge Functions

`SUPABASE_URL` y `SUPABASE_SERVICE_ROLE_KEY` los inyecta Supabase automáticamente
(el prefijo `SUPABASE_` está reservado). Solo hay que dar de alta los de Stripe.

El fichero `.env` de la raíz **no llega a las Edge Functions**: solo alimenta el
bundle de Vite. Los secretos del webhook viven exclusivamente en Supabase.

Crea `supabase/secrets.env.local` (ignorado por git) con:

```
STRIPE_SECRET_KEY=sk_test_...
STRIPE_WEBHOOK_SECRET=whsec_...
```

Y súbelos:

```powershell
supabase secrets set --env-file supabase/secrets.env.local --project-ref rygxfjsxvejrgymbxcfw
supabase secrets list --project-ref rygxfjsxvejrgymbxcfw
```

> PowerShell usa backtick (`` ` ``) como continuación de línea, no `\`.

## 2. Desplegar las Edge Functions

```powershell
supabase functions deploy payment-session stripe-webhook get-next-analysis-cost --project-ref rygxfjsxvejrgymbxcfw
```

Los secretos se leen al arrancar la función: **si los cambias, hay que redesplegar.**

`verify_jwt` está fijado en `config.toml`. `stripe-webhook` va con `false`
(Stripe no manda JWT de Supabase) y `payment-session` con `true` (crea cobros a
nombre del usuario autenticado).

## 3. Endpoint del webhook en Stripe

URL:

```
https://rygxfjsxvejrgymbxcfw.supabase.co/functions/v1/stripe-webhook
```

**No es `valora.plus`.** Ese dominio sirve la SPA estática (`try_files ... /index.html`),
así que un POST devolvería el HTML del index con un 200 y Stripe daría el evento
por entregado mientras el pago no se procesa.

Dashboard → Developers → Webhooks → Add endpoint, con **estos tres eventos y no más**:

- `checkout.session.completed`
- `checkout.session.expired`
- `payment_intent.payment_failed`

No añadas `payment_intent.succeeded` ni `charge.succeeded`: duplican el primero y
se retiraron a propósito (ver `20250121_webhook_simplification.sql`). Cualquier otro
evento cae en el `default` del `switch` y solo genera ruido en los logs.

El payload debe ser el **snapshot** (objeto completo): el handler lee
`event.data.object` como una `Checkout.Session` entera. Con payload *thin* no funciona.

Copia el *Signing secret* (`whsec_...`) al paso 1 y redespliega.

### Test y live no pueden convivir

Solo hay un proyecto de Supabase y `STRIPE_WEBHOOK_SECRET` guarda un único valor.
Cada modo de Stripe emite su propio `whsec_`, así que el destino del modo que no
coincida fallará la verificación de firma con 400. Valida en test, y al pasar a
live cambia `STRIPE_SECRET_KEY` y `STRIPE_WEBHOOK_SECRET`, y desactiva el destino de test.

## 4. URLs de retorno

`payment-session` lee `stripe_success_url` / `stripe_cancel_url` de `system_settings`
y les añade `?session_id={CHECKOUT_SESSION_ID}`. Si están vacías cae al `origin` de
la petición, que en producción puede no ser el dominio correcto.

```sql
SELECT stripe_success_url, stripe_cancel_url FROM system_settings;
```

## Flujo de pago

1. El usuario se queda sin análisis disponibles (gratuitos + pagados).
2. `NewAnalysis` abre el modal de paquetes; `MyAccount` ofrece "Ver Paquetes" a `admin_mechanic`.
3. El frontend llama a **`payment-session`** con `package_id`.
4. Esa función crea la Checkout Session e **inserta la fila en `payments`** con
   `status = 'pending'` usando service role. Si el insert falla, devuelve 500 y no
   entrega la URL: mejor un pago que no arranca que uno cobrado sin registrar.
5. Se redirige al usuario a Stripe Checkout.
6. Stripe envía `checkout.session.completed` a **`stripe-webhook`**.
7. El webhook llama a `update_payment_status`, que localiza el pago por
   `stripe_session_id`, lo pasa a `completed` y persiste el `payment_intent` real.
   Si no encuentra la fila, la reconstruye desde `session.metadata` y reintenta.
8. El trigger `trigger_payment_completion_add_balance` ejecuta `add_paid_analyses`
   en la transición `pending → completed`, acreditando el saldo. Es idempotente:
   los reintentos de Stripe no duplican análisis.
9. El usuario vuelve a `/payment-success`.

## Funciones Edge

| Función | verify_jwt | Propósito |
|---|---|---|
| `payment-session` | true | Crea la Checkout Session y la fila de `payments`. La que usa el frontend. |
| `stripe-webhook` | false | Procesa los eventos de Stripe y cierra el pago. |
| `get-next-analysis-cost` | true | Devuelve el coste del próximo análisis. |
| `create-payment-session` | true | **Sin usar.** Variante antigua que fija `analyses_purchased = 1` y no acepta `package_id`. |

## Pruebas

Con las claves de test, tarjeta `4242 4242 4242 4242` (cualquier fecha futura y CVC).
Para pagos fallidos, `4000 0000 0000 0002`.

Para llegar al modal de compra teniendo gratuitos, baja el límite temporalmente:

```sql
UPDATE system_settings SET setting_value = '{"value": 0}'
WHERE setting_key = 'monthly_free_analyses_limit';
```

Verificación tras pagar:

```sql
SELECT status, stripe_session_id, stripe_payment_intent_id, stripe_fee_cents, net_amount_cents
FROM payments ORDER BY created_at DESC LIMIT 1;

SELECT remaining_analyses, total_purchased, purchase_history
FROM user_paid_analyses_balance WHERE user_id = '<uuid>';
```

`status` debe ser `completed`, el intent empezar por `pi_` y las comisiones traer
valores reales. En Stripe el evento debe figurar con **200** y una sola entrega.

Logs:

```powershell
supabase functions logs stripe-webhook --project-ref rygxfjsxvejrgymbxcfw
```

Los `RAISE LOG` del trigger salen en **Database → Logs**, no en los de la función.

El Stripe CLI (`stripe listen`) solo sirve si está logueado en la misma cuenta que
la `sk_` configurada; si no, escucha eventos de otra cuenta. Evita
`stripe trigger checkout.session.completed`: fabrica una sesión sintética que no
existe en `payments`, así que solo ejercita la rama de autocuración.
