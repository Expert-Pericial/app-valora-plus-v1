-- Fix all RLS policies to avoid database access issues
-- This migration fixes infinite recursion and permission denied errors

-- 1. Fix profiles policies (remove infinite recursion)
DROP POLICY IF EXISTS "Admins can view all profiles" ON profiles;
DROP POLICY IF EXISTS "Admins can update all profiles" ON profiles;
DROP POLICY IF EXISTS "Admins can view all profiles v2" ON profiles;
DROP POLICY IF EXISTS "Admins can update all profiles v2" ON profiles;

-- Remove problematic function
DROP FUNCTION IF EXISTS is_admin_user();

-- Create new profiles policies that only use JWT
CREATE POLICY "Admins can view all profiles v3" ON profiles
  FOR SELECT USING (
    (auth.jwt() ->> 'user_metadata')::jsonb ->> 'role' = 'admin'
    OR 
    (auth.jwt() ->> 'raw_user_meta_data')::jsonb ->> 'role' = 'admin'
  );

CREATE POLICY "Admins can update all profiles v3" ON profiles
  FOR UPDATE USING (
    (auth.jwt() ->> 'user_metadata')::jsonb ->> 'role' = 'admin'
    OR 
    (auth.jwt() ->> 'raw_user_meta_data')::jsonb ->> 'role' = 'admin'
  );

-- 2. Fix workshops policies (remove auth.users access)
DROP POLICY IF EXISTS "Admin mechanics can create workshops" ON workshops;
DROP POLICY IF EXISTS "Admin mechanics can create workshops v2" ON workshops;

-- Create new workshop creation policy that only uses JWT
CREATE POLICY "Admin mechanics can create workshops v3" ON workshops
  FOR INSERT 
  WITH CHECK (
    (auth.jwt() ->> 'user_metadata')::jsonb ->> 'role' = 'admin_mechanic'
    OR 
    (auth.jwt() ->> 'raw_user_meta_data')::jsonb ->> 'role' = 'admin_mechanic'
  );