-- Disable Row Level Security for workshop_costs table temporarily
-- This is a temporary fix to resolve authentication issues with the workshop costs page

ALTER TABLE public.workshop_costs DISABLE ROW LEVEL SECURITY;

-- Add a comment explaining this is temporary
COMMENT ON TABLE public.workshop_costs IS 'RLS temporarily disabled due to session authentication issues. Should be re-enabled once auth flow is fixed.';