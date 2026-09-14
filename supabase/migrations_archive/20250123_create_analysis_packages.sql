-- Crear tabla de paquetes de análisis
CREATE TABLE IF NOT EXISTS analysis_packages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    analyses_count INTEGER NOT NULL CHECK (analyses_count > 0),
    price_per_analysis DECIMAL(10,2) NOT NULL CHECK (price_per_analysis > 0),
    total_price DECIMAL(10,2) NOT NULL CHECK (total_price > 0),
    discount_percentage DECIMAL(5,2) DEFAULT 0 CHECK (discount_percentage >= 0 AND discount_percentage <= 100),
    is_active BOOLEAN DEFAULT true,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear índices
CREATE INDEX idx_analysis_packages_active ON analysis_packages(is_active);
CREATE INDEX idx_analysis_packages_sort_order ON analysis_packages(sort_order);

-- Trigger para updated_at
CREATE OR REPLACE FUNCTION update_analysis_packages_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_analysis_packages_updated_at
    BEFORE UPDATE ON analysis_packages
    FOR EACH ROW
    EXECUTE FUNCTION update_analysis_packages_updated_at();

-- Insertar paquetes predefinidos
INSERT INTO analysis_packages (name, description, analyses_count, price_per_analysis, total_price, discount_percentage, sort_order) VALUES
('Análisis Individual', 'Compra un análisis individual', 1, 15.00, 15.00, 0, 1),
('Paquete Básico', 'Paquete de 10 análisis con 5% de descuento', 10, 14.25, 142.50, 5, 2),
('Paquete Estándar', 'Paquete de 50 análisis con 10% de descuento', 50, 13.50, 675.00, 10, 3),
('Paquete Premium', 'Paquete de 100 análisis con 15% de descuento', 100, 12.75, 1275.00, 15, 4),
('Paquete Empresarial', 'Paquete de 500 análisis con 20% de descuento', 500, 12.00, 6000.00, 20, 5);

-- Función para obtener paquetes activos
CREATE OR REPLACE FUNCTION get_active_analysis_packages()
RETURNS TABLE (
    id UUID,
    name VARCHAR(100),
    description TEXT,
    analyses_count INTEGER,
    price_per_analysis DECIMAL(10,2),
    total_price DECIMAL(10,2),
    discount_percentage DECIMAL(5,2),
    sort_order INTEGER
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id,
        p.name,
        p.description,
        p.analyses_count,
        p.price_per_analysis,
        p.total_price,
        p.discount_percentage,
        p.sort_order
    FROM analysis_packages p
    WHERE p.is_active = true
    ORDER BY p.sort_order ASC;
END;
$$ LANGUAGE plpgsql;

-- Función para obtener un paquete por ID
CREATE OR REPLACE FUNCTION get_analysis_package_by_id(package_id UUID)
RETURNS TABLE (
    id UUID,
    name VARCHAR(100),
    description TEXT,
    analyses_count INTEGER,
    price_per_analysis DECIMAL(10,2),
    total_price DECIMAL(10,2),
    discount_percentage DECIMAL(5,2)
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id,
        p.name,
        p.description,
        p.analyses_count,
        p.price_per_analysis,
        p.total_price,
        p.discount_percentage
    FROM analysis_packages p
    WHERE p.id = package_id AND p.is_active = true;
END;
$$ LANGUAGE plpgsql;

-- Políticas RLS
ALTER TABLE analysis_packages ENABLE ROW LEVEL SECURITY;

-- Política para lectura (todos pueden ver paquetes activos)
CREATE POLICY "Anyone can view active analysis packages" ON analysis_packages
    FOR SELECT USING (is_active = true);

-- Política para administradores (pueden hacer todo)
CREATE POLICY "Admins can manage analysis packages" ON analysis_packages
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM auth.users 
            WHERE auth.users.id = auth.uid() 
            AND auth.users.raw_user_meta_data->>'role' = 'admin'
        )
    );

-- Comentarios
COMMENT ON TABLE analysis_packages IS 'Tabla que almacena los diferentes paquetes de análisis disponibles para compra';
COMMENT ON COLUMN analysis_packages.analyses_count IS 'Número de análisis incluidos en el paquete';
COMMENT ON COLUMN analysis_packages.price_per_analysis IS 'Precio por análisis individual en este paquete';
COMMENT ON COLUMN analysis_packages.total_price IS 'Precio total del paquete';
COMMENT ON COLUMN analysis_packages.discount_percentage IS 'Porcentaje de descuento aplicado respecto al precio individual';