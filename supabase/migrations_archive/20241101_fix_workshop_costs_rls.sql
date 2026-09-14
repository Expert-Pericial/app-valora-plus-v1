-- Fix workshop_costs RLS policies to allow proper access
-- The issue is that the current policies are too restrictive and block SELECT queries
-- even when no data exists, which is normal for new analyses

-- Drop existing policies
DROP POLICY IF EXISTS "workshop_costs_workshop_policy" ON workshop_costs;
DROP POLICY IF EXISTS "workshop_costs_admin_policy" ON workshop_costs;

-- Create separate policies for different operations
-- Policy for SELECT operations - allows users to query their workshop's costs (even if empty)
CREATE POLICY "workshop_costs_select_policy" ON workshop_costs
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM analysis a
            JOIN profiles p ON p.workshop_id = a.workshop_id
            WHERE a.id = workshop_costs.analysis_id
            AND p.id = auth.uid()
        )
        OR
        EXISTS (
            SELECT 1 FROM profiles
            WHERE profiles.id = auth.uid()
            AND profiles.role = 'admin'
        )
    );

-- Policy for INSERT operations - allows users to create costs for their workshop's analyses
CREATE POLICY "workshop_costs_insert_policy" ON workshop_costs
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM analysis a
            JOIN profiles p ON p.workshop_id = a.workshop_id
            WHERE a.id = workshop_costs.analysis_id
            AND p.id = auth.uid()
        )
        OR
        EXISTS (
            SELECT 1 FROM profiles
            WHERE profiles.id = auth.uid()
            AND profiles.role = 'admin'
        )
    );

-- Policy for UPDATE operations - allows users to update costs for their workshop's analyses
CREATE POLICY "workshop_costs_update_policy" ON workshop_costs
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM analysis a
            JOIN profiles p ON p.workshop_id = a.workshop_id
            WHERE a.id = workshop_costs.analysis_id
            AND p.id = auth.uid()
        )
        OR
        EXISTS (
            SELECT 1 FROM profiles
            WHERE profiles.id = auth.uid()
            AND profiles.role = 'admin'
        )
    );

-- Policy for DELETE operations - allows users to delete costs for their workshop's analyses
CREATE POLICY "workshop_costs_delete_policy" ON workshop_costs
    FOR DELETE USING (
        EXISTS (
            SELECT 1 FROM analysis a
            JOIN profiles p ON p.workshop_id = a.workshop_id
            WHERE a.id = workshop_costs.analysis_id
            AND p.id = auth.uid()
        )
        OR
        EXISTS (
            SELECT 1 FROM profiles
            WHERE profiles.id = auth.uid()
            AND profiles.role = 'admin'
        )
    );