-- Fix package_type constraint to match actual packages
ALTER TABLE user_paid_analyses_balance 
DROP CONSTRAINT IF EXISTS user_paid_analyses_balance_package_type_check;

ALTER TABLE user_paid_analyses_balance 
ADD CONSTRAINT user_paid_analyses_balance_package_type_check 
CHECK (package_type IN ('individual', 'basic', 'professional', 'enterprise'));