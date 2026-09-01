-- NewAnalysis.tsx:175-178 marca el analisis como 'failed' escribiendo tambien
-- error_message, columna que nunca existio:
--     {"code":"42703","message":"column analysis.error_message does not exist"}
-- El PATCH entero se rechaza con 400, y el try/catch de NewAnalysis.tsx:180 no lo
-- captura porque supabase-js devuelve el error en vez de lanzarlo. Resultado: los
-- analisis que fallan se quedan en 'processing' para siempre en lugar de 'failed'.

ALTER TABLE analysis
ADD COLUMN IF NOT EXISTS error_message TEXT;

COMMENT ON COLUMN analysis.error_message IS 'Mensaje del error que hizo fallar el analisis; lo rellena el manejador de errores del frontend al marcar status = failed';
