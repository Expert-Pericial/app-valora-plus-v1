-- Fix workshops INSERT policy to allow registration
-- The issue: RLS is enabled but there's no INSERT policy, preventing workshop creation

-- Add INSERT policy to allow authenticated users to create workshops
-- This is needed for the registration flow where new users create their workshop
CREATE POLICY "Allow authenticated users to create workshops" ON public.workshops
FOR INSERT 
TO authenticated
WITH CHECK (true);

-- Also ensure we have a proper SELECT policy for workshop owners
-- This allows users to see their own workshop after creation
CREATE POLICY "Users can view their own workshop" ON public.workshops
FOR SELECT 
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM public.profiles 
    WHERE profiles.workshop_id = workshops.id 
    AND profiles.id = auth.uid()
  )
);

-- Note: This maintains security while allowing the registration flow to work
-- Users can create workshops, but can only see their own workshop
-- Admins can still see all workshops via existing admin policies