-- Create user_paid_analyses_balance table for persistent paid analyses
CREATE TABLE user_paid_analyses_balance (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    remaining_analyses INTEGER NOT NULL DEFAULT 0 CHECK (remaining_analyses >= 0),
    total_purchased INTEGER NOT NULL DEFAULT 0 CHECK (total_purchased >= 0),
    total_used INTEGER NOT NULL DEFAULT 0 CHECK (total_used >= 0),
    package_type VARCHAR(50) DEFAULT 'individual' CHECK (package_type IN ('individual', 'package_5', 'package_10', 'package_20')),
    purchase_history JSONB DEFAULT '[]'::jsonb,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create unique index on user_id (one record per user)
CREATE UNIQUE INDEX idx_user_paid_analyses_balance_user_id ON user_paid_analyses_balance(user_id);

-- Create index on remaining_analyses for quick lookups
CREATE INDEX idx_user_paid_analyses_balance_remaining ON user_paid_analyses_balance(remaining_analyses);

-- Add RLS policies
ALTER TABLE user_paid_analyses_balance ENABLE ROW LEVEL SECURITY;

-- Policy: Users can only see their own balance
CREATE POLICY "Users can view own paid analyses balance" ON user_paid_analyses_balance
    FOR SELECT USING (auth.uid() = user_id);

-- Policy: Users can update their own balance (for consuming analyses)
CREATE POLICY "Users can update own paid analyses balance" ON user_paid_analyses_balance
    FOR UPDATE USING (auth.uid() = user_id);

-- Policy: System can insert new balances (for new users or purchases)
CREATE POLICY "System can insert paid analyses balance" ON user_paid_analyses_balance
    FOR INSERT WITH CHECK (true);

-- Function to get or create user paid analyses balance
CREATE OR REPLACE FUNCTION get_or_create_paid_analyses_balance(p_user_id UUID)
RETURNS user_paid_analyses_balance AS $$
DECLARE
    balance_record user_paid_analyses_balance;
BEGIN
    -- Try to get existing balance
    SELECT * INTO balance_record
    FROM user_paid_analyses_balance
    WHERE user_id = p_user_id;
    
    -- If no balance exists, create one
    IF NOT FOUND THEN
        INSERT INTO user_paid_analyses_balance (user_id)
        VALUES (p_user_id)
        RETURNING * INTO balance_record;
    END IF;
    
    RETURN balance_record;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to add paid analyses to user balance
CREATE OR REPLACE FUNCTION add_paid_analyses(
    p_user_id UUID,
    p_analyses_count INTEGER,
    p_package_type VARCHAR(50) DEFAULT 'individual',
    p_stripe_payment_intent_id TEXT DEFAULT NULL,
    p_amount_paid DECIMAL DEFAULT NULL
)
RETURNS user_paid_analyses_balance AS $$
DECLARE
    balance_record user_paid_analyses_balance;
    purchase_entry JSONB;
BEGIN
    -- Validate input
    IF p_analyses_count <= 0 THEN
        RAISE EXCEPTION 'Analyses count must be positive';
    END IF;
    
    -- Get or create balance record
    SELECT * INTO balance_record FROM get_or_create_paid_analyses_balance(p_user_id);
    
    -- Create purchase history entry
    purchase_entry := jsonb_build_object(
        'date', NOW(),
        'analyses_count', p_analyses_count,
        'package_type', p_package_type,
        'stripe_payment_intent_id', p_stripe_payment_intent_id,
        'amount_paid', p_amount_paid
    );
    
    -- Update balance
    UPDATE user_paid_analyses_balance
    SET 
        remaining_analyses = remaining_analyses + p_analyses_count,
        total_purchased = total_purchased + p_analyses_count,
        package_type = p_package_type,
        purchase_history = purchase_history || purchase_entry,
        updated_at = NOW()
    WHERE user_id = p_user_id
    RETURNING * INTO balance_record;
    
    RETURN balance_record;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to consume a paid analysis
CREATE OR REPLACE FUNCTION consume_paid_analysis(p_user_id UUID)
RETURNS BOOLEAN AS $$
DECLARE
    balance_record user_paid_analyses_balance;
BEGIN
    -- Get current balance
    SELECT * INTO balance_record
    FROM user_paid_analyses_balance
    WHERE user_id = p_user_id;
    
    -- If no balance or no remaining analyses, return false
    IF NOT FOUND OR balance_record.remaining_analyses <= 0 THEN
        RETURN FALSE;
    END IF;
    
    -- Consume one analysis
    UPDATE user_paid_analyses_balance
    SET 
        remaining_analyses = remaining_analyses - 1,
        total_used = total_used + 1,
        updated_at = NOW()
    WHERE user_id = p_user_id;
    
    RETURN TRUE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to get user's paid analyses balance
CREATE OR REPLACE FUNCTION get_paid_analyses_balance(p_user_id UUID)
RETURNS TABLE (
    remaining_analyses INTEGER,
    total_purchased INTEGER,
    total_used INTEGER,
    package_type VARCHAR(50),
    purchase_history JSONB
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        COALESCE(upab.remaining_analyses, 0) as remaining_analyses,
        COALESCE(upab.total_purchased, 0) as total_purchased,
        COALESCE(upab.total_used, 0) as total_used,
        COALESCE(upab.package_type, 'individual') as package_type,
        COALESCE(upab.purchase_history, '[]'::jsonb) as purchase_history
    FROM user_paid_analyses_balance upab
    WHERE upab.user_id = p_user_id
    
    UNION ALL
    
    SELECT 0, 0, 0, 'individual', '[]'::jsonb
    WHERE NOT EXISTS (
        SELECT 1 FROM user_paid_analyses_balance WHERE user_id = p_user_id
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create trigger to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_paid_analyses_balance_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_paid_analyses_balance_updated_at
    BEFORE UPDATE ON user_paid_analyses_balance
    FOR EACH ROW
    EXECUTE FUNCTION update_paid_analyses_balance_updated_at();

-- Grant necessary permissions
GRANT SELECT, INSERT, UPDATE ON user_paid_analyses_balance TO authenticated;
GRANT EXECUTE ON FUNCTION get_or_create_paid_analyses_balance(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION add_paid_analyses(UUID, INTEGER, VARCHAR, TEXT, DECIMAL) TO authenticated;
GRANT EXECUTE ON FUNCTION consume_paid_analysis(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION get_paid_analyses_balance(UUID) TO authenticated;