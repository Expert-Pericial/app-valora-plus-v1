-- Migración para corregir inconsistencias de datos y asegurar roles correctos
-- Fecha: 2024-10-13
-- Versión compatible con Supabase Cloud

-- 1. Primero, corregir el perfil del admin (eliminar workshop_name que ya no existe)
UPDATE public.profiles 
SET workshop_id = NULL 
WHERE email = 'admin@valoraplus.com' AND role = 'admin';

-- 2. Crear workshops de ejemplo (si no existen)
INSERT INTO public.workshops (id, name, email, phone, address) VALUES 
(
    '550e8400-e29b-41d4-a716-446655440000', 
    'Taller Mecánico Demo', 
    'demo@tallerdemo.com', 
    '612 345 678',
    'Calle Principal 123, Madrid'
),
(
    '550e8400-e29b-41d4-a716-446655440001', 
    'AutoReparaciones SL', 
    'info@autoreparaciones.com', 
    '634 567 890',
    'Avenida Industrial 45, Barcelona'
) ON CONFLICT (id) DO NOTHING;

-- 3. Crear perfiles para usuarios admin_mechanic de los workshops
-- Nota: Los usuarios reales deben crearse desde el dashboard de Supabase
DO $$
DECLARE
    workshop_demo_id uuid := '550e8400-e29b-41d4-a716-446655440000';
    workshop_auto_id uuid := '550e8400-e29b-41d4-a716-446655440001';
    user_demo_id uuid;
    user_auto_id uuid;
BEGIN
    -- Intentar obtener o crear ID para usuario demo
    SELECT id INTO user_demo_id FROM auth.users WHERE email = 'demo@tallerdemo.com';
    
    IF user_demo_id IS NULL THEN
        user_demo_id := gen_random_uuid();
        
        -- Intentar crear usuario demo (puede fallar en Cloud)
        BEGIN
            INSERT INTO auth.users (
                id, 
                instance_id,
                email, 
                encrypted_password, 
                email_confirmed_at, 
                created_at, 
                updated_at, 
                raw_app_meta_data, 
                raw_user_meta_data,
                aud,
                role
            ) VALUES (
                user_demo_id,
                '00000000-0000-0000-0000-000000000000',
                'demo@tallerdemo.com',
                '$2a$10$dummy.hash.for.development.only',  -- Hash dummy
                now(),
                now(),
                now(),
                '{"provider":"email","providers":["email"]}',
                '{"workshop_name":"Taller Mecánico Demo"}',
                'authenticated',
                'authenticated'
            );
        EXCEPTION WHEN OTHERS THEN
            -- Si falla, continuamos sin crear el usuario en auth.users
            NULL;
        END;
    END IF;

    -- Crear perfil para usuario demo
    INSERT INTO public.profiles (id, email, role, full_name, workshop_id, phone)
    VALUES (
        user_demo_id,
        'demo@tallerdemo.com',
        'admin_mechanic',
        'Juan Pérez',
        workshop_demo_id,
        '612 345 678'
    ) ON CONFLICT (id) DO UPDATE SET 
        role = 'admin_mechanic',
        workshop_id = workshop_demo_id,
        full_name = 'Juan Pérez',
        phone = '612 345 678';

    -- Intentar obtener o crear ID para usuario auto
    SELECT id INTO user_auto_id FROM auth.users WHERE email = 'info@autoreparaciones.com';
    
    IF user_auto_id IS NULL THEN
        user_auto_id := gen_random_uuid();
        
        -- Intentar crear usuario auto (puede fallar en Cloud)
        BEGIN
            INSERT INTO auth.users (
                id, 
                instance_id,
                email, 
                encrypted_password, 
                email_confirmed_at, 
                created_at, 
                updated_at, 
                raw_app_meta_data, 
                raw_user_meta_data,
                aud,
                role
            ) VALUES (
                user_auto_id,
                '00000000-0000-0000-0000-000000000000',
                'info@autoreparaciones.com',
                '$2a$10$dummy.hash.for.development.only',  -- Hash dummy
                now(),
                now(),
                now(),
                '{"provider":"email","providers":["email"]}',
                '{"workshop_name":"AutoReparaciones SL"}',
                'authenticated',
                'authenticated'
            );
        EXCEPTION WHEN OTHERS THEN
            -- Si falla, continuamos sin crear el usuario en auth.users
            NULL;
        END;
    END IF;

    -- Crear perfil para usuario auto
    INSERT INTO public.profiles (id, email, role, full_name, workshop_id, phone)
    VALUES (
        user_auto_id,
        'info@autoreparaciones.com',
        'admin_mechanic',
        'María García',
        workshop_auto_id,
        '634 567 890'
    ) ON CONFLICT (id) DO UPDATE SET 
        role = 'admin_mechanic',
        workshop_id = workshop_auto_id,
        full_name = 'María García',
        phone = '634 567 890';

END $$;

-- 3. Verificar que todo esté correcto
SELECT 'Verificación de datos:' as status;

-- Mostrar usuarios y sus roles
SELECT 
    u.email,
    p.role,
    p.full_name,
    w.name as workshop_name
FROM auth.users u
LEFT JOIN public.profiles p ON u.id = p.id
LEFT JOIN public.workshops w ON p.workshop_id = w.id
ORDER BY p.role, u.email;

-- Mostrar workshops y sus admin_mechanics
SELECT 
    w.name as workshop_name,
    w.email as workshop_email,
    p.full_name as admin_mechanic_name,
    u.email as admin_mechanic_email
FROM public.workshops w
LEFT JOIN public.profiles p ON w.id = p.workshop_id
LEFT JOIN auth.users u ON p.id = u.id
ORDER BY w.name;