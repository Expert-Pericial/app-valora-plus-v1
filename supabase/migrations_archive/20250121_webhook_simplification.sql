-- Webhook Simplification Migration
-- This migration documents the webhook simplification to avoid duplicate payment processing

-- Verify that the update_payment_status function exists with the correct signature
-- This should already be created by the previous migration
DO $$
BEGIN
  -- Check if the function exists with the correct parameters
  IF NOT EXISTS (
    SELECT 1 FROM pg_proc p
    JOIN pg_namespace n ON p.pronamespace = n.oid
    WHERE n.nspname = 'public'
    AND p.proname = 'update_payment_status'
    AND p.pronargs = 6  -- 6 parameters
  ) THEN
    RAISE EXCEPTION 'update_payment_status function with 6 parameters not found. Please run the fix_update_payment_status_overload migration first.';
  END IF;
  
  RAISE NOTICE 'update_payment_status function verified successfully';
END $$;

-- Add a comment to document the webhook simplification
COMMENT ON FUNCTION update_payment_status(TEXT, TEXT, TEXT, INTEGER, TEXT, TEXT) IS 
'Updated function to handle payment status updates from simplified webhook. 
Webhook now only processes:
- checkout.session.completed (for successful payments)
- checkout.session.expired (for canceled payments) 
- payment_intent.payment_failed (for failed payments)
Removed duplicate events: payment_intent.succeeded and charge.succeeded to avoid conflicts.';

-- Verify that create_payment_record function exists with customer_id parameter
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_proc p
    JOIN pg_namespace n ON p.pronamespace = n.oid
    WHERE n.nspname = 'public'
    AND p.proname = 'create_payment_record'
    AND p.pronargs = 9  -- 9 parameters including stripe_customer_id_param
  ) THEN
    RAISE EXCEPTION 'create_payment_record function with customer_id parameter not found. Please run the add_customer_id_to_payment_record migration first.';
  END IF;
  
  RAISE NOTICE 'create_payment_record function verified successfully';
END $$;