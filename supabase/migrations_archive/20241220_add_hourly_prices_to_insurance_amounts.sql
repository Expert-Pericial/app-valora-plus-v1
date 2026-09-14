-- Agregar campos de precios por hora a la tabla insurance_amounts
ALTER TABLE insurance_amounts 
ADD COLUMN bodywork_hourly_price DECIMAL(10,2),
ADD COLUMN painting_hourly_price DECIMAL(10,2),
ADD COLUMN bodywork_labor_hours DECIMAL(10,2),
ADD COLUMN painting_labor_hours DECIMAL(10,2),
ADD COLUMN iva_percentage DECIMAL(5,2);

-- Agregar comentarios para documentar los nuevos campos
COMMENT ON COLUMN insurance_amounts.bodywork_hourly_price IS 'Precio por hora de mano de obra de chapa';
COMMENT ON COLUMN insurance_amounts.painting_hourly_price IS 'Precio por hora de mano de obra de pintura';
COMMENT ON COLUMN insurance_amounts.bodywork_labor_hours IS 'Horas de mano de obra de chapa';
COMMENT ON COLUMN insurance_amounts.painting_labor_hours IS 'Horas de mano de obra de pintura';
COMMENT ON COLUMN insurance_amounts.iva_percentage IS 'Porcentaje de IVA aplicado';