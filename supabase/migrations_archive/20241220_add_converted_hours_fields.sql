-- Add converted hours fields and unit metadata to insurance_amounts table
-- This migration adds support for storing converted hours alongside original UT values

ALTER TABLE insurance_amounts 
ADD COLUMN bodywork_labor_hours DECIMAL(10,2),
ADD COLUMN painting_labor_hours DECIMAL(10,2),
ADD COLUMN detected_units TEXT CHECK (detected_units IN ('UT', 'HORAS', 'MIXTO'));

-- Add comments to explain the new fields
COMMENT ON COLUMN insurance_amounts.bodywork_labor_hours IS 'Mano de obra chapa convertida a horas (10 UT = 1 hora)';
COMMENT ON COLUMN insurance_amounts.painting_labor_hours IS 'Mano de obra pintura convertida a horas (10 UT = 1 hora)';
COMMENT ON COLUMN insurance_amounts.detected_units IS 'Tipo de unidades detectadas en el PDF: UT, HORAS o MIXTO';

-- Update existing records to convert UT to hours (assuming existing data is in UT)
-- Only update if the hours fields are null and UT fields have values
UPDATE insurance_amounts 
SET 
  bodywork_labor_hours = ROUND(bodywork_labor_ut / 10.0, 2),
  painting_labor_hours = ROUND(painting_labor_ut / 10.0, 2),
  detected_units = 'UT'
WHERE 
  bodywork_labor_hours IS NULL 
  AND painting_labor_hours IS NULL 
  AND (bodywork_labor_ut IS NOT NULL OR painting_labor_ut IS NOT NULL);