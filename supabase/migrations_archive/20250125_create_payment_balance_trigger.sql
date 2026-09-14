-- Trigger automático para registrar balance cuando un payment se completa
-- Este trigger se ejecuta cuando el status de un payment cambia a 'completed'

CREATE OR REPLACE FUNCTION trigger_add_paid_analyses_on_payment_completion()
RETURNS TRIGGER AS $$
DECLARE
  package_data RECORD;
  analyses_to_add INTEGER := 0;
  package_type_value VARCHAR(50) := 'individual';
  amount_paid_euros DECIMAL;
  analysis_price DECIMAL;
BEGIN
  -- Solo procesar si el status cambió a 'completed' y antes no era 'completed'
  IF NEW.status = 'completed' AND (OLD.status IS NULL OR OLD.status != 'completed') THEN
    
    RAISE LOG 'Payment completion trigger fired for payment_id: %, user_id: %', NEW.id, NEW.user_id;
    
    -- Convertir amount_cents a euros
    amount_paid_euros := NEW.amount_cents / 100.0;
    
    -- Intentar obtener datos del paquete desde los metadatos de Stripe
    -- Primero buscar por package_id si existe en description o metadata
    IF NEW.description IS NOT NULL AND NEW.description LIKE '%package_id:%' THEN
      -- Extraer package_id de la descripción (formato: "package_id:uuid")
      DECLARE
        package_id_text TEXT;
        package_uuid UUID;
      BEGIN
        package_id_text := substring(NEW.description from 'package_id:([a-f0-9-]+)');
        package_uuid := package_id_text::UUID;
        
        SELECT * INTO package_data
        FROM analysis_packages
        WHERE id = package_uuid AND is_active = true;
        
        IF FOUND THEN
          analyses_to_add := package_data.analyses_count;
          package_type_value := CASE 
            WHEN package_data.analyses_count = 1 THEN 'individual'
            WHEN package_data.analyses_count <= 10 THEN 'basic'
            WHEN package_data.analyses_count <= 50 THEN 'professional'
            ELSE 'enterprise'
          END;
          RAISE LOG 'Found package data: % analyses, type: %', analyses_to_add, package_type_value;
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE LOG 'Error parsing package_id from description: %', SQLERRM;
      END;
    END IF;
    
    -- Si no encontramos paquete, usar fallback basado en analyses_purchased
    IF analyses_to_add = 0 AND NEW.analyses_purchased IS NOT NULL AND NEW.analyses_purchased > 0 THEN
      analyses_to_add := NEW.analyses_purchased;
      package_type_value := CASE 
        WHEN analyses_to_add = 1 THEN 'individual'
        WHEN analyses_to_add <= 10 THEN 'basic'
        WHEN analyses_to_add <= 50 THEN 'professional'
        ELSE 'enterprise'
      END;
      RAISE LOG 'Using analyses_purchased fallback: % analyses, type: %', analyses_to_add, package_type_value;
    END IF;
    
    -- Si aún no tenemos análisis, calcular basado en precio del sistema
    IF analyses_to_add = 0 THEN
      SELECT (setting_value->>'value')::DECIMAL INTO analysis_price
      FROM system_settings
      WHERE setting_key = 'additional_analysis_price';
      
      IF analysis_price IS NOT NULL AND analysis_price > 0 THEN
        analyses_to_add := GREATEST(1, FLOOR(amount_paid_euros / analysis_price));
        package_type_value := 'individual';
        RAISE LOG 'Using price-based fallback: % analyses (%.2f / %.2f)', analyses_to_add, amount_paid_euros, analysis_price;
      ELSE
        -- Último fallback: 1 análisis por cada 15 euros
        analyses_to_add := GREATEST(1, FLOOR(amount_paid_euros / 15.0));
        package_type_value := 'individual';
        RAISE LOG 'Using final fallback: % analyses (%.2f / 15.0)', analyses_to_add, amount_paid_euros;
      END IF;
    END IF;
    
    -- Llamar a add_paid_analyses si tenemos análisis que añadir
    IF analyses_to_add > 0 THEN
      RAISE LOG 'Calling add_paid_analyses with: user_id=%, analyses_count=%, package_type=%, payment_intent_id=%, amount_paid=%.2f', 
        NEW.user_id, analyses_to_add, package_type_value, NEW.stripe_payment_intent_id, amount_paid_euros;
      
      PERFORM add_paid_analyses(
        p_user_id := NEW.user_id,
        p_analyses_count := analyses_to_add,
        p_package_type := package_type_value,
        p_stripe_payment_intent_id := NEW.stripe_payment_intent_id,
        p_amount_paid := amount_paid_euros
      );
      
      RAISE LOG 'Successfully added % paid analyses for user %', analyses_to_add, NEW.user_id;
    ELSE
      RAISE LOG 'No analyses to add for payment %', NEW.id;
    END IF;
    
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Crear el trigger que se ejecuta AFTER UPDATE en la tabla payments
CREATE TRIGGER trigger_payment_completion_add_balance
  AFTER UPDATE ON payments
  FOR EACH ROW
  EXECUTE FUNCTION trigger_add_paid_analyses_on_payment_completion();

-- Grant permissions
GRANT EXECUTE ON FUNCTION trigger_add_paid_analyses_on_payment_completion() TO authenticated;

-- Comentarios
COMMENT ON FUNCTION trigger_add_paid_analyses_on_payment_completion() IS 'Trigger function que automáticamente añade análisis pagados al balance del usuario cuando un payment se completa';
COMMENT ON TRIGGER trigger_payment_completion_add_balance ON payments IS 'Trigger que ejecuta add_paid_analyses automáticamente cuando un payment cambia a status completed';