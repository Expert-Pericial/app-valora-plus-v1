# Migraciones de base de datos

El esquema de la base de datos se versiona en `supabase/migrations/` y se aplica con la Supabase CLI
(instalada como devDependency, se usa con `npx supabase`).

**Regla:** ningún cambio de esquema (tablas, columnas, funciones, RLS, triggers) se hace directo en el
dashboard de Supabase. Todo cambio pasa por un archivo de migración.

## Configuración inicial (una vez por máquina)

```bash
npm install
npx supabase login                                     # abre el navegador, guarda el access token
npx supabase link --project-ref rygxfjsxvejrgymbxcfw   # pide la contraseña de la base de datos
```

## Flujo para un cambio

```bash
npm run db:new -- add_campo_x_a_analysis   # crea supabase/migrations/<timestamp>_add_campo_x_a_analysis.sql
# escribir el SQL en ese archivo
npm run db:push:dry                        # muestra qué migraciones se aplicarían
npm run db:push                            # aplica las migraciones pendientes
npm run db:types                           # regenera src/integrations/supabase/types.ts
```

Commitear juntos la migración y los tipos regenerados.

## Scripts

| Script | Qué hace |
| --- | --- |
| `db:new <nombre>` | Crea un archivo de migración vacío |
| `db:status` | Compara migraciones locales con las aplicadas en remoto |
| `db:push:dry` | Simula `db:push` sin aplicar nada |
| `db:push` | Aplica migraciones pendientes al proyecto vinculado |
| `db:types` | Regenera los tipos TypeScript desde el esquema remoto |

Ninguno necesita Docker. `supabase db pull`, `db diff`, `db dump` y `start` sí lo necesitan.

## Buenas prácticas

- Una migración aplicada no se edita: si hay un error, se crea otra migración que lo corrija.
- Escribir SQL idempotente cuando sea razonable (`if not exists`, `create or replace`).
- No incluir datos reales de usuarios en migraciones ni en el repo.

## Historial

`supabase/migrations_archive/` guarda las migraciones anteriores al baseline. Tenían versiones
duplicadas y no reflejaban exactamente producción, así que no se aplican. El estado real de
producción queda capturado en la migración `*_baseline.sql`.
