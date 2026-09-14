-- Baseline del esquema de produccion (proyecto rygxfjsxvejrgymbxcfw) a 2026-09-14.
--
-- Generado con pg_dump 17 (--schema-only --schema=public --no-owner --no-privileges)
-- y ajustado a mano para usarse como migracion:
--   * quitados los meta-comandos de psql (\restrict/\unrestrict), CREATE SCHEMA public
--     y los SET de sesion del dump, que rompen o contaminan la ejecucion con la CLI;
--   * anadidos al final los objetos fuera de public (trigger en auth.users, buckets y
--     politicas de storage), copiados del estado real de produccion.
--
-- En produccion esta migracion se marca como aplicada con `supabase migration repair`
-- y NO se ejecuta. Solo se ejecuta al crear una base nueva (staging/local).
-- Refleja produccion tal cual, incluidos sus problemas de seguridad: se corrigen en
-- migraciones posteriores, no editando este archivo.

SET check_function_bodies = false;

--
-- Name: user_paid_analyses_balance; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_paid_analyses_balance (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    remaining_analyses integer DEFAULT 0 NOT NULL,
    total_purchased integer DEFAULT 0 NOT NULL,
    total_used integer DEFAULT 0 NOT NULL,
    package_type character varying(50) DEFAULT 'individual'::character varying,
    purchase_history jsonb DEFAULT '[]'::jsonb,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT user_paid_analyses_balance_remaining_analyses_check CHECK ((remaining_analyses >= 0)),
    CONSTRAINT user_paid_analyses_balance_total_purchased_check CHECK ((total_purchased >= 0)),
    CONSTRAINT user_paid_analyses_balance_total_used_check CHECK ((total_used >= 0))
);


--
-- Name: add_paid_analyses(uuid, integer, character varying, text, numeric); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.add_paid_analyses(p_user_id uuid, p_analyses_count integer, p_package_type character varying DEFAULT 'individual'::character varying, p_stripe_payment_intent_id text DEFAULT NULL::text, p_amount_paid numeric DEFAULT NULL::numeric) RETURNS public.user_paid_analyses_balance
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    balance_record user_paid_analyses_balance;
    purchase_entry JSONB;
BEGIN
    -- Validate input
    IF p_analyses_count <= 0 THEN
        RAISE EXCEPTION 'Analyses count must be positive';
    END IF;
    
    -- Get or create balance record
    SELECT * INTO balance_record FROM get_or_create_paid_analyses_balance(p_user_id);
    
    -- Create purchase history entry
    purchase_entry := jsonb_build_object(
        'date', NOW(),
        'analyses_count', p_analyses_count,
        'package_type', p_package_type,
        'stripe_payment_intent_id', p_stripe_payment_intent_id,
        'amount_paid', p_amount_paid
    );
    
    -- Update balance
    UPDATE user_paid_analyses_balance
    SET 
        remaining_analyses = remaining_analyses + p_analyses_count,
        total_purchased = total_purchased + p_analyses_count,
        package_type = p_package_type,
        purchase_history = purchase_history || purchase_entry,
        updated_at = NOW()
    WHERE user_id = p_user_id
    RETURNING * INTO balance_record;
    
    RETURN balance_record;
END;
$$;


--
-- Name: can_user_create_analysis(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.can_user_create_analysis() RETURNS jsonb
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  current_year INTEGER := EXTRACT(YEAR FROM NOW());
  current_month INTEGER := EXTRACT(MONTH FROM NOW());
  free_limit INTEGER;
  billing_enabled BOOLEAN;
  current_total_analyses INTEGER := 0;
  user_workshop_id UUID;
  remaining_paid_analyses INTEGER := 0;
  can_create BOOLEAN := FALSE;
  reason TEXT := '';
BEGIN
  -- Obtener configuraciones del sistema
  SELECT (get_system_setting('monthly_free_analyses_limit')->>'value')::INTEGER INTO free_limit;
  SELECT (get_system_setting('billing_enabled')->>'value')::BOOLEAN INTO billing_enabled;
  
  -- Obtener el workshop_id del usuario actual
  SELECT workshop_id INTO user_workshop_id 
  FROM profiles 
  WHERE id = auth.uid();
  
  -- Contar análisis reales del mes actual
  SELECT COUNT(*) INTO current_total_analyses
  FROM analysis 
  WHERE workshop_id = user_workshop_id
    AND EXTRACT(YEAR FROM created_at) = current_year
    AND EXTRACT(MONTH FROM created_at) = current_month;
  
  -- Obtener análisis pagados restantes
  SELECT remaining_analyses INTO remaining_paid_analyses
  FROM get_paid_analyses_balance(auth.uid())
  LIMIT 1;
  
  IF remaining_paid_analyses IS NULL THEN
    remaining_paid_analyses := 0;
  END IF;
  
  -- Determinar si puede crear análisis
  IF current_total_analyses < free_limit THEN
    -- Tiene análisis gratuitos disponibles
    can_create := TRUE;
    reason := 'free_analysis_available';
  ELSIF remaining_paid_analyses > 0 THEN
    -- Tiene análisis pagados disponibles
    can_create := TRUE;
    reason := 'paid_analysis_available';
  ELSIF billing_enabled THEN
    -- Puede pagar por análisis adicional
    can_create := TRUE;
    reason := 'payment_required';
  ELSE
    -- No puede crear más análisis
    can_create := FALSE;
    reason := 'limit_reached_billing_disabled';
  END IF;
  
  RETURN jsonb_build_object(
    'can_create', can_create,
    'reason', reason,
    'free_analyses_used', LEAST(current_total_analyses, free_limit),
    'free_analyses_limit', free_limit,
    'remaining_free_analyses', GREATEST(0, free_limit - current_total_analyses),
    'remaining_paid_analyses', remaining_paid_analyses,
    'billing_enabled', billing_enabled
  );
END;
$$;


--
-- Name: complete_user_registration(uuid, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.complete_user_registration(user_id uuid, workshop_id uuid, user_phone text DEFAULT NULL::text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Update user profile with workshop_id and phone
    UPDATE public.profiles 
    SET 
        workshop_id = complete_user_registration.workshop_id,
        phone = user_phone,
        updated_at = now()
    WHERE id = user_id;
END;
$$;


--
-- Name: consume_paid_analysis(uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.consume_paid_analysis(p_user_id uuid) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    balance_record user_paid_analyses_balance;
BEGIN
    -- Get current balance
    SELECT * INTO balance_record
    FROM user_paid_analyses_balance
    WHERE user_id = p_user_id;
    
    -- If no balance or no remaining analyses, return false
    IF NOT FOUND OR balance_record.remaining_analyses <= 0 THEN
        RETURN FALSE;
    END IF;
    
    -- Consume one analysis
    UPDATE user_paid_analyses_balance
    SET 
        remaining_analyses = remaining_analyses - 1,
        total_used = total_used + 1,
        updated_at = NOW()
    WHERE user_id = p_user_id;
    
    RETURN TRUE;
END;
$$;


--
-- Name: create_payment_record(uuid, text, text, integer, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.create_payment_record(workshop_id_param uuid, stripe_payment_intent_id_param text, stripe_session_id_param text, amount_cents_param integer, currency_param text DEFAULT 'EUR'::text, analysis_month_param text DEFAULT NULL::text, description_param text DEFAULT NULL::text) RETURNS uuid
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  payment_id UUID;
  current_month TEXT;
BEGIN
  -- Usar el mes actual si no se proporciona
  current_month := COALESCE(analysis_month_param, TO_CHAR(NOW(), 'YYYY-MM'));
  
  -- Insertar registro de pago
  INSERT INTO payments (
    workshop_id,
    user_id,
    stripe_payment_intent_id,
    stripe_session_id,
    amount_cents,
    currency,
    status,
    analysis_month,
    analyses_purchased,
    unit_price_cents,
    description
  ) VALUES (
    workshop_id_param,
    auth.uid(),
    stripe_payment_intent_id_param,
    stripe_session_id_param,
    amount_cents_param,
    currency_param,
    'pending',
    current_month,
    1, -- Por defecto 1 análisis
    amount_cents_param, -- Por ahora el precio unitario es igual al total
    description_param
  ) RETURNING id INTO payment_id;
  
  RETURN payment_id;
END;
$$;


--
-- Name: create_payment_record(uuid, uuid, text, text, integer, text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.create_payment_record(workshop_id_param uuid, user_id_param uuid, stripe_payment_intent_id_param text, stripe_session_id_param text, amount_cents_param integer, stripe_customer_id_param text DEFAULT NULL::text, currency_param text DEFAULT 'EUR'::text, analysis_month_param text DEFAULT NULL::text, description_param text DEFAULT NULL::text) RETURNS uuid
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  payment_id UUID;
  current_month TEXT;
BEGIN
  -- Usar el mes actual si no se proporciona
  current_month := COALESCE(analysis_month_param, TO_CHAR(NOW(), 'YYYY-MM'));
  
  -- Insertar registro de pago
  INSERT INTO payments (
    workshop_id,
    user_id,
    stripe_payment_intent_id,
    stripe_session_id,
    stripe_customer_id,
    amount_cents,
    currency,
    status,
    analysis_month,
    analyses_purchased,
    unit_price_cents,
    description
  ) VALUES (
    workshop_id_param,
    user_id_param,
    stripe_payment_intent_id_param,
    stripe_session_id_param,
    stripe_customer_id_param,
    amount_cents_param,
    currency_param,
    'pending',
    current_month,
    1, -- Por defecto 1 análisis
    amount_cents_param, -- Por ahora el precio unitario es igual al total
    description_param
  ) RETURNING id INTO payment_id;

  RETURN payment_id;
END;
$$;


--
-- Name: create_stripe_payment_intent(integer, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.create_stripe_payment_intent(amount_cents integer, currency_code text DEFAULT 'eur'::text, description_text text DEFAULT NULL::text) RETURNS jsonb
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  payment_record stripe_payments;
  mock_payment_intent_id TEXT;
BEGIN
  -- Generar un ID simulado para el payment intent (en producción esto vendrá de Stripe)
  mock_payment_intent_id := 'pi_mock_' || gen_random_uuid()::TEXT;
  
  -- Insertar registro de pago
  INSERT INTO stripe_payments (
    user_id, 
    payment_intent_id, 
    amount, 
    currency, 
    status, 
    description,
    metadata
  ) VALUES (
    auth.uid(),
    mock_payment_intent_id,
    amount_cents / 100.0,
    currency_code,
    'requires_payment_method',
    description_text,
    jsonb_build_object(
      'user_id', auth.uid(),
      'created_by', 'system',
      'type', 'additional_analysis'
    )
  ) RETURNING * INTO payment_record;
  
  -- Retornar información del payment intent
  RETURN jsonb_build_object(
    'payment_intent_id', payment_record.payment_intent_id,
    'amount', payment_record.amount,
    'currency', payment_record.currency,
    'status', payment_record.status,
    'client_secret', 'pi_mock_secret_' || gen_random_uuid()::TEXT -- En producción esto vendrá de Stripe
  );
END;
$$;


--
-- Name: get_active_analysis_packages(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_active_analysis_packages() RETURNS TABLE(id uuid, name character varying, description text, analyses_count integer, price_per_analysis numeric, total_price numeric, discount_percentage numeric, sort_order integer)
    LANGUAGE plpgsql
    AS $$
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
$$;


--
-- Name: get_active_packages(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_active_packages() RETURNS TABLE(id uuid, name character varying, description text, analyses_count integer, price_per_analysis numeric, total_price numeric, discount_percentage numeric, sort_order integer)
    LANGUAGE plpgsql
    AS $$
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
$$;


--
-- Name: get_analysis_package_by_id(uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_analysis_package_by_id(package_id uuid) RETURNS TABLE(id uuid, name character varying, description text, analyses_count integer, price_per_analysis numeric, total_price numeric, discount_percentage numeric)
    LANGUAGE plpgsql
    AS $$
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
$$;


--
-- Name: get_current_monthly_usage(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_current_monthly_usage() RETURNS jsonb
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  current_year INTEGER := EXTRACT(YEAR FROM NOW());
  current_month INTEGER := EXTRACT(MONTH FROM NOW());
  usage_record user_monthly_usage;
  paid_balance_record RECORD;
  free_limit INTEGER;
  actual_total_analyses INTEGER := 0;
  actual_free_analyses INTEGER := 0;
  actual_paid_analyses INTEGER := 0;
  user_workshop_id UUID;
  remaining_paid_analyses INTEGER := 0;
BEGIN
  -- Obtener configuraciones del sistema
  SELECT (get_system_setting('monthly_free_analyses_limit')->>'value')::INTEGER INTO free_limit;
  
  -- Obtener el workshop_id del usuario actual
  SELECT workshop_id INTO user_workshop_id 
  FROM profiles 
  WHERE id = auth.uid();
  
  -- Contar análisis reales del mes actual desde la tabla analysis
  SELECT COUNT(*) INTO actual_total_analyses
  FROM analysis 
  WHERE workshop_id = user_workshop_id
    AND EXTRACT(YEAR FROM created_at) = current_year
    AND EXTRACT(MONTH FROM created_at) = current_month;
  
  -- Calcular análisis gratuitos y de pago basado en el límite
  actual_free_analyses := LEAST(actual_total_analyses, free_limit);
  actual_paid_analyses := GREATEST(0, actual_total_analyses - free_limit);
  
  -- Obtener balance de análisis pagados
  SELECT * INTO paid_balance_record 
  FROM get_paid_analyses_balance(auth.uid()) 
  LIMIT 1;
  
  IF paid_balance_record IS NOT NULL THEN
    remaining_paid_analyses := paid_balance_record.remaining_analyses;
  ELSE
    remaining_paid_analyses := 0;
  END IF;
  
  -- Obtener registro de uso mensual (crear si no existe) para obtener payment_status y total_amount_due
  SELECT * INTO usage_record FROM get_or_create_monthly_usage(current_year, current_month);
  
  RETURN jsonb_build_object(
    'total_analyses', actual_total_analyses,
    'free_analyses_used', actual_free_analyses,
    'paid_analyses_count', actual_paid_analyses,
    'free_analyses_limit', free_limit,
    'remaining_free_analyses', GREATEST(0, free_limit - actual_free_analyses),
    'remaining_paid_analyses', remaining_paid_analyses,
    'total_amount_due', usage_record.total_amount_due,
    'payment_status', usage_record.payment_status,
    'year', current_year,
    'month', current_month
  );
END;
$$;


--
-- Name: user_monthly_usage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_monthly_usage (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    year integer NOT NULL,
    month integer NOT NULL,
    total_amount_due numeric(10,2) DEFAULT 0,
    payment_status character varying(20) DEFAULT 'pending'::character varying,
    stripe_payment_intent_id text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT check_month_range CHECK (((month >= 1) AND (month <= 12))),
    CONSTRAINT check_payment_status CHECK (((payment_status)::text = ANY ((ARRAY['pending'::character varying, 'paid'::character varying, 'overdue'::character varying, 'failed'::character varying])::text[]))),
    CONSTRAINT check_year_range CHECK (((year >= 2024) AND (year <= 2100)))
);


--
-- Name: TABLE user_monthly_usage; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.user_monthly_usage IS 'Tabla simplificada para seguimiento de pagos mensuales. Los conteos de análisis se calculan dinámicamente desde la tabla analysis.';


--
-- Name: COLUMN user_monthly_usage.total_amount_due; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.user_monthly_usage.total_amount_due IS 'Monto total adeudado por análisis de pago del mes';


--
-- Name: COLUMN user_monthly_usage.payment_status; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.user_monthly_usage.payment_status IS 'Estado del pago: pending, paid, overdue';


--
-- Name: COLUMN user_monthly_usage.stripe_payment_intent_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.user_monthly_usage.stripe_payment_intent_id IS 'ID del payment intent de Stripe para este mes';


--
-- Name: get_or_create_monthly_usage(integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_or_create_monthly_usage(target_year integer DEFAULT NULL::integer, target_month integer DEFAULT NULL::integer) RETURNS public.user_monthly_usage
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  current_year INTEGER := COALESCE(target_year, EXTRACT(YEAR FROM NOW()));
  current_month INTEGER := COALESCE(target_month, EXTRACT(MONTH FROM NOW()));
  usage_record user_monthly_usage;
BEGIN
  -- Intentar obtener el registro existente
  SELECT * INTO usage_record 
  FROM user_monthly_usage 
  WHERE user_id = auth.uid() 
    AND year = current_year 
    AND month = current_month;
  
  -- Si no existe, crear uno nuevo
  IF NOT FOUND THEN
    INSERT INTO user_monthly_usage (
      user_id, 
      year, 
      month,
      total_amount_due,
      payment_status
    ) VALUES (
      auth.uid(), 
      current_year, 
      current_month,
      0,
      'pending'
    ) RETURNING * INTO usage_record;
  END IF;
  
  RETURN usage_record;
END;
$$;


--
-- Name: get_or_create_paid_analyses_balance(uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_or_create_paid_analyses_balance(p_user_id uuid) RETURNS public.user_paid_analyses_balance
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    balance_record user_paid_analyses_balance;
BEGIN
    -- Try to get existing balance
    SELECT * INTO balance_record
    FROM user_paid_analyses_balance
    WHERE user_id = p_user_id;
    
    -- If no balance exists, create one
    IF NOT FOUND THEN
        INSERT INTO user_paid_analyses_balance (user_id)
        VALUES (p_user_id)
        RETURNING * INTO balance_record;
    END IF;
    
    RETURN balance_record;
END;
$$;


--
-- Name: get_package_by_id(uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_package_by_id(package_id uuid) RETURNS TABLE(id uuid, name character varying, description text, analyses_count integer, price_per_analysis numeric, total_price numeric, discount_percentage numeric)
    LANGUAGE plpgsql
    AS $$
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
$$;


--
-- Name: get_paid_analyses_balance(uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_paid_analyses_balance(p_user_id uuid) RETURNS TABLE(remaining_analyses integer, total_purchased integer, total_used integer, package_type character varying, purchase_history jsonb)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        COALESCE(upab.remaining_analyses, 0) as remaining_analyses,
        COALESCE(upab.total_purchased, 0) as total_purchased,
        COALESCE(upab.total_used, 0) as total_used,
        COALESCE(upab.package_type, 'individual') as package_type,
        COALESCE(upab.purchase_history, '[]'::jsonb) as purchase_history
    FROM user_paid_analyses_balance upab
    WHERE upab.user_id = p_user_id
    
    UNION ALL
    
    SELECT 0, 0, 0, 'individual', '[]'::jsonb
    WHERE NOT EXISTS (
        SELECT 1 FROM user_paid_analyses_balance WHERE user_id = p_user_id
    );
END;
$$;


--
-- Name: get_payment_statistics(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_payment_statistics() RETURNS jsonb
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  stats JSONB;
BEGIN
  -- Verificar que el usuario sea admin
  IF NOT EXISTS (
    SELECT 1 FROM profiles 
    WHERE id = auth.uid() AND role = 'admin'
  ) THEN
    RAISE EXCEPTION 'Access denied - admin only';
  END IF;
  
  SELECT jsonb_build_object(
    'total_revenue_cents', COALESCE(SUM(CASE WHEN status = 'succeeded' THEN amount_cents ELSE 0 END), 0),
    'total_revenue_euros', ROUND(COALESCE(SUM(CASE WHEN status = 'succeeded' THEN amount_cents ELSE 0 END), 0) / 100.0, 2),
    'total_payments', COUNT(*),
    'successful_payments', COUNT(*) FILTER (WHERE status = 'succeeded'),
    'pending_payments', COUNT(*) FILTER (WHERE status = 'pending'),
    'failed_payments', COUNT(*) FILTER (WHERE status IN ('failed', 'canceled')),
    'current_month_revenue_cents', COALESCE(SUM(CASE 
      WHEN status = 'succeeded' AND analysis_month = TO_CHAR(NOW(), 'YYYY-MM') 
      THEN amount_cents ELSE 0 END), 0),
    'workshops_with_payments', COUNT(DISTINCT workshop_id) FILTER (WHERE status = 'succeeded')
  ) INTO stats
  FROM payments;
  
  RETURN stats;
END;
$$;


--
-- Name: get_system_setting(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_system_setting(setting_name text) RETURNS jsonb
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  RETURN (SELECT setting_value FROM system_settings WHERE setting_key = setting_name);
END;
$$;


--
-- Name: get_user_payment_history(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_user_payment_history() RETURNS jsonb
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  payments JSONB;
BEGIN
  SELECT jsonb_agg(
    jsonb_build_object(
      'id', sp.id,
      'amount', sp.amount,
      'currency', sp.currency,
      'status', sp.status,
      'description', sp.description,
      'created_at', sp.created_at,
      'month_year', TO_CHAR(sp.created_at, 'MM/YYYY')
    ) ORDER BY sp.created_at DESC
  ) INTO payments
  FROM stripe_payments sp
  WHERE sp.user_id = auth.uid();
  
  RETURN COALESCE(payments, '[]'::JSONB);
END;
$$;


--
-- Name: get_workshop_payment_history(uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_workshop_payment_history(workshop_id_param uuid DEFAULT NULL::uuid) RETURNS jsonb
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  target_workshop_id UUID;
  payments_data JSONB;
BEGIN
  -- Si no se proporciona workshop_id, usar el del usuario actual
  IF workshop_id_param IS NULL THEN
    SELECT workshop_id INTO target_workshop_id
    FROM profiles 
    WHERE id = auth.uid();
  ELSE
    target_workshop_id := workshop_id_param;
  END IF;
  
  -- Verificar que el usuario tenga acceso al workshop
  IF NOT EXISTS (
    SELECT 1 FROM profiles 
    WHERE id = auth.uid() 
    AND (workshop_id = target_workshop_id OR role = 'admin')
  ) THEN
    RAISE EXCEPTION 'Access denied to workshop payments';
  END IF;
  
  SELECT jsonb_agg(
    jsonb_build_object(
      'id', p.id,
      'amount_cents', p.amount_cents,
      'amount_euros', ROUND(p.amount_cents / 100.0, 2),
      'currency', p.currency,
      'status', p.status,
      'description', p.description,
      'analysis_month', p.analysis_month,
      'analyses_purchased', p.analyses_purchased,
      'payment_method', p.payment_method,
      'created_at', p.created_at,
      'paid_at', p.paid_at
    ) ORDER BY p.created_at DESC
  ) INTO payments_data
  FROM payments p
  WHERE p.workshop_id = target_workshop_id;
  
  RETURN COALESCE(payments_data, '[]'::JSONB);
END;
$$;


--
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  INSERT INTO public.profiles (id, email, role, full_name)
  VALUES (
    new.id, 
    new.email, 
    COALESCE(new.raw_user_meta_data->>'role', 'admin_mechanic'),
    COALESCE(new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'workshop_name', 'Usuario')
  );
  RETURN new;
END;
$$;


--
-- Name: handle_workshop_registration(text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.handle_workshop_registration(workshop_name text, workshop_email text, workshop_phone text DEFAULT NULL::text) RETURNS uuid
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    workshop_id UUID;
BEGIN
    -- Insert new workshop
    INSERT INTO public.workshops (name, email, phone)
    VALUES (workshop_name, workshop_email, workshop_phone)
    RETURNING id INTO workshop_id;
    
    RETURN workshop_id;
END;
$$;


--
-- Name: increment_analysis_count(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.increment_analysis_count() RETURNS jsonb
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  current_year INTEGER := EXTRACT(YEAR FROM NOW());
  current_month INTEGER := EXTRACT(MONTH FROM NOW());
  usage_record user_monthly_usage;
  free_limit INTEGER;
  additional_price DECIMAL;
  billing_enabled BOOLEAN;
  current_total_analyses INTEGER := 0;
  user_workshop_id UUID;
  is_free_analysis BOOLEAN := FALSE;
  amount_to_charge DECIMAL := 0;
  paid_analysis_consumed BOOLEAN := FALSE;
  remaining_paid_analyses INTEGER := 0;
BEGIN
  -- Obtener configuraciones del sistema
  SELECT (get_system_setting('monthly_free_analyses_limit')->>'value')::INTEGER INTO free_limit;
  SELECT (get_system_setting('additional_analysis_price')->>'value')::DECIMAL INTO additional_price;
  SELECT (get_system_setting('billing_enabled')->>'value')::BOOLEAN INTO billing_enabled;
  
  -- Obtener el workshop_id del usuario actual
  SELECT workshop_id INTO user_workshop_id 
  FROM profiles 
  WHERE id = auth.uid();
  
  -- Contar análisis reales del mes actual
  SELECT COUNT(*) INTO current_total_analyses
  FROM analysis 
  WHERE workshop_id = user_workshop_id
    AND EXTRACT(YEAR FROM created_at) = current_year
    AND EXTRACT(MONTH FROM created_at) = current_month;
  
  -- Determinar si este análisis es gratuito, de pago con balance, o requiere pago
  IF current_total_analyses < free_limit THEN
    -- Análisis gratuito
    is_free_analysis := TRUE;
  ELSE
    -- Análisis de pago - intentar consumir del balance primero
    SELECT consume_paid_analysis(auth.uid()) INTO paid_analysis_consumed;
    
    IF paid_analysis_consumed THEN
      -- Se consumió un análisis del balance pagado
      is_free_analysis := FALSE;
      amount_to_charge := 0;
    ELSE
      -- No hay balance pagado, cobrar si la facturación está habilitada
      IF billing_enabled THEN
        amount_to_charge := additional_price;
      END IF;
    END IF;
  END IF;
  
  -- Obtener o crear registro de uso mensual
  SELECT * INTO usage_record FROM get_or_create_monthly_usage(current_year, current_month);
  
  -- Solo actualizar el total_amount_due si hay cargo
  IF amount_to_charge > 0 THEN
    UPDATE user_monthly_usage 
    SET 
      total_amount_due = total_amount_due + amount_to_charge,
      updated_at = NOW()
    WHERE user_id = auth.uid() 
      AND year = current_year 
      AND month = current_month;
  END IF;
  
  -- Obtener análisis pagados restantes después de la operación
  SELECT remaining_analyses INTO remaining_paid_analyses
  FROM get_paid_analyses_balance(auth.uid())
  LIMIT 1;
  
  IF remaining_paid_analyses IS NULL THEN
    remaining_paid_analyses := 0;
  END IF;
  
  -- Retornar información sobre el análisis
  RETURN jsonb_build_object(
    'is_free', is_free_analysis,
    'paid_analysis_consumed', paid_analysis_consumed,
    'amount_charged', amount_to_charge,
    'total_analyses', current_total_analyses + 1,
    'free_analyses_used', LEAST(current_total_analyses + 1, free_limit),
    'free_analyses_limit', free_limit,
    'remaining_paid_analyses', remaining_paid_analyses
  );
END;
$$;


--
-- Name: is_admin_user(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.is_admin_user() RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  -- Verify if the authenticated user has admin role in auth.users metadata
  RETURN auth.jwt() ->> 'email' IN (
    SELECT email FROM auth.users 
    WHERE raw_user_meta_data ->> 'role' = 'admin'
  );
END;
$$;


--
-- Name: mark_payment_completed(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.mark_payment_completed(stripe_payment_intent_id text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  UPDATE user_monthly_usage 
  SET 
    payment_status = 'paid',
    updated_at = NOW()
  WHERE stripe_payment_intent_id = stripe_payment_intent_id;
  
  RETURN FOUND;
END;
$$;


--
-- Name: process_analysis_with_payment_check(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.process_analysis_with_payment_check() RETURNS jsonb
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  usage_info JSONB;
  payment_info JSONB;
  billing_enabled BOOLEAN;
BEGIN
  -- Verificar si la facturación está habilitada
  SELECT (get_system_setting('billing_enabled')->>'value')::BOOLEAN INTO billing_enabled;
  
  -- Incrementar el conteo de análisis
  SELECT increment_analysis_count() INTO usage_info;
  
  -- Si no es gratuito y la facturación está habilitada, crear payment intent
  IF NOT (usage_info->>'is_free')::BOOLEAN AND billing_enabled THEN
    SELECT create_stripe_payment_intent(
      ((usage_info->>'amount_charged')::DECIMAL * 100)::INTEGER, -- Convertir a centavos
      'eur',
      'Análisis adicional - ' || TO_CHAR(NOW(), 'MM/YYYY')
    ) INTO payment_info;
    
    -- Actualizar el registro de uso mensual con el payment intent ID
    UPDATE user_monthly_usage 
    SET stripe_payment_intent_id = payment_info->>'payment_intent_id'
    WHERE user_id = auth.uid() 
      AND year = EXTRACT(YEAR FROM NOW())
      AND month = EXTRACT(MONTH FROM NOW());
  END IF;
  
  -- Retornar información completa
  RETURN jsonb_build_object(
    'usage_info', usage_info,
    'payment_info', COALESCE(payment_info, '{}'::JSONB),
    'requires_payment', NOT (usage_info->>'is_free')::BOOLEAN AND billing_enabled
  );
END;
$$;


--
-- Name: trigger_add_paid_analyses_on_payment_completion(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.trigger_add_paid_analyses_on_payment_completion() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
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
$$;


--
-- Name: FUNCTION trigger_add_paid_analyses_on_payment_completion(); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION public.trigger_add_paid_analyses_on_payment_completion() IS 'Trigger function que automáticamente añade análisis pagados al balance del usuario cuando un payment se completa. Utiliza el campo package_id para obtener datos exactos del paquete.';


--
-- Name: trigger_increment_analysis_count(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.trigger_increment_analysis_count() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  analysis_result JSONB;
BEGIN
  -- Call increment_analysis_count to handle the analysis counting logic
  -- This will consume paid analyses if available, or handle billing
  SELECT increment_analysis_count() INTO analysis_result;
  
  -- Log the result for debugging (optional)
  RAISE LOG 'Analysis count incremented for user %: %', auth.uid(), analysis_result;
  
  RETURN NEW;
END;
$$;


--
-- Name: update_analysis_packages_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_analysis_packages_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;


--
-- Name: update_analysis_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_analysis_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;


--
-- Name: update_paid_analyses_balance_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_paid_analyses_balance_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;


--
-- Name: update_payment_status(text, text, text, integer, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_payment_status(stripe_payment_intent_id_param text, new_status text, payment_method_param text DEFAULT NULL::text, stripe_fee_cents_param integer DEFAULT NULL::integer, stripe_session_id_param text DEFAULT NULL::text, stripe_customer_id_param text DEFAULT NULL::text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  payment_record payments;
BEGIN
  -- Actualizar el estado del pago
  UPDATE payments 
  SET 
    status = new_status,
    payment_method = COALESCE(payment_method_param, payment_method),
    stripe_fee_cents = COALESCE(stripe_fee_cents_param, stripe_fee_cents),
    stripe_session_id = COALESCE(stripe_session_id_param, stripe_session_id),
    stripe_customer_id = COALESCE(stripe_customer_id_param, stripe_customer_id),
    net_amount_cents = CASE 
      WHEN stripe_fee_cents_param IS NOT NULL 
      THEN amount_cents - stripe_fee_cents_param 
      ELSE net_amount_cents 
    END,
    paid_at = CASE WHEN new_status = 'succeeded' THEN NOW() ELSE paid_at END,
    updated_at = NOW()
  WHERE stripe_payment_intent_id = stripe_payment_intent_id_param
  RETURNING * INTO payment_record;
  
  -- Si el pago fue exitoso, actualizar el estado en user_monthly_usage
  IF new_status = 'succeeded' AND payment_record.id IS NOT NULL THEN
    PERFORM mark_payment_completed(stripe_payment_intent_id_param);
  END IF;
  
  RETURN FOUND;
END;
$$;


--
-- Name: FUNCTION update_payment_status(stripe_payment_intent_id_param text, new_status text, payment_method_param text, stripe_fee_cents_param integer, stripe_session_id_param text, stripe_customer_id_param text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION public.update_payment_status(stripe_payment_intent_id_param text, new_status text, payment_method_param text, stripe_fee_cents_param integer, stripe_session_id_param text, stripe_customer_id_param text) IS 'Updated function to handle payment status updates from simplified webhook. 
Webhook now only processes:
- checkout.session.completed (for successful payments)
- checkout.session.expired (for canceled payments) 
- payment_intent.payment_failed (for failed payments)
Removed duplicate events: payment_intent.succeeded and charge.succeeded to avoid conflicts.';


--
-- Name: update_payment_status(text, text, text, integer, integer, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_payment_status(session_id_param text, new_status text, payment_method_param text DEFAULT NULL::text, stripe_fee_cents_param integer DEFAULT NULL::integer, net_amount_cents_param integer DEFAULT NULL::integer, stripe_customer_id_param text DEFAULT NULL::text, stripe_payment_intent_id_param text DEFAULT NULL::text) RETURNS TABLE(user_id uuid, payment_id uuid)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  payment_record payments;
BEGIN
  -- Actualizar el estado del pago usando session_id
  UPDATE payments
  SET
    status = new_status,
    payment_method = COALESCE(payment_method_param, payment_method),
    stripe_fee_cents = COALESCE(stripe_fee_cents_param, stripe_fee_cents),
    stripe_customer_id = COALESCE(stripe_customer_id_param, stripe_customer_id),
    net_amount_cents = COALESCE(net_amount_cents_param, net_amount_cents),
    stripe_payment_intent_id = COALESCE(stripe_payment_intent_id_param, stripe_payment_intent_id),
    paid_at = CASE WHEN new_status = 'completed' THEN NOW() ELSE paid_at END,
    updated_at = NOW()
  WHERE stripe_session_id = session_id_param
  RETURNING * INTO payment_record;

  -- Si encontramos el pago, devolver user_id y payment_id
  IF payment_record.id IS NOT NULL THEN
    -- Si el pago fue exitoso, actualizar el estado en user_monthly_usage.
    -- Se lee de payment_record para usar el intent ya actualizado por el UPDATE.
    IF new_status = 'completed' THEN
      PERFORM mark_payment_completed(payment_record.stripe_payment_intent_id);
    END IF;

    -- Devolver los datos necesarios para el webhook
    RETURN QUERY SELECT payment_record.user_id, payment_record.id;
  ELSE
    -- Si no se encontró el pago, devolver NULL. El webhook detecta este caso y
    -- reconstruye la fila desde session.metadata.
    RETURN QUERY SELECT NULL::UUID, NULL::UUID;
  END IF;
END;
$$;


--
-- Name: FUNCTION update_payment_status(session_id_param text, new_status text, payment_method_param text, stripe_fee_cents_param integer, net_amount_cents_param integer, stripe_customer_id_param text, stripe_payment_intent_id_param text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION public.update_payment_status(session_id_param text, new_status text, payment_method_param text, stripe_fee_cents_param integer, net_amount_cents_param integer, stripe_customer_id_param text, stripe_payment_intent_id_param text) IS 'Actualiza un pago localizandolo por stripe_session_id y persiste el payment intent real. La invoca stripe-webhook en checkout.session.completed y checkout.session.expired. Devuelve (NULL, NULL) si no existe la fila, sin lanzar excepcion.';


--
-- Name: update_payments_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_payments_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


--
-- Name: update_stripe_payment_status(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_stripe_payment_status(payment_intent_id_param text, new_status text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  UPDATE stripe_payments 
  SET 
    status = new_status,
    updated_at = NOW()
  WHERE payment_intent_id = payment_intent_id_param;
  
  -- Si el pago fue exitoso, actualizar el estado en user_monthly_usage
  IF new_status = 'succeeded' THEN
    PERFORM mark_payment_completed(payment_intent_id_param);
  END IF;
  
  RETURN FOUND;
END;
$$;


--
-- Name: update_stripe_payments_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_stripe_payments_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


--
-- Name: update_system_setting(text, jsonb); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_system_setting(setting_name text, new_value jsonb) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
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
$$;


--
-- Name: update_system_settings_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_system_settings_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


--
-- Name: update_user_monthly_usage_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_user_monthly_usage_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


--
-- Name: analysis; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.analysis (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    workshop_id uuid,
    pdf_url text,
    pdf_filename text,
    status text DEFAULT 'processing'::text NOT NULL,
    analysis_month date DEFAULT date_trunc('month'::text, (CURRENT_DATE)::timestamp with time zone) NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    valuation_date date,
    analysis_date date,
    user_id uuid NOT NULL,
    error_message text,
    CONSTRAINT analysis_status_check CHECK ((status = ANY (ARRAY['processing'::text, 'pending_verification'::text, 'pending_costs'::text, 'completed'::text, 'failed'::text])))
);


--
-- Name: COLUMN analysis.error_message; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.analysis.error_message IS 'Mensaje del error que hizo fallar el analisis; lo rellena el manejador de errores del frontend al marcar status = failed';


--
-- Name: analysis_packages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.analysis_packages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    analyses_count integer NOT NULL,
    price_per_analysis numeric(10,2) NOT NULL,
    total_price numeric(10,2) NOT NULL,
    discount_percentage numeric(5,2) DEFAULT 0,
    is_active boolean DEFAULT true,
    sort_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT analysis_packages_analyses_count_check CHECK ((analyses_count > 0)),
    CONSTRAINT analysis_packages_discount_percentage_check CHECK (((discount_percentage >= (0)::numeric) AND (discount_percentage <= (100)::numeric))),
    CONSTRAINT analysis_packages_price_per_analysis_check CHECK ((price_per_analysis > (0)::numeric)),
    CONSTRAINT analysis_packages_total_price_check CHECK ((total_price > (0)::numeric))
);


--
-- Name: TABLE analysis_packages; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.analysis_packages IS 'Tabla que almacena los diferentes paquetes de análisis disponibles para compra';


--
-- Name: COLUMN analysis_packages.analyses_count; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.analysis_packages.analyses_count IS 'Número de análisis incluidos en el paquete';


--
-- Name: COLUMN analysis_packages.price_per_analysis; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.analysis_packages.price_per_analysis IS 'Precio por análisis individual en este paquete';


--
-- Name: COLUMN analysis_packages.total_price; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.analysis_packages.total_price IS 'Precio total del paquete';


--
-- Name: COLUMN analysis_packages.discount_percentage; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.analysis_packages.discount_percentage IS 'Porcentaje de descuento aplicado respecto al precio individual';


--
-- Name: insurance_amounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.insurance_amounts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    analysis_id uuid NOT NULL,
    total_spare_parts_eur numeric(10,2),
    bodywork_labor_ut numeric(10,2),
    bodywork_labor_eur numeric(10,2),
    painting_labor_ut numeric(10,2),
    painting_labor_eur numeric(10,2),
    paint_material_eur numeric(10,2),
    net_subtotal numeric(10,2),
    iva_amount numeric(10,2),
    total_with_iva numeric(10,2),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    bodywork_labor_hours numeric(10,2),
    painting_labor_hours numeric(10,2),
    detected_units text,
    bodywork_hourly_price numeric(10,2),
    painting_hourly_price numeric(10,2),
    iva_percentage numeric(5,2),
    spare_parts_quantity integer,
    CONSTRAINT insurance_amounts_detected_units_check CHECK ((detected_units = ANY (ARRAY['UT'::text, 'HORAS'::text, 'MIXTO'::text])))
);


--
-- Name: COLUMN insurance_amounts.bodywork_labor_hours; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.insurance_amounts.bodywork_labor_hours IS 'Horas de mano de obra de chapa';


--
-- Name: COLUMN insurance_amounts.painting_labor_hours; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.insurance_amounts.painting_labor_hours IS 'Horas de mano de obra de pintura';


--
-- Name: COLUMN insurance_amounts.detected_units; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.insurance_amounts.detected_units IS 'Tipo de unidades detectadas en el PDF: UT, HORAS o MIXTO';


--
-- Name: COLUMN insurance_amounts.bodywork_hourly_price; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.insurance_amounts.bodywork_hourly_price IS 'Precio por hora de mano de obra de chapa';


--
-- Name: COLUMN insurance_amounts.painting_hourly_price; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.insurance_amounts.painting_hourly_price IS 'Precio por hora de mano de obra de pintura';


--
-- Name: COLUMN insurance_amounts.iva_percentage; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.insurance_amounts.iva_percentage IS 'Porcentaje de IVA aplicado';


--
-- Name: COLUMN insurance_amounts.spare_parts_quantity; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.insurance_amounts.spare_parts_quantity IS 'Cantidad total de ítems/elementos de repuestos extraídos del PDF';


--
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    workshop_id uuid NOT NULL,
    user_id uuid NOT NULL,
    stripe_payment_intent_id text NOT NULL,
    stripe_session_id text,
    stripe_customer_id text,
    amount_cents integer NOT NULL,
    currency text DEFAULT 'EUR'::text NOT NULL,
    status text NOT NULL,
    analysis_month text NOT NULL,
    analyses_purchased integer DEFAULT 1 NOT NULL,
    unit_price_cents integer NOT NULL,
    payment_method text,
    stripe_fee_cents integer,
    net_amount_cents integer,
    description text,
    created_at timestamp with time zone DEFAULT now(),
    paid_at timestamp with time zone,
    updated_at timestamp with time zone DEFAULT now(),
    package_id uuid
);


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    email text NOT NULL,
    role text NOT NULL,
    full_name text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    workshop_id uuid,
    phone text,
    CONSTRAINT profiles_role_check CHECK ((role = ANY (ARRAY['admin'::text, 'admin_mechanic'::text])))
);


--
-- Name: COLUMN profiles.email; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.profiles.email IS 'Email del usuario para autenticación. Debe coincidir con auth.users.email.';


--
-- Name: stripe_payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stripe_payments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    payment_intent_id text NOT NULL,
    amount numeric(10,2) NOT NULL,
    currency character varying(3) DEFAULT 'EUR'::character varying,
    status character varying(50) NOT NULL,
    description text,
    metadata jsonb DEFAULT '{}'::jsonb,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: system_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.system_settings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    setting_key character varying(100) NOT NULL,
    setting_value jsonb NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    updated_by uuid
);


--
-- Name: vehicle_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vehicle_data (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    analysis_id uuid NOT NULL,
    license_plate text,
    vin text,
    manufacturer text,
    model text,
    internal_reference text,
    system text,
    hourly_price numeric(10,2),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: workshop_costs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workshop_costs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    analysis_id uuid NOT NULL,
    spare_parts_purchase_cost numeric(10,2),
    bodywork_actual_hours numeric(8,2),
    bodywork_hourly_cost numeric(8,2),
    painting_actual_hours numeric(8,2),
    painting_hourly_cost numeric(8,2),
    painting_consumables_cost numeric(10,2),
    subcontractor_costs numeric(10,2),
    other_costs numeric(10,2),
    notes text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: TABLE workshop_costs; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.workshop_costs IS 'RLS temporarily disabled due to session authentication issues. Should be re-enabled once auth flow is fixed.';


--
-- Name: workshops; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workshops (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    email text,
    phone text,
    address text,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


--
-- Name: COLUMN workshops.email; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.workshops.email IS 'Email comercial del taller (opcional). Puede ser diferente al email del usuario admin_mechanic.';


--
-- Name: analysis_packages analysis_packages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analysis_packages
    ADD CONSTRAINT analysis_packages_pkey PRIMARY KEY (id);


--
-- Name: analysis analysis_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analysis
    ADD CONSTRAINT analysis_pkey PRIMARY KEY (id);


--
-- Name: insurance_amounts insurance_amounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.insurance_amounts
    ADD CONSTRAINT insurance_amounts_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: payments payments_stripe_payment_intent_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_stripe_payment_intent_id_key UNIQUE (stripe_payment_intent_id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: stripe_payments stripe_payments_payment_intent_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_payments
    ADD CONSTRAINT stripe_payments_payment_intent_id_key UNIQUE (payment_intent_id);


--
-- Name: stripe_payments stripe_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_payments
    ADD CONSTRAINT stripe_payments_pkey PRIMARY KEY (id);


--
-- Name: system_settings system_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_pkey PRIMARY KEY (id);


--
-- Name: system_settings system_settings_setting_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_setting_key_key UNIQUE (setting_key);


--
-- Name: user_monthly_usage user_monthly_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_monthly_usage
    ADD CONSTRAINT user_monthly_usage_pkey PRIMARY KEY (id);


--
-- Name: user_monthly_usage user_monthly_usage_user_id_year_month_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_monthly_usage
    ADD CONSTRAINT user_monthly_usage_user_id_year_month_key UNIQUE (user_id, year, month);


--
-- Name: user_paid_analyses_balance user_paid_analyses_balance_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_paid_analyses_balance
    ADD CONSTRAINT user_paid_analyses_balance_pkey PRIMARY KEY (id);


--
-- Name: vehicle_data vehicle_data_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vehicle_data
    ADD CONSTRAINT vehicle_data_pkey PRIMARY KEY (id);


--
-- Name: workshop_costs workshop_costs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workshop_costs
    ADD CONSTRAINT workshop_costs_pkey PRIMARY KEY (id);


--
-- Name: workshops workshops_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workshops
    ADD CONSTRAINT workshops_email_key UNIQUE (email);


--
-- Name: workshops workshops_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workshops
    ADD CONSTRAINT workshops_pkey PRIMARY KEY (id);


--
-- Name: idx_analysis_analysis_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_analysis_analysis_date ON public.analysis USING btree (analysis_date);


--
-- Name: idx_analysis_month; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_analysis_month ON public.analysis USING btree (analysis_month);


--
-- Name: idx_analysis_packages_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_analysis_packages_active ON public.analysis_packages USING btree (is_active);


--
-- Name: idx_analysis_packages_sort_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_analysis_packages_sort_order ON public.analysis_packages USING btree (sort_order);


--
-- Name: idx_analysis_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_analysis_status ON public.analysis USING btree (status);


--
-- Name: idx_analysis_valuation_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_analysis_valuation_date ON public.analysis USING btree (valuation_date);


--
-- Name: idx_analysis_workshop_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_analysis_workshop_id ON public.analysis USING btree (workshop_id);


--
-- Name: idx_insurance_amounts_analysis_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_insurance_amounts_analysis_id ON public.insurance_amounts USING btree (analysis_id);


--
-- Name: idx_payments_analysis_month; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_payments_analysis_month ON public.payments USING btree (analysis_month);


--
-- Name: idx_payments_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_payments_status ON public.payments USING btree (status);


--
-- Name: idx_payments_stripe_payment_intent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_payments_stripe_payment_intent ON public.payments USING btree (stripe_payment_intent_id);


--
-- Name: idx_payments_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_payments_user_id ON public.payments USING btree (user_id);


--
-- Name: idx_payments_workshop_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_payments_workshop_id ON public.payments USING btree (workshop_id);


--
-- Name: idx_profiles_workshop_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_profiles_workshop_id ON public.profiles USING btree (workshop_id);


--
-- Name: idx_stripe_payments_payment_intent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_stripe_payments_payment_intent ON public.stripe_payments USING btree (payment_intent_id);


--
-- Name: idx_stripe_payments_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_stripe_payments_status ON public.stripe_payments USING btree (status);


--
-- Name: idx_stripe_payments_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_stripe_payments_user_id ON public.stripe_payments USING btree (user_id);


--
-- Name: idx_system_settings_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_system_settings_key ON public.system_settings USING btree (setting_key);


--
-- Name: idx_system_settings_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_system_settings_updated_at ON public.system_settings USING btree (updated_at);


--
-- Name: idx_user_monthly_usage_payment_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_monthly_usage_payment_status ON public.user_monthly_usage USING btree (payment_status);


--
-- Name: idx_user_monthly_usage_stripe_payment; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_monthly_usage_stripe_payment ON public.user_monthly_usage USING btree (stripe_payment_intent_id);


--
-- Name: idx_user_monthly_usage_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_monthly_usage_user_id ON public.user_monthly_usage USING btree (user_id);


--
-- Name: idx_user_monthly_usage_year_month; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_monthly_usage_year_month ON public.user_monthly_usage USING btree (year, month);


--
-- Name: idx_user_paid_analyses_balance_remaining; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_paid_analyses_balance_remaining ON public.user_paid_analyses_balance USING btree (remaining_analyses);


--
-- Name: idx_user_paid_analyses_balance_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_user_paid_analyses_balance_user_id ON public.user_paid_analyses_balance USING btree (user_id);


--
-- Name: idx_vehicle_data_analysis_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_vehicle_data_analysis_id ON public.vehicle_data USING btree (analysis_id);


--
-- Name: profiles_email_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX profiles_email_idx ON public.profiles USING btree (email);


--
-- Name: analysis trigger_analysis_count_increment; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_analysis_count_increment AFTER INSERT ON public.analysis FOR EACH ROW EXECUTE FUNCTION public.trigger_increment_analysis_count();


--
-- Name: analysis_packages trigger_analysis_packages_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_analysis_packages_updated_at BEFORE UPDATE ON public.analysis_packages FOR EACH ROW EXECUTE FUNCTION public.update_analysis_packages_updated_at();


--
-- Name: analysis trigger_analysis_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_analysis_updated_at BEFORE UPDATE ON public.analysis FOR EACH ROW EXECUTE FUNCTION public.update_analysis_updated_at();


--
-- Name: payments trigger_payment_completion_add_balance; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_payment_completion_add_balance AFTER UPDATE ON public.payments FOR EACH ROW EXECUTE FUNCTION public.trigger_add_paid_analyses_on_payment_completion();


--
-- Name: TRIGGER trigger_payment_completion_add_balance ON payments; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TRIGGER trigger_payment_completion_add_balance ON public.payments IS 'Trigger que ejecuta add_paid_analyses automáticamente cuando un payment cambia a status completed';


--
-- Name: user_paid_analyses_balance trigger_update_paid_analyses_balance_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_update_paid_analyses_balance_updated_at BEFORE UPDATE ON public.user_paid_analyses_balance FOR EACH ROW EXECUTE FUNCTION public.update_paid_analyses_balance_updated_at();


--
-- Name: insurance_amounts update_insurance_amounts_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_insurance_amounts_updated_at BEFORE UPDATE ON public.insurance_amounts FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: payments update_payments_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_payments_updated_at BEFORE UPDATE ON public.payments FOR EACH ROW EXECUTE FUNCTION public.update_payments_updated_at();


--
-- Name: stripe_payments update_stripe_payments_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_stripe_payments_updated_at BEFORE UPDATE ON public.stripe_payments FOR EACH ROW EXECUTE FUNCTION public.update_stripe_payments_updated_at();


--
-- Name: system_settings update_system_settings_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_system_settings_updated_at BEFORE UPDATE ON public.system_settings FOR EACH ROW EXECUTE FUNCTION public.update_system_settings_updated_at();


--
-- Name: user_monthly_usage update_user_monthly_usage_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_user_monthly_usage_updated_at BEFORE UPDATE ON public.user_monthly_usage FOR EACH ROW EXECUTE FUNCTION public.update_user_monthly_usage_updated_at();


--
-- Name: vehicle_data update_vehicle_data_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_vehicle_data_updated_at BEFORE UPDATE ON public.vehicle_data FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: workshop_costs update_workshop_costs_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_workshop_costs_updated_at BEFORE UPDATE ON public.workshop_costs FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: analysis analysis_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analysis
    ADD CONSTRAINT analysis_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- Name: analysis analysis_workshop_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analysis
    ADD CONSTRAINT analysis_workshop_id_fkey FOREIGN KEY (workshop_id) REFERENCES public.workshops(id) ON DELETE CASCADE;


--
-- Name: insurance_amounts insurance_amounts_analysis_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.insurance_amounts
    ADD CONSTRAINT insurance_amounts_analysis_id_fkey FOREIGN KEY (analysis_id) REFERENCES public.analysis(id) ON DELETE CASCADE;


--
-- Name: payments payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: payments payments_workshop_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_workshop_id_fkey FOREIGN KEY (workshop_id) REFERENCES public.workshops(id);


--
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: profiles profiles_workshop_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_workshop_id_fkey FOREIGN KEY (workshop_id) REFERENCES public.workshops(id) ON DELETE CASCADE;


--
-- Name: stripe_payments stripe_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_payments
    ADD CONSTRAINT stripe_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: system_settings system_settings_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES auth.users(id) ON DELETE SET NULL;


--
-- Name: user_monthly_usage user_monthly_usage_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_monthly_usage
    ADD CONSTRAINT user_monthly_usage_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: user_paid_analyses_balance user_paid_analyses_balance_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_paid_analyses_balance
    ADD CONSTRAINT user_paid_analyses_balance_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: vehicle_data vehicle_data_analysis_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vehicle_data
    ADD CONSTRAINT vehicle_data_analysis_id_fkey FOREIGN KEY (analysis_id) REFERENCES public.analysis(id) ON DELETE CASCADE;


--
-- Name: workshop_costs workshop_costs_analysis_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workshop_costs
    ADD CONSTRAINT workshop_costs_analysis_id_fkey FOREIGN KEY (analysis_id) REFERENCES public.analysis(id) ON DELETE CASCADE;


--
-- Name: analysis_packages Admins can manage analysis packages v2; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can manage analysis packages v2" ON public.analysis_packages USING ((((((auth.jwt() ->> 'user_metadata'::text))::jsonb ->> 'role'::text) = 'admin'::text) OR ((((auth.jwt() ->> 'raw_user_meta_data'::text))::jsonb ->> 'role'::text) = 'admin'::text)));


--
-- Name: system_settings Admins can manage system settings; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can manage system settings" ON public.system_settings USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text)))));


--
-- Name: profiles Admins can update all profiles v2; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can update all profiles v2" ON public.profiles FOR UPDATE USING (public.is_admin_user());


--
-- Name: profiles Admins can update all profiles v3; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can update all profiles v3" ON public.profiles FOR UPDATE USING ((((((auth.jwt() ->> 'user_metadata'::text))::jsonb ->> 'role'::text) = 'admin'::text) OR ((((auth.jwt() ->> 'raw_user_meta_data'::text))::jsonb ->> 'role'::text) = 'admin'::text)));


--
-- Name: user_monthly_usage Admins can view all monthly usage; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can view all monthly usage" ON public.user_monthly_usage FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text)))));


--
-- Name: payments Admins can view all payments; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can view all payments" ON public.payments FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text)))));


--
-- Name: stripe_payments Admins can view all payments; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can view all payments" ON public.stripe_payments FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text)))));


--
-- Name: profiles Admins can view all profiles v2; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can view all profiles v2" ON public.profiles FOR SELECT USING (public.is_admin_user());


--
-- Name: profiles Admins can view all profiles v3; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can view all profiles v3" ON public.profiles FOR SELECT USING ((((((auth.jwt() ->> 'user_metadata'::text))::jsonb ->> 'role'::text) = 'admin'::text) OR ((((auth.jwt() ->> 'raw_user_meta_data'::text))::jsonb ->> 'role'::text) = 'admin'::text)));


--
-- Name: workshops Allow authenticated users to create workshops; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Allow authenticated users to create workshops" ON public.workshops FOR INSERT TO authenticated WITH CHECK (true);


--
-- Name: payments Anonymous webhooks can manage payments; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Anonymous webhooks can manage payments" ON public.payments USING ((auth.uid() IS NULL));


--
-- Name: analysis_packages Anyone can view active analysis packages; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Anyone can view active analysis packages" ON public.analysis_packages FOR SELECT USING ((is_active = true));


--
-- Name: user_paid_analyses_balance System can insert paid analyses balance; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "System can insert paid analyses balance" ON public.user_paid_analyses_balance FOR INSERT WITH CHECK (true);


--
-- Name: stripe_payments System can manage payments; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "System can manage payments" ON public.stripe_payments USING (false);


--
-- Name: payments System functions can manage payments; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "System functions can manage payments" ON public.payments USING (((auth.uid() IS NULL) OR (current_setting('role'::text, true) = 'service_role'::text) OR (((current_setting('request.jwt.claims'::text, true))::json ->> 'role'::text) = 'service_role'::text)));


--
-- Name: analysis Users can insert analysis for their workshop; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can insert analysis for their workshop" ON public.analysis FOR INSERT WITH CHECK ((workshop_id IN ( SELECT workshops.id
   FROM public.workshops
  WHERE (workshops.id IN ( SELECT profiles.workshop_id
           FROM public.profiles
          WHERE (profiles.id = auth.uid()))))));


--
-- Name: analysis Users can insert their own analysis; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can insert their own analysis" ON public.analysis FOR INSERT WITH CHECK (((user_id = auth.uid()) AND ((workshop_id IS NULL) OR (workshop_id IN ( SELECT profiles.workshop_id
   FROM public.profiles
  WHERE (profiles.id = auth.uid()))))));


--
-- Name: insurance_amounts Users can insert their own insurance amounts; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can insert their own insurance amounts" ON public.insurance_amounts FOR INSERT WITH CHECK ((analysis_id IN ( SELECT analysis.id
   FROM public.analysis
  WHERE (analysis.workshop_id = auth.uid()))));


--
-- Name: insurance_amounts Users can insert their own insurance amounts v2; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can insert their own insurance amounts v2" ON public.insurance_amounts FOR INSERT WITH CHECK ((analysis_id IN ( SELECT analysis.id
   FROM public.analysis
  WHERE (analysis.user_id = auth.uid()))));


--
-- Name: profiles Users can insert their own profile; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can insert their own profile" ON public.profiles FOR INSERT WITH CHECK ((auth.uid() = id));


--
-- Name: vehicle_data Users can insert their own vehicle data; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can insert their own vehicle data" ON public.vehicle_data FOR INSERT WITH CHECK ((analysis_id IN ( SELECT analysis.id
   FROM public.analysis
  WHERE (analysis.workshop_id = auth.uid()))));


--
-- Name: vehicle_data Users can insert their own vehicle data v2; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can insert their own vehicle data v2" ON public.vehicle_data FOR INSERT WITH CHECK ((analysis_id IN ( SELECT analysis.id
   FROM public.analysis
  WHERE (analysis.user_id = auth.uid()))));


--
-- Name: user_monthly_usage Users can manage their own monthly usage; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can manage their own monthly usage" ON public.user_monthly_usage USING ((user_id = auth.uid()));


--
-- Name: user_paid_analyses_balance Users can update own paid analyses balance; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update own paid analyses balance" ON public.user_paid_analyses_balance FOR UPDATE USING ((auth.uid() = user_id));


--
-- Name: analysis Users can update their own analysis; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update their own analysis" ON public.analysis FOR UPDATE USING ((user_id = auth.uid())) WITH CHECK (((user_id = auth.uid()) AND ((workshop_id IS NULL) OR (workshop_id IN ( SELECT profiles.workshop_id
   FROM public.profiles
  WHERE (profiles.id = auth.uid()))))));


--
-- Name: insurance_amounts Users can update their own insurance amounts; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update their own insurance amounts" ON public.insurance_amounts FOR UPDATE USING ((analysis_id IN ( SELECT analysis.id
   FROM public.analysis
  WHERE (analysis.workshop_id = auth.uid()))));


--
-- Name: insurance_amounts Users can update their own insurance amounts v2; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update their own insurance amounts v2" ON public.insurance_amounts FOR UPDATE USING ((analysis_id IN ( SELECT analysis.id
   FROM public.analysis
  WHERE (analysis.user_id = auth.uid())))) WITH CHECK ((analysis_id IN ( SELECT analysis.id
   FROM public.analysis
  WHERE (analysis.user_id = auth.uid()))));


--
-- Name: profiles Users can update their own profile; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update their own profile" ON public.profiles FOR UPDATE USING ((auth.uid() = id));


--
-- Name: vehicle_data Users can update their own vehicle data; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update their own vehicle data" ON public.vehicle_data FOR UPDATE USING ((analysis_id IN ( SELECT analysis.id
   FROM public.analysis
  WHERE (analysis.workshop_id = auth.uid()))));


--
-- Name: vehicle_data Users can update their own vehicle data v2; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update their own vehicle data v2" ON public.vehicle_data FOR UPDATE USING ((analysis_id IN ( SELECT analysis.id
   FROM public.analysis
  WHERE (analysis.user_id = auth.uid())))) WITH CHECK ((analysis_id IN ( SELECT analysis.id
   FROM public.analysis
  WHERE (analysis.user_id = auth.uid()))));


--
-- Name: analysis Users can update their own workshop analysis; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update their own workshop analysis" ON public.analysis FOR UPDATE USING ((workshop_id IN ( SELECT workshops.id
   FROM public.workshops
  WHERE (workshops.id IN ( SELECT profiles.workshop_id
           FROM public.profiles
          WHERE (profiles.id = auth.uid()))))));


--
-- Name: user_paid_analyses_balance Users can view own paid analyses balance; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view own paid analyses balance" ON public.user_paid_analyses_balance FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: system_settings Users can view public settings; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view public settings" ON public.system_settings FOR SELECT USING (((setting_key)::text = ANY ((ARRAY['monthly_free_analyses_limit'::character varying, 'additional_analysis_price'::character varying, 'billing_enabled'::character varying])::text[])));


--
-- Name: analysis Users can view their own analysis; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their own analysis" ON public.analysis FOR SELECT USING ((user_id = auth.uid()));


--
-- Name: insurance_amounts Users can view their own insurance amounts; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their own insurance amounts" ON public.insurance_amounts FOR SELECT USING ((analysis_id IN ( SELECT analysis.id
   FROM public.analysis
  WHERE (analysis.workshop_id = auth.uid()))));


--
-- Name: insurance_amounts Users can view their own insurance amounts v2; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their own insurance amounts v2" ON public.insurance_amounts FOR SELECT USING ((analysis_id IN ( SELECT analysis.id
   FROM public.analysis
  WHERE (analysis.user_id = auth.uid()))));


--
-- Name: stripe_payments Users can view their own payments; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their own payments" ON public.stripe_payments FOR SELECT USING ((user_id = auth.uid()));


--
-- Name: profiles Users can view their own profile; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their own profile" ON public.profiles FOR SELECT USING ((auth.uid() = id));


--
-- Name: vehicle_data Users can view their own vehicle data; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their own vehicle data" ON public.vehicle_data FOR SELECT USING ((analysis_id IN ( SELECT analysis.id
   FROM public.analysis
  WHERE (analysis.workshop_id = auth.uid()))));


--
-- Name: vehicle_data Users can view their own vehicle data v2; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their own vehicle data v2" ON public.vehicle_data FOR SELECT USING ((analysis_id IN ( SELECT analysis.id
   FROM public.analysis
  WHERE (analysis.user_id = auth.uid()))));


--
-- Name: workshops Users can view their own workshop; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their own workshop" ON public.workshops FOR SELECT TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.workshop_id = workshops.id) AND (profiles.id = auth.uid())))));


--
-- Name: analysis Users can view their own workshop analysis; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their own workshop analysis" ON public.analysis FOR SELECT USING ((workshop_id IN ( SELECT workshops.id
   FROM public.workshops
  WHERE (workshops.id IN ( SELECT profiles.workshop_id
           FROM public.profiles
          WHERE (profiles.id = auth.uid()))))));


--
-- Name: payments Users can view their workshop payments; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their workshop payments" ON public.payments FOR SELECT USING ((workshop_id IN ( SELECT profiles.workshop_id
   FROM public.profiles
  WHERE (profiles.id = auth.uid()))));


--
-- Name: analysis; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.analysis ENABLE ROW LEVEL SECURITY;

--
-- Name: analysis_packages; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.analysis_packages ENABLE ROW LEVEL SECURITY;

--
-- Name: insurance_amounts; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.insurance_amounts ENABLE ROW LEVEL SECURITY;

--
-- Name: payments; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.payments ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

--
-- Name: stripe_payments; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.stripe_payments ENABLE ROW LEVEL SECURITY;

--
-- Name: system_settings; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.system_settings ENABLE ROW LEVEL SECURITY;

--
-- Name: user_monthly_usage; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.user_monthly_usage ENABLE ROW LEVEL SECURITY;

--
-- Name: user_paid_analyses_balance; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.user_paid_analyses_balance ENABLE ROW LEVEL SECURITY;

--
-- Name: vehicle_data; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.vehicle_data ENABLE ROW LEVEL SECURITY;

--
-- Name: workshop_costs workshop_costs_delete_policy; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY workshop_costs_delete_policy ON public.workshop_costs FOR DELETE USING (((EXISTS ( SELECT 1
   FROM (public.analysis a
     JOIN public.profiles p ON ((p.workshop_id = a.workshop_id)))
  WHERE ((a.id = workshop_costs.analysis_id) AND (p.id = auth.uid())))) OR (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text))))));


--
-- Name: workshop_costs workshop_costs_insert_policy; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY workshop_costs_insert_policy ON public.workshop_costs FOR INSERT WITH CHECK (((EXISTS ( SELECT 1
   FROM (public.analysis a
     JOIN public.profiles p ON ((p.workshop_id = a.workshop_id)))
  WHERE ((a.id = workshop_costs.analysis_id) AND (p.id = auth.uid())))) OR (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text))))));


--
-- Name: workshop_costs workshop_costs_select_policy; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY workshop_costs_select_policy ON public.workshop_costs FOR SELECT USING (((EXISTS ( SELECT 1
   FROM (public.analysis a
     JOIN public.profiles p ON ((p.workshop_id = a.workshop_id)))
  WHERE ((a.id = workshop_costs.analysis_id) AND (p.id = auth.uid())))) OR (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text))))));


--
-- Name: workshop_costs workshop_costs_update_policy; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY workshop_costs_update_policy ON public.workshop_costs FOR UPDATE USING (((EXISTS ( SELECT 1
   FROM (public.analysis a
     JOIN public.profiles p ON ((p.workshop_id = a.workshop_id)))
  WHERE ((a.id = workshop_costs.analysis_id) AND (p.id = auth.uid())))) OR (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text))))));


--
-- Fuera de public: trigger de alta de usuarios en auth.users
--

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


--
-- Fuera de public: buckets de storage
--

INSERT INTO storage.buckets (id, name, public)
VALUES ('analysis-pdfs', 'analysis-pdfs', false),
       ('documents', 'documents', false)
ON CONFLICT (id) DO NOTHING;


--
-- Fuera de public: politicas de storage.objects
--

DROP POLICY IF EXISTS "Users can upload PDFs for their workshop" ON storage.objects;
CREATE POLICY "Users can upload PDFs for their workshop" ON storage.objects FOR INSERT WITH CHECK (((bucket_id = 'analysis-pdfs'::text) AND (auth.uid() IS NOT NULL)));

DROP POLICY IF EXISTS "Users can view PDFs for their workshop" ON storage.objects;
CREATE POLICY "Users can view PDFs for their workshop" ON storage.objects FOR SELECT USING (((bucket_id = 'analysis-pdfs'::text) AND (auth.uid() IS NOT NULL)));

DROP POLICY IF EXISTS "Users can delete PDFs for their workshop" ON storage.objects;
CREATE POLICY "Users can delete PDFs for their workshop" ON storage.objects FOR DELETE USING (((bucket_id = 'analysis-pdfs'::text) AND (auth.uid() IS NOT NULL)));

