-- Arreglar los dos 42501 de la seccion de analisis.
--
-- 1) get_active_packages() devolvia 403 "permission denied for table users".
--    La politica de admin de analysis_packages consulta auth.users, tabla sobre la
--    que anon/authenticated no tienen SELECT. Al ser FOR ALL tambien se evalua en
--    los SELECT que hace la funcion (que no es SECURITY DEFINER), asi que la
--    lectura entera abortaba. Mismo bug que ya se corrigio para workshops en
--    20241016_fix_all_rls_policies.sql: comprobar el rol via auth.jwt().
--
-- 2) El INSERT en analysis devolvia 403 "new row violates row-level security
--    policy". Las politicas de 20241019_create_analysis_table.sql solo aceptan
--    filas cuyo workshop_id pertenezca al taller del perfil, pero el esquema
--    cambio despues: workshop_id es NULLABLE y se anadio analysis.user_id NOT NULL
--    (ver el bloque de reconciliacion de database_schema.sql). Para un usuario sin
--    taller el WITH CHECK evalua NULL IN (...) -> NULL, y RLS rechaza.
--    Se anaden politicas por user_id que se suman (OR) a las existentes por taller.

-- 1) analysis_packages: politica de admin sin acceso a auth.users
DROP POLICY IF EXISTS "Admins can manage analysis packages" ON analysis_packages;
DROP POLICY IF EXISTS "Admins can manage analysis packages v2" ON analysis_packages;

CREATE POLICY "Admins can manage analysis packages v2" ON analysis_packages
    FOR ALL USING (
        (auth.jwt() ->> 'user_metadata')::jsonb ->> 'role' = 'admin'
        OR
        (auth.jwt() ->> 'raw_user_meta_data')::jsonb ->> 'role' = 'admin'
    );

-- La politica de lectura publica ("Anyone can view active analysis packages",
-- USING (is_active = true)) se deja intacta: es la que sirve a get_active_packages().

-- 2) analysis: politicas por user_id
DROP POLICY IF EXISTS "Users can view their own analysis" ON analysis;
CREATE POLICY "Users can view their own analysis" ON analysis
    FOR SELECT USING (user_id = auth.uid());

DROP POLICY IF EXISTS "Users can insert their own analysis" ON analysis;
CREATE POLICY "Users can insert their own analysis" ON analysis
    FOR INSERT WITH CHECK (
        user_id = auth.uid()
        AND (
            workshop_id IS NULL
            OR workshop_id IN (SELECT workshop_id FROM profiles WHERE id = auth.uid())
        )
    );

DROP POLICY IF EXISTS "Users can update their own analysis" ON analysis;
CREATE POLICY "Users can update their own analysis" ON analysis
    FOR UPDATE USING (user_id = auth.uid())
    WITH CHECK (
        user_id = auth.uid()
        AND (
            workshop_id IS NULL
            OR workshop_id IN (SELECT workshop_id FROM profiles WHERE id = auth.uid())
        )
    );
