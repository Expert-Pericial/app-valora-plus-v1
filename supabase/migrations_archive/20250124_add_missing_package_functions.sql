-- Crear función get_active_packages (alias para get_active_analysis_packages)
CREATE OR REPLACE FUNCTION get_active_packages()
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

-- Crear función get_package_by_id (alias para get_analysis_package_by_id)
CREATE OR REPLACE FUNCTION get_package_by_id(package_id UUID)
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