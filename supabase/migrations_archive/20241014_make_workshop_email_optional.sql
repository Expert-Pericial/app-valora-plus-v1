-- Migración para hacer el email del workshop opcional
-- Fecha: 2024-10-14

-- 1. Modificar la tabla workshops para permitir email nulo
ALTER TABLE public.workshops 
ALTER COLUMN email DROP NOT NULL;

-- 2. Actualizar workshops existentes para separar conceptualmente el email del usuario del email del taller
-- Por ahora mantenemos los emails existentes, pero en el futuro los talleres podrán tener emails diferentes

-- 3. Comentario para clarificar el propósito de cada email
COMMENT ON COLUMN public.workshops.email IS 'Email comercial del taller (opcional). Puede ser diferente al email del usuario admin_mechanic.';
COMMENT ON COLUMN public.profiles.email IS 'Email del usuario para autenticación. Debe coincidir con auth.users.email.';

-- 4. Verificar la estructura actualizada
SELECT 
    'ESTRUCTURA ACTUALIZADA:' as status;

-- Mostrar la nueva estructura
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'workshops' 
    AND table_schema = 'public'
    AND column_name = 'email';