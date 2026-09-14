-- Continuacion de 20260806_fix_analysis_and_packages_rls.sql.
--
-- Las politicas de vehicle_data e insurance_amounts (20241020_create_extracted_data_tables.sql)
-- filtran por:
--     analysis_id IN (SELECT id FROM analysis WHERE workshop_id = auth.uid())
-- es decir, comparan un uuid de taller con un uuid de usuario: nunca es cierto.
-- El cliente escribe en las dos tablas con la sesion del usuario en ambas rutas del
-- flujo -- la normal de n8n (NewAnalysis.tsx:232 y :270) y el fallback de IA
-- (:670 y :707) -- y tambien las lee/actualiza en Verification.tsx y Results.tsx,
-- asi que el guardado de los datos extraidos fallaba con 42501 aunque el INSERT en
-- analysis ya funcione.
--
-- Se anaden politicas equivalentes que cuelgan de analysis.user_id, sumandose (OR) a
-- las existentes. La subconsulta a analysis se apoya en la politica
-- "Users can view their own analysis" creada en la migracion anterior.

DROP POLICY IF EXISTS "Users can view their own vehicle data v2" ON vehicle_data;
CREATE POLICY "Users can view their own vehicle data v2" ON vehicle_data
    FOR SELECT USING (
        analysis_id IN (SELECT id FROM analysis WHERE user_id = auth.uid())
    );

DROP POLICY IF EXISTS "Users can insert their own vehicle data v2" ON vehicle_data;
CREATE POLICY "Users can insert their own vehicle data v2" ON vehicle_data
    FOR INSERT WITH CHECK (
        analysis_id IN (SELECT id FROM analysis WHERE user_id = auth.uid())
    );

DROP POLICY IF EXISTS "Users can update their own vehicle data v2" ON vehicle_data;
CREATE POLICY "Users can update their own vehicle data v2" ON vehicle_data
    FOR UPDATE USING (
        analysis_id IN (SELECT id FROM analysis WHERE user_id = auth.uid())
    )
    WITH CHECK (
        analysis_id IN (SELECT id FROM analysis WHERE user_id = auth.uid())
    );

DROP POLICY IF EXISTS "Users can view their own insurance amounts v2" ON insurance_amounts;
CREATE POLICY "Users can view their own insurance amounts v2" ON insurance_amounts
    FOR SELECT USING (
        analysis_id IN (SELECT id FROM analysis WHERE user_id = auth.uid())
    );

DROP POLICY IF EXISTS "Users can insert their own insurance amounts v2" ON insurance_amounts;
CREATE POLICY "Users can insert their own insurance amounts v2" ON insurance_amounts
    FOR INSERT WITH CHECK (
        analysis_id IN (SELECT id FROM analysis WHERE user_id = auth.uid())
    );

DROP POLICY IF EXISTS "Users can update their own insurance amounts v2" ON insurance_amounts;
CREATE POLICY "Users can update their own insurance amounts v2" ON insurance_amounts
    FOR UPDATE USING (
        analysis_id IN (SELECT id FROM analysis WHERE user_id = auth.uid())
    )
    WITH CHECK (
        analysis_id IN (SELECT id FROM analysis WHERE user_id = auth.uid())
    );

-- Desactivar los paquetes de ejemplo que sembro 20250123_create_analysis_packages.sql.
-- Estan en euros (total_price 15.00, 142.50, 675.00, 1275.00, 6000.00) mientras que
-- los paquetes reales estan en centimos (Pack Individual = 1000 = 10 EUR), y
-- payment-session/index.ts:140 pasa total_price tal cual a Stripe como unit_amount:
-- cobrarian 0,15 EUR, 1,43 EUR, etc. Los 4 'Pack ...' reales siguen activos.
UPDATE analysis_packages
SET is_active = false
WHERE name IN (
    'Análisis Individual',
    'Paquete Básico',
    'Paquete Estándar',
    'Paquete Premium',
    'Paquete Empresarial'
);
