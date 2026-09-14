-- Fix infinite recursion in profiles RLS policies
-- Drop problematic policies that cause infinite recursion
DROP POLICY IF EXISTS "Admins can view all profiles" ON profiles;
DROP POLICY IF EXISTS "Admins can update all profiles" ON profiles;

-- Create a function that checks admin status without querying profiles table
CREATE OR REPLACE FUNCTION is_admin_user()
RETURNS BOOLEAN AS $$
BEGIN
  -- Verify if the authenticated user has admin role in auth.users metadata
  RETURN auth.jwt() ->> 'email' IN (
    SELECT email FROM auth.users 
    WHERE raw_user_meta_data ->> 'role' = 'admin'
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create new policies that don't cause recursion
CREATE POLICY "Admins can view all profiles v2" ON profiles
  FOR SELECT USING (is_admin_user());

CREATE POLICY "Admins can update all profiles v2" ON profiles
  FOR UPDATE USING (is_admin_user());