-- Arreglar las políticas RLS para permitir que las funciones SECURITY DEFINER accedan a payments

-- Eliminar la política restrictiva actual
DROP POLICY IF EXISTS "System can manage payments" ON payments;

-- Crear una política que permita acceso a las funciones del sistema
-- Las funciones SECURITY DEFINER se ejecutan con el rol del propietario de la función
CREATE POLICY "System functions can manage payments" ON payments
  FOR ALL USING (
    -- Permitir acceso si no hay usuario autenticado (webhooks) 
    -- O si es una función del sistema (SECURITY DEFINER)
    auth.uid() IS NULL 
    OR 
    -- Permitir si es el propietario de la función (postgres/service_role)
    current_setting('role', true) = 'service_role'
    OR
    -- Permitir si es una función SECURITY DEFINER ejecutándose
    current_setting('request.jwt.claims', true)::json->>'role' = 'service_role'
  );

-- También crear una política específica para webhooks anónimos
CREATE POLICY "Anonymous webhooks can manage payments" ON payments
  FOR ALL USING (
    -- Permitir si no hay usuario autenticado (caso de webhooks)
    auth.uid() IS NULL
  );