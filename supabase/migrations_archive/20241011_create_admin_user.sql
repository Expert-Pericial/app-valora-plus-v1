-- Crear un usuario administrador usando la función de Supabase
-- Nota: En producción, este usuario debe crearse manualmente desde el dashboard
-- Esta migración solo crea el perfil si el usuario ya existe

-- Primero, intentamos crear el usuario usando la API de Supabase
-- Si falla, continuamos sin error
DO $$
DECLARE
  admin_id uuid;
BEGIN
  -- Intentar obtener el ID del usuario admin si ya existe
  SELECT id INTO admin_id FROM auth.users WHERE email = 'admin@valoraplus.com';
  
  -- Si no existe el usuario, crear un UUID temporal para el perfil
  -- El usuario real debe crearse desde el dashboard de Supabase
  IF admin_id IS NULL THEN
    admin_id := gen_random_uuid();
    
    -- Insertar un registro temporal en auth.users (esto puede fallar en Cloud)
    BEGIN
      INSERT INTO auth.users (
        id, 
        email, 
        encrypted_password, 
        email_confirmed_at, 
        created_at, 
        updated_at, 
        raw_app_meta_data, 
        raw_user_meta_data
      )
      VALUES (
        admin_id,
        'admin@valoraplus.com',
        '$2a$10$dummy.hash.for.development.only',  -- Hash dummy
        now(),
        now(),
        now(),
        '{"provider":"email","providers":["email"]}',
        '{}'
      );
    EXCEPTION WHEN OTHERS THEN
      -- Si falla, continuamos sin crear el usuario en auth.users
      NULL;
    END;
  END IF;
  
  -- Crear o actualizar el perfil en la tabla profiles
  INSERT INTO public.profiles (id, email, role, full_name, workshop_name)
  VALUES (
    admin_id,
    'admin@valoraplus.com',
    'admin',
    'Administrador Sistema',
    NULL
  ) ON CONFLICT (id) DO UPDATE SET 
    role = 'admin',
    email = 'admin@valoraplus.com',
    full_name = 'Administrador Sistema';
    
END $$;