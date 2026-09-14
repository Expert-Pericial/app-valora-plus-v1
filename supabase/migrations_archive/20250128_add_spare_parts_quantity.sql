-- Agregar campo de cantidad de repuestos a la tabla insurance_amounts
ALTER TABLE insurance_amounts
ADD COLUMN spare_parts_quantity INTEGER;

COMMENT ON COLUMN insurance_amounts.spare_parts_quantity IS 'Cantidad total de ítems/elementos de repuestos extraídos del PDF';