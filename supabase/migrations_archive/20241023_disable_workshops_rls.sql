-- Disable RLS on workshops table to allow registration
ALTER TABLE public.workshops DISABLE ROW LEVEL SECURITY;

-- Drop all existing policies on workshops table
DROP POLICY IF EXISTS "Users can view their own workshop" ON public.workshops;
DROP POLICY IF EXISTS "Users can update their own workshop" ON public.workshops;
DROP POLICY IF EXISTS "Admins can view all workshops" ON public.workshops;
DROP POLICY IF EXISTS "Admins can manage all workshops" ON public.workshops;
DROP POLICY IF EXISTS "Admin mechanics can create workshops v2" ON public.workshops;
DROP POLICY IF EXISTS "Admin mechanics can create workshops v3" ON public.workshops;

-- Fix handle_new_user function to properly handle full_name from signup data
CREATE OR REPLACE FUNCTION public.handle_new_user() 
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, role, full_name)
  VALUES (
    new.id, 
    new.email, 
    COALESCE(new.raw_user_meta_data->>'role', 'admin_mechanic'),
    COALESCE(new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'workshop_name', 'Usuario')
  );
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;