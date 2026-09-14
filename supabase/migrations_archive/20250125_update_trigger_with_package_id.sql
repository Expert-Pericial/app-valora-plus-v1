-- Actualizar el trigger para usar correctamente el campo package_id
-- Esta migración reemplaza la lógica anterior que parseaba la descripción

CREATE OR REPLACE FUNCTION trigger_add_paid_analyses_on_payment_completion()
RETURNS TRIGGER AS $$
DECLARE
    package_data RECORD;
    analyses_to_add INTEGER;
    package_type VARCHAR(50);
    amount_paid DECIMAL(10,2);
BEGIN
    -- Solo procesar si el estado cambió a 'completed'
    IF NEW.status = 'completed' AND OLD.status != 'completed' THEN
        
        -- Calcular el monto pagado en euros (convertir de centavos)
        amount_paid := NEW.amount_cents / 100.0;
        
        -- Si tenemos package_id, obtener datos del paquete directamente
        IF NEW.package_id IS NOT NULL THEN
            SELECT 
                name,
                analyses_count
            INTO package_data
            FROM analysis_packages 
            WHERE id = NEW.package_id AND is_active = true;
            
            IF FOUND THEN
                analyses_to_add := package_data.analyses_count;
                package_type := package_data.name;
                
                RAISE LOG 'Trigger: Usando package_id %, paquete: %, análisis: %', 
                    NEW.package_id, package_type, analyses_to_add;
            ELSE
                RAISE LOG 'Trigger: Package_id % no encontrado o inactivo', NEW.package_id;
                -- Fallback: usar analyses_purchased del payment
                analyses_to_add := COALESCE(NEW.analyses_purchased, 1);
                package_type := 'Paquete no encontrado';
            END IF;
        ELSE
            -- Fallback: usar analyses_purchased del payment
            analyses_to_add := COALESCE(NEW.analyses_purchased, 1);
            package_type := 'Sin package_id';
            
            RAISE LOG 'Trigger: Sin package_id, usando analyses_purchased: %', analyses_to_add;
        END IF;
        
        -- Llamar a la función add_paid_analyses
        BEGIN
            PERFORM add_paid_analyses(
                p_user_id := NEW.user_id,
                p_analyses_count := analyses_to_add,
                p_package_type := package_type,
                p_stripe_payment_intent_id := NEW.stripe_payment_intent_id,
                p_amount_paid := amount_paid
            );
            
            RAISE LOG 'Trigger: add_paid_analyses ejecutado exitosamente para user_id: %, análisis: %, tipo: %', 
                NEW.user_id, analyses_to_add, package_type;
                
        EXCEPTION WHEN OTHERS THEN
            RAISE LOG 'Trigger: Error al ejecutar add_paid_analyses: %', SQLERRM;
            -- No re-lanzar el error para evitar que falle la transacción del payment
        END;
        
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Comentario actualizado
COMMENT ON FUNCTION trigger_add_paid_analyses_on_payment_completion() IS 'Trigger function que automáticamente añade análisis pagados al balance del usuario cuando un payment se completa. Utiliza el campo package_id para obtener datos exactos del paquete.';