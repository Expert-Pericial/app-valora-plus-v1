-- Create workshops table
CREATE TABLE public.workshops (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    address TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Add workshop_id to profiles table and remove workshop_name
ALTER TABLE public.profiles 
ADD COLUMN workshop_id UUID REFERENCES public.workshops(id) ON DELETE CASCADE,
ADD COLUMN phone TEXT;

-- Remove the old workshop_name column
ALTER TABLE public.profiles DROP COLUMN IF EXISTS workshop_name;

-- Create index for better performance
CREATE INDEX idx_profiles_workshop_id ON public.profiles(workshop_id);

-- Enable RLS on workshops table
ALTER TABLE public.workshops ENABLE ROW LEVEL SECURITY;

-- Create policies for workshops table
CREATE POLICY "Users can view their own workshop" ON public.workshops
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM public.profiles 
            WHERE profiles.workshop_id = workshops.id 
            AND profiles.id = auth.uid()
        )
    );

CREATE POLICY "Users can update their own workshop" ON public.workshops
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM public.profiles 
            WHERE profiles.workshop_id = workshops.id 
            AND profiles.id = auth.uid()
            AND profiles.role = 'admin_mechanic'
        )
    );

-- Allow admins to view and manage all workshops
CREATE POLICY "Admins can view all workshops" ON public.workshops
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM public.profiles 
            WHERE profiles.id = auth.uid() 
            AND profiles.role = 'admin'
        )
    );

CREATE POLICY "Admins can manage all workshops" ON public.workshops
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM public.profiles 
            WHERE profiles.id = auth.uid() 
            AND profiles.role = 'admin'
        )
    );

-- Function to handle workshop creation during user registration
CREATE OR REPLACE FUNCTION public.handle_workshop_registration(
    workshop_name TEXT,
    workshop_email TEXT,
    workshop_phone TEXT DEFAULT NULL
)
RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    workshop_id UUID;
BEGIN
    -- Insert new workshop
    INSERT INTO public.workshops (name, email, phone)
    VALUES (workshop_name, workshop_email, workshop_phone)
    RETURNING id INTO workshop_id;
    
    RETURN workshop_id;
END;
$$;

-- Function to update user profile with workshop info
CREATE OR REPLACE FUNCTION public.complete_user_registration(
    user_id UUID,
    workshop_id UUID,
    user_phone TEXT DEFAULT NULL
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    -- Update user profile with workshop_id and phone
    UPDATE public.profiles 
    SET 
        workshop_id = complete_user_registration.workshop_id,
        phone = user_phone,
        updated_at = now()
    WHERE id = user_id;
END;
$$;

-- Grant necessary permissions
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT ALL ON public.workshops TO authenticated;
GRANT EXECUTE ON FUNCTION public.handle_workshop_registration TO authenticated;
GRANT EXECUTE ON FUNCTION public.complete_user_registration TO authenticated;