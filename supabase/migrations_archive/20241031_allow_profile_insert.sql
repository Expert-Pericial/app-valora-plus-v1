-- Allow users to insert their own profile (needed for UPSERT during registration)
-- This is safe because users can only insert their own profile (auth.uid() = id)

CREATE POLICY "Users can insert their own profile" 
  ON public.profiles 
  FOR INSERT 
  WITH CHECK (auth.uid() = id);