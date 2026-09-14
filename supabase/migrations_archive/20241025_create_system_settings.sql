-- Crear tabla para configuraciones del sistema
CREATE TABLE IF NOT EXISTS system_settings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  setting_key VARCHAR(100) UNIQUE NOT NULL,
  setting_value JSONB NOT NULL,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_by UUID REFERENCES auth.users(id)
);

-- Crear índices para optimizar consultas
CREATE INDEX IF NOT EXISTS idx_system_settings_key ON system_settings(setting_key);
CREATE INDEX IF NOT EXISTS idx_system_settings_updated_at ON system_settings(updated_at);

-- Insertar configuraciones iniciales del sistema
INSERT INTO system_settings (setting_key, setting_value, description) VALUES
  ('monthly_free_analyses_limit', '{"value": 3}', 'Límite de análisis gratuitos por mes para usuarios admin_mechanic'),
  ('additional_analysis_price', '{"value": 25.00, "currency": "EUR"}', 'Precio por análisis adicional después del límite gratuito'),
  ('billing_enabled', '{"value": true}', 'Si está habilitada la facturación por análisis adicionales'),
  ('stripe_enabled', '{"value": false}', 'Si está habilitada la integración con Stripe'),
  ('company_info', '{"name": "Valora Plus", "tax_id": "", "address": "", "email": ""}', 'Información de la empresa para facturación')
ON CONFLICT (setting_key) DO NOTHING;

-- Función para obtener configuración del sistema
CREATE OR REPLACE FUNCTION get_system_setting(setting_name TEXT)
RETURNS JSONB AS $$
BEGIN
  RETURN (SELECT setting_value FROM system_settings WHERE setting_key = setting_name);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función para actualizar configuración del sistema (solo admins)
CREATE OR REPLACE FUNCTION update_system_setting(setting_name TEXT, new_value JSONB)
RETURNS BOOLEAN AS $$
DECLARE
  user_role TEXT;
BEGIN
  -- Verificar que el usuario es admin
  SELECT role INTO user_role FROM profiles WHERE id = auth.uid();
  
  IF user_role != 'admin' THEN
    RAISE EXCEPTION 'Solo los administradores pueden modificar configuraciones del sistema';
  END IF;
  
  -- Actualizar la configuración
  UPDATE system_settings 
  SET setting_value = new_value, 
      updated_at = NOW(), 
      updated_by = auth.uid()
  WHERE setting_key = setting_name;
  
  RETURN FOUND;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Políticas RLS para system_settings
ALTER TABLE system_settings ENABLE ROW LEVEL SECURITY;

-- Los admins pueden ver y modificar todas las configuraciones
CREATE POLICY "Admins can manage system settings" ON system_settings
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = auth.uid() 
      AND profiles.role = 'admin'
    )
  );

-- Los usuarios pueden ver configuraciones públicas (solo lectura)
CREATE POLICY "Users can view public settings" ON system_settings
  FOR SELECT USING (
    setting_key IN (
      'monthly_free_analyses_limit',
      'additional_analysis_price',
      'billing_enabled'
    )
  );

-- Trigger para actualizar updated_at
CREATE OR REPLACE FUNCTION update_system_settings_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_system_settings_updated_at
  BEFORE UPDATE ON system_settings
  FOR EACH ROW
  EXECUTE FUNCTION update_system_settings_updated_at();