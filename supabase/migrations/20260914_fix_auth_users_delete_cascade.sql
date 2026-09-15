-- Fix "Database error deleting user" en Authentication -> Delete user
--
-- Varias tablas referencian auth.users(id) sin ON DELETE, por lo que PostgreSQL
-- aplica NO ACTION y bloquea el borrado del usuario en cuanto tiene una fila hija.
-- Tablas afectadas: user_monthly_usage, stripe_payments, payments, system_settings.
--
-- Para las tablas de datos del usuario usamos CASCADE (la fila no tiene sentido
-- sin el usuario). Para system_settings.updated_by, que es solo una columna de
-- auditoria y es nullable, usamos SET NULL para no borrar la configuracion.

-- 1-4) Tablas conocidas. Se usa to_regclass para no fallar si alguna no existe
--      todavia en el entorno donde se aplica la migracion.
DO $fix$
DECLARE
  r RECORD;
BEGIN
  FOR r IN
    SELECT * FROM (VALUES
      ('user_monthly_usage'::text, 'user_id'::text, 'user_monthly_usage_user_id_fkey'::text, 'CASCADE'::text),
      ('stripe_payments',    'user_id',    'stripe_payments_user_id_fkey',    'CASCADE'),
      ('payments',           'user_id',    'payments_user_id_fkey',           'CASCADE'),
      ('system_settings',    'updated_by', 'system_settings_updated_by_fkey', 'SET NULL')
    ) AS v(tbl, col, con, action)
  LOOP
    CONTINUE WHEN to_regclass('public.' || quote_ident(r.tbl)) IS NULL;

    EXECUTE format('ALTER TABLE public.%I DROP CONSTRAINT IF EXISTS %I', r.tbl, r.con);
    EXECUTE format(
      'ALTER TABLE public.%I ADD CONSTRAINT %I FOREIGN KEY (%I) REFERENCES auth.users(id) ON DELETE %s',
      r.tbl, r.con, r.col, r.action
    );
    RAISE NOTICE 'public.%.% -> ON DELETE %', r.tbl, r.col, r.action;
  END LOOP;
END $fix$;

-- 5) Red de seguridad: cualquier otra FK hacia auth.users que haya quedado
--    con NO ACTION / RESTRICT se reconstruye automaticamente.
--    NOT NULL -> CASCADE, nullable -> SET NULL.
DO $$
DECLARE
  r RECORD;
  v_action TEXT;
BEGIN
  FOR r IN
    SELECT
      c.conname,
      n.nspname  AS table_schema,
      t.relname  AS table_name,
      a.attname  AS column_name,
      a.attnotnull AS col_not_null
    FROM pg_constraint c
    JOIN pg_class t       ON t.oid = c.conrelid
    JOIN pg_namespace n   ON n.oid = t.relnamespace
    JOIN pg_class ft      ON ft.oid = c.confrelid
    JOIN pg_namespace fn  ON fn.oid = ft.relnamespace
    JOIN pg_attribute a   ON a.attrelid = c.conrelid AND a.attnum = c.conkey[1]
    WHERE c.contype = 'f'
      AND fn.nspname = 'auth'
      AND ft.relname = 'users'
      AND c.confdeltype IN ('a', 'r')   -- a = NO ACTION, r = RESTRICT
      AND array_length(c.conkey, 1) = 1
      AND n.nspname NOT IN ('auth', 'storage', 'realtime', 'supabase_functions')
  LOOP
    v_action := CASE WHEN r.col_not_null THEN 'CASCADE' ELSE 'SET NULL' END;

    EXECUTE format(
      'ALTER TABLE %I.%I DROP CONSTRAINT %I',
      r.table_schema, r.table_name, r.conname
    );
    EXECUTE format(
      'ALTER TABLE %I.%I ADD CONSTRAINT %I FOREIGN KEY (%I) REFERENCES auth.users(id) ON DELETE %s',
      r.table_schema, r.table_name, r.conname, r.column_name, v_action
    );

    RAISE NOTICE 'FK % en %.%(%) -> ON DELETE %',
      r.conname, r.table_schema, r.table_name, r.column_name, v_action;
  END LOOP;
END $$;
