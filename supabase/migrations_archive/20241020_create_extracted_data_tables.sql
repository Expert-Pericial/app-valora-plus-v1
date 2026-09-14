-- Create tables for storing extracted data from n8n analysis

-- Create function to update updated_at column
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Table for vehicle metadata extracted from PDF
CREATE TABLE vehicle_data (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  analysis_id UUID NOT NULL REFERENCES analysis(id) ON DELETE CASCADE,
  license_plate TEXT,
  vin TEXT,
  manufacturer TEXT,
  model TEXT,
  internal_reference TEXT,
  system TEXT, -- e.g., "AUDA"
  hourly_price DECIMAL(10,2),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table for insurance amounts extracted from PDF
CREATE TABLE insurance_amounts (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  analysis_id UUID NOT NULL REFERENCES analysis(id) ON DELETE CASCADE,
  -- Totales de repuestos
  total_spare_parts_eur DECIMAL(10,2),
  -- Mano de obra carrocería
  bodywork_labor_ut DECIMAL(10,2),
  bodywork_labor_eur DECIMAL(10,2),
  -- Mano de obra pintura
  painting_labor_ut DECIMAL(10,2),
  painting_labor_eur DECIMAL(10,2),
  -- Material de pintura
  paint_material_eur DECIMAL(10,2),
  -- Totales calculados
  net_subtotal DECIMAL(10,2),
  iva_amount DECIMAL(10,2),
  total_with_iva DECIMAL(10,2),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX idx_vehicle_data_analysis_id ON vehicle_data(analysis_id);
CREATE INDEX idx_insurance_amounts_analysis_id ON insurance_amounts(analysis_id);

-- Create updated_at triggers
CREATE TRIGGER update_vehicle_data_updated_at
  BEFORE UPDATE ON vehicle_data
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_insurance_amounts_updated_at
  BEFORE UPDATE ON insurance_amounts
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Enable RLS
ALTER TABLE vehicle_data ENABLE ROW LEVEL SECURITY;
ALTER TABLE insurance_amounts ENABLE ROW LEVEL SECURITY;

-- RLS Policies for vehicle_data
CREATE POLICY "Users can view their own vehicle data" ON vehicle_data
  FOR SELECT USING (
    analysis_id IN (
      SELECT id FROM analysis WHERE workshop_id = auth.uid()
    )
  );

CREATE POLICY "Users can insert their own vehicle data" ON vehicle_data
  FOR INSERT WITH CHECK (
    analysis_id IN (
      SELECT id FROM analysis WHERE workshop_id = auth.uid()
    )
  );

CREATE POLICY "Users can update their own vehicle data" ON vehicle_data
  FOR UPDATE USING (
    analysis_id IN (
      SELECT id FROM analysis WHERE workshop_id = auth.uid()
    )
  );

-- RLS Policies for insurance_amounts
CREATE POLICY "Users can view their own insurance amounts" ON insurance_amounts
  FOR SELECT USING (
    analysis_id IN (
      SELECT id FROM analysis WHERE workshop_id = auth.uid()
    )
  );

CREATE POLICY "Users can insert their own insurance amounts" ON insurance_amounts
  FOR INSERT WITH CHECK (
    analysis_id IN (
      SELECT id FROM analysis WHERE workshop_id = auth.uid()
    )
  );

CREATE POLICY "Users can update their own insurance amounts" ON insurance_amounts
  FOR UPDATE USING (
    analysis_id IN (
      SELECT id FROM analysis WHERE workshop_id = auth.uid()
    )
  );