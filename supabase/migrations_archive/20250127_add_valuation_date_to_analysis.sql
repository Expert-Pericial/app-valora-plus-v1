-- Add valuation_date and analysis_date fields to analysis table
ALTER TABLE analysis 
ADD COLUMN IF NOT EXISTS valuation_date DATE,
ADD COLUMN IF NOT EXISTS analysis_date DATE;

-- Add index for efficient queries on valuation_date
CREATE INDEX IF NOT EXISTS idx_analysis_valuation_date ON analysis(valuation_date);
CREATE INDEX IF NOT EXISTS idx_analysis_analysis_date ON analysis(analysis_date);