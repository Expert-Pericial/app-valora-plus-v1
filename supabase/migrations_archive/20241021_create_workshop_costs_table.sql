-- Create workshop_costs table to store actual workshop costs
CREATE TABLE workshop_costs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    analysis_id UUID NOT NULL REFERENCES analysis(id) ON DELETE CASCADE,
    
    -- Spare parts costs
    spare_parts_purchase_cost DECIMAL(10,2),
    
    -- Bodywork labor costs
    bodywork_actual_hours DECIMAL(8,2),
    bodywork_hourly_cost DECIMAL(8,2),
    
    -- Painting labor costs
    painting_actual_hours DECIMAL(8,2),
    painting_hourly_cost DECIMAL(8,2),
    
    -- Other costs
    painting_consumables_cost DECIMAL(10,2),
    subcontractor_costs DECIMAL(10,2),
    other_costs DECIMAL(10,2),
    
    -- Notes
    notes TEXT,
    
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create RLS policies
ALTER TABLE workshop_costs ENABLE ROW LEVEL SECURITY;

-- Policy for workshop users to manage their own costs
CREATE POLICY "workshop_costs_workshop_policy" ON workshop_costs
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM analysis a
            JOIN profiles p ON p.workshop_id = a.workshop_id
            WHERE a.id = workshop_costs.analysis_id
            AND p.id = auth.uid()
        )
    );

-- Policy for admin users to view all costs
CREATE POLICY "workshop_costs_admin_policy" ON workshop_costs
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE profiles.id = auth.uid()
            AND profiles.role = 'admin'
        )
    );

-- Create updated_at trigger
CREATE TRIGGER update_workshop_costs_updated_at
    BEFORE UPDATE ON workshop_costs
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();