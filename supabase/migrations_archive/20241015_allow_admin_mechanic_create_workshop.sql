-- Allow admin_mechanic users to create workshops
-- Updated to avoid dependency on profiles table during registration
CREATE POLICY "Admin mechanics can create workshops v2" ON workshops
  FOR INSERT 
  WITH CHECK (
    auth.jwt() ->> 'email' IN (
      SELECT email FROM auth.users 
      WHERE raw_user_meta_data ->> 'role' = 'admin_mechanic'
    )
  );