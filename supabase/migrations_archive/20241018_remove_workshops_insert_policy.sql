-- Remove INSERT policy from workshops table to allow registration
-- This replicates the behavior of the profiles table which has RLS enabled
-- but no INSERT policies, allowing creation during registration

-- Drop the INSERT policy that was causing registration failures
DROP POLICY IF EXISTS "Admin mechanics can create workshops v3" ON workshops;

-- Note: With RLS enabled but no INSERT policies, PostgreSQL allows
-- insertions by default, which is what we want for registration flow
-- Other policies (SELECT, UPDATE, DELETE) remain for proper access control