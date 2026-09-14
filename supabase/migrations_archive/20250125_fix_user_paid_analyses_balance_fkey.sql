-- Fix foreign key constraint in user_paid_analyses_balance to point to auth.users instead of public.users

-- Drop the incorrect foreign key constraint
ALTER TABLE user_paid_analyses_balance 
DROP CONSTRAINT user_paid_analyses_balance_user_id_fkey;

-- Add the correct foreign key constraint pointing to auth.users
ALTER TABLE user_paid_analyses_balance 
ADD CONSTRAINT user_paid_analyses_balance_user_id_fkey 
FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;