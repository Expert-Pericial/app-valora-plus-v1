import { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import { AlertTriangle, CheckCircle2, ArrowRight, ArrowLeft, Edit3, Loader2 } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { Link } from "react-router-dom";
import { supabase } from "@/lib/supabase";

// Error types for better error handling
enum ErrorType {
  VALIDATION_ERROR = 'validation_error',
  DATABASE_ERROR = 'database_error',
  NETWORK_ERROR = 'network_error',
  UNKNOWN_ERROR = 'unknown_error'
}

interface AppError {
  type: ErrorType;
  message: string;
  originalError?: Error;
}

// Helper function to create standardized errors
const createError = (type: ErrorType, message: string, originalError?: Error): AppError => ({
  type,
  message,
  originalError
});

// Helper function to handle errors consistently
const handleError = (error: unknown, toast: any, context: string = '') => {
  console.error(`Error in ${context}:`, error);
  
  let appError: AppError;
  
  if (error instanceof Error) {
    if (error.message.includes('network') || error.message.includes('fetch')) {
      appError = createError(ErrorType.NETWORK_ERROR, 'Error de conexión. Verifica tu conexión a internet.', error);
    } else if (error.message.includes('database') || error.message.includes('supabase')) {
      appError = createError(ErrorType.DATABASE_ERROR, 'Error en la base de datos. Inténtalo de nuevo.', error);
    } else {
      appError = createError(ErrorType.UNKNOWN_ERROR, error.message, error);
    }
  } else {
    appError = createError(ErrorType.UNKNOWN_ERROR, 'Error desconocido. Inténtalo de nuevo.');
  }
  
  toast({
    title: "Error",
    description: appError.message,
    variant: "destructive"
  });
  
  return appError;
};

const Verification = () => {
  const { caseId } = useParams<{ caseId: string }>();
  const [isEditing, setIsEditing] = useState(false);
  const [isSaving, setIsSaving] = useState(false);
  const [confidence, setConfidence] = useState(0.92);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const { toast } = useToast();

  // Initialize with empty data structure
  const [extractedData, setExtractedData] = useState({
    metadata: {
      matricula: "",
      bastidor: "", 
      fabricante: "",
      modelo: "",
      valuation_date: "",
      referencia: "",
      sistema: "",
      precio_hora_mecanica: "",
      precio_hora_pintura: ""
    },
    totales: {
      repuestos_total: "",
      cantidad_materiales_repuestos: "",
      mo_chapa_ut: "",
      mo_mecanica_eur: "",
      mo_pintura_ut: "",
      mo_pintura_eur: "",
      mat_pintura_eur: "",
      subtotal_neto: "",
      iva_percentage: "",
      iva: "",
      total_con_iva: "",
      // Nuevos campos de horas convertidas
      mo_mecanica_horas: "",
      mo_pintura_horas: "",
      unidades_detectadas: ""
    }
  });

  // Load analysis data from database
  useEffect(() => {
    const loadAnalysisData = async () => {
      if (!caseId) {
        setError('No se proporcionó ID de análisis');
        setIsLoading(false);
        return;
      }

      try {
        // Get analysis data
        const { data: analysis, error: analysisError } = await supabase
          .from('analysis')
          .select('*')
          .eq('id', caseId)
          .single();

        if (analysisError) {
          throw new Error(`Error cargando análisis: ${analysisError.message}`);
        }

        if (!analysis) {
          throw new Error('Análisis no encontrado');
        }

        // Get vehicle data
        const { data: vehicleData, error: vehicleError } = await supabase
          .from('vehicle_data')
          .select('*')
          .eq('analysis_id', caseId)
          .single();

        // Get insurance amounts (including new converted hours fields)
        const { data: insuranceData, error: insuranceError } = await supabase
          .from('insurance_amounts')
          .select('*')
          .eq('analysis_id', caseId)
          .single();

        // If analysis is still processing, show loading state
        if (analysis.status === 'processing') {
          setError('El análisis aún se está procesando. Por favor, espera unos momentos.');
          setIsLoading(false);
          return;
        }

        // If analysis failed, show error
        if (analysis.status === 'failed') {
          setError('El análisis falló durante el procesamiento.');
          setIsLoading(false);
          return;
        }

        // Set extracted data from database
         if (vehicleData && insuranceData) {
           setExtractedData({
             metadata: {
               matricula: vehicleData.license_plate || "",
               bastidor: vehicleData.vin || "", 
               fabricante: vehicleData.manufacturer || "",
               modelo: vehicleData.model || "",
               valuation_date: analysis.valuation_date || "",
               referencia: vehicleData.internal_reference || "",
               sistema: vehicleData.system || "",
               precio_hora_mecanica: vehicleData.hourly_price?.toString() || "",
               precio_hora_pintura: vehicleData.hourly_price?.toString() || ""
             },
             totales: {
               repuestos_total: insuranceData.total_spare_parts_eur?.toString() || "",
               cantidad_materiales_repuestos: (insuranceData as any).spare_parts_quantity?.toString() || "",
               mo_chapa_ut: insuranceData.bodywork_labor_ut?.toString() || "",
               mo_mecanica_eur: insuranceData.bodywork_labor_eur?.toString() || "",
               mo_pintura_ut: insuranceData.painting_labor_ut?.toString() || "",
               mo_pintura_eur: insuranceData.painting_labor_eur?.toString() || "",
               mat_pintura_eur: insuranceData.paint_material_eur?.toString() || "",
               subtotal_neto: insuranceData.net_subtotal?.toString() || "",
               iva_percentage: (insuranceData as any).iva_percentage?.toString() || "",
               iva: insuranceData.iva_amount?.toString() || "",
               total_con_iva: insuranceData.total_with_iva?.toString() || "",
               // Nuevos campos de horas convertidas
               mo_mecanica_horas: (insuranceData as any).bodywork_labor_hours?.toString() || "",
               mo_pintura_horas: (insuranceData as any).painting_labor_hours?.toString() || "",
               unidades_detectadas: (insuranceData as any).detected_units || ""
             }
           });
        } else {
          // If no extracted data yet, show message
          setError('Los datos aún no han sido extraídos. El análisis puede estar en proceso.');
        }

      } catch (err) {
        const appError = handleError(err, toast, 'loading analysis data');
        setError(appError.message);
      } finally {
        setIsLoading(false);
      }
    };

    loadAnalysisData();
  }, [caseId]);

  const handleInputChange = (section: string, field: string, value: string) => {
    setExtractedData(prev => ({
      ...prev,
      [section]: {
        ...prev[section as keyof typeof prev],
        [field]: value
      }
    }));
  };

  const validateData = () => {
    const errors: string[] = [];
    
    // Helper function to validate monetary values
    const validateMonetaryValue = (value: string, fieldName: string, isRequired: boolean = false) => {
      // If empty and not required, it's valid
      if (!value || value.trim() === '') {
        if (isRequired) {
          errors.push(`${fieldName} es obligatorio`);
        }
        return;
      }

      // Clean the value: remove spaces and currency symbols
      const cleanValue = value.trim().replace(/\s/g, '').replace(/[€$£¥]/g, '');
      
      // Check for valid monetary format with point as decimal separator
      // Allow: 123, 123.45, 1234.56, etc.
      // Don't allow: commas, multiple dots, letters, special chars (except decimal point)
      const monetaryRegex = /^\d+(\.\d{1,2})?$/;
      
      if (!monetaryRegex.test(cleanValue)) {
        errors.push(`${fieldName} debe tener un formato monetario válido usando punto como decimal (ej: 123.45)`);
        return;
      }

      const num = parseFloat(cleanValue);
      
      // Check if it's a valid number
      if (isNaN(num)) {
        errors.push(`${fieldName} debe ser un número válido`);
        return;
      }

      // Check if it's not negative
      if (num < 0) {
        errors.push(`${fieldName} no puede ser negativo`);
        return;
      }

      // Check reasonable limits for monetary values
      if (num > 999999.99) {
        errors.push(`${fieldName} excede el límite máximo permitido (999,999.99 €)`);
        return;
      }

      // Check decimal precision (max 2 decimal places)
      const decimalPart = cleanValue.split('.')[1];
      if (decimalPart && decimalPart.length > 2) {
        errors.push(`${fieldName} no puede tener más de 2 decimales`);
        return;
      }
    };

    // Helper function to validate unit values (like UT - Unidades de Tiempo)
    const validateUnitValue = (value: string, fieldName: string) => {
      if (!value || value.trim() === '') return;

      const cleanValue = value.trim().replace(',', '.');
      const num = parseFloat(cleanValue);
      
      if (isNaN(num)) {
        errors.push(`${fieldName} debe ser un número válido`);
        return;
      }

      if (num < 0) {
        errors.push(`${fieldName} no puede ser negativo`);
        return;
      }

      if (num > 9999.99) {
        errors.push(`${fieldName} excede el límite máximo permitido (9,999.99)`);
        return;
      }
    };

    // Helper function to validate percentage values
    const validatePercentageValue = (value: string, fieldName: string) => {
      if (!value || value.trim() === '') return;

      const cleanValue = value.trim();
      
      // Check for valid percentage format with point as decimal separator
      const percentageRegex = /^\d+(\.\d{1,2})?$/;
      
      if (!percentageRegex.test(cleanValue)) {
        errors.push(`${fieldName} debe tener un formato válido usando punto como decimal (ej: 21.00)`);
        return;
      }
      
      const num = parseFloat(cleanValue);
      
      if (isNaN(num)) {
        errors.push(`${fieldName} debe ser un número válido`);
        return;
      }

      if (num < 0) {
        errors.push(`${fieldName} no puede ser negativo`);
        return;
      }

      if (num > 100) {
        errors.push(`${fieldName} no puede ser mayor que 100%`);
        return;
      }
    };

    // Helper function to validate license plate format
    const validateLicensePlate = (value: string, fieldName: string) => {
      if (!value || value.trim() === '') {
        errors.push(`${fieldName} es obligatorio`);
        return;
      }

      const cleanValue = value.trim().toUpperCase();
      
      // Spanish license plate formats
      const oldFormat = /^[A-Z]{1,2}\d{4}[A-Z]{1,2}$/; // Old format: M1234AB
      const newFormat = /^\d{4}[A-Z]{3}$/; // New format: 1234ABC
      
      if (!oldFormat.test(cleanValue) && !newFormat.test(cleanValue)) {
        errors.push(`${fieldName} debe tener un formato válido (ej: 1234ABC o M1234AB)`);
        return;
      }
    };

    // Validate vehicle data
    validateLicensePlate(extractedData.metadata.matricula, 'Matrícula');

    // Validate monetary fields
    validateMonetaryValue(extractedData.metadata.precio_hora_mecanica, 'Precio por hora - Mecánica');
    validateMonetaryValue(extractedData.metadata.precio_hora_pintura, 'Precio por hora - Pintura');
    validateMonetaryValue(extractedData.totales.repuestos_total, 'Total Repuestos');
    validateMonetaryValue(extractedData.totales.mo_mecanica_eur, 'M.O. Mecánica (€)');
    validateMonetaryValue(extractedData.totales.mo_pintura_eur, 'M.O. Pintura (€)');
    validateMonetaryValue(extractedData.totales.mat_pintura_eur, 'Materiales Pintura (€)');
    validateMonetaryValue(extractedData.totales.subtotal_neto, 'Subtotal sin IVA');
    validatePercentageValue(extractedData.totales.iva_percentage, 'Porcentaje IVA');
    validateMonetaryValue(extractedData.totales.iva, 'Monto IVA');
    validateMonetaryValue(extractedData.totales.total_con_iva, 'Total con IVA');

    // Validate hour fields (converted from UT)
    validateUnitValue(extractedData.totales.mo_mecanica_horas, 'M.O. Mecánica (Horas)');
    validateUnitValue(extractedData.totales.mo_pintura_horas, 'M.O. Pintura (Horas)');

    // Business logic validation: Check IVA calculation
    const subtotal = parseFloat(extractedData.totales.subtotal_neto || '0');
    const iva = parseFloat(extractedData.totales.iva || '0');
    const ivaPercentage = parseFloat(extractedData.totales.iva_percentage || '21');
    
    if (subtotal > 0 && iva > 0) {
      const expectedIva = subtotal * (ivaPercentage / 100);
      const difference = Math.abs(iva - expectedIva);
      const tolerance = Math.max(0.5, subtotal * 0.001); // 0.1% tolerance or minimum 0.5€
      
      if (difference > tolerance) {
        errors.push(`El IVA calculado (${iva.toFixed(2)}€) no coincide con el esperado (${expectedIva.toFixed(2)}€)`);
      }
    }

    // Cross-validation: Check if totals make sense
    if (extractedData.totales.subtotal_neto && extractedData.totales.iva && extractedData.totales.total_con_iva) {
      const subtotal = parseFloat(extractedData.totales.subtotal_neto.replace(',', '.'));
      const iva = parseFloat(extractedData.totales.iva.replace(',', '.'));
      const total = parseFloat(extractedData.totales.total_con_iva.replace(',', '.'));
      
      if (!isNaN(subtotal) && !isNaN(iva) && !isNaN(total)) {
        const calculatedTotal = subtotal + iva;
        const difference = Math.abs(calculatedTotal - total);
        
        // Allow small rounding differences (up to 0.01)
        if (difference > 0.01) {
          errors.push('Los totales no cuadran: Subtotal + IVA debe igual Total con IVA');
        }
      }
    }

    return errors;
  };

  // Helper function to safely parse monetary values
  const parseMonetaryValue = (value: string | undefined | null): number | null => {
    if (!value || value.trim() === '') return null;
    
    // Remove currency symbols and spaces
    const cleanValue = value
      .toString()
      .trim()
      .replace(/[€$\s]/g, ''); // Remove currency symbols and spaces
    
    // For Spanish format, we expect point (.) as decimal separator
    // Don't modify the decimal point - keep it as is
    const parsed = parseFloat(cleanValue);
    return isNaN(parsed) ? null : parsed;
  };

  const handleSaveChanges = async () => {
    if (!caseId) {
      const error = createError(ErrorType.VALIDATION_ERROR, "No se encontró el ID del análisis");
      toast({
        title: "Error",
        description: error.message,
        variant: "destructive"
      });
      return false;
    }

    // Validate data before saving
    const validationErrors = validateData();
    if (validationErrors.length > 0) {
      const error = createError(ErrorType.VALIDATION_ERROR, validationErrors.join('. '));
      toast({
        title: "Error de validación",
        description: error.message,
        variant: "destructive"
      });
      return false;
    }

    setIsSaving(true);
    
    try {
      // Update vehicle_data table
      const vehicleUpdateData = {
        license_plate: extractedData.metadata.matricula || null,
        vin: extractedData.metadata.bastidor || null,
        manufacturer: extractedData.metadata.fabricante || null,
        model: extractedData.metadata.modelo || null,
        internal_reference: extractedData.metadata.referencia || null,
        system: extractedData.metadata.sistema || null,
        hourly_price: parseMonetaryValue(extractedData.metadata.precio_hora_mecanica)
      };

      const { error: vehicleError } = await supabase
        .from('vehicle_data')
        .update(vehicleUpdateData)
        .eq('analysis_id', caseId);

      if (vehicleError) {
        throw createError(ErrorType.DATABASE_ERROR, `Error actualizando datos del vehículo: ${vehicleError.message}`, vehicleError);
      }

      // Update insurance_amounts table
      const insuranceUpdateData = {
        total_spare_parts_eur: parseMonetaryValue(extractedData.totales.repuestos_total),
        spare_parts_quantity: parseMonetaryValue(extractedData.totales.cantidad_materiales_repuestos),
        bodywork_labor_ut: parseMonetaryValue(extractedData.totales.mo_chapa_ut),
        bodywork_labor_eur: parseMonetaryValue(extractedData.totales.mo_mecanica_eur),
        bodywork_labor_hours: parseMonetaryValue(extractedData.totales.mo_mecanica_horas),
        painting_labor_ut: parseMonetaryValue(extractedData.totales.mo_pintura_ut),
        painting_labor_eur: parseMonetaryValue(extractedData.totales.mo_pintura_eur),
        painting_labor_hours: parseMonetaryValue(extractedData.totales.mo_pintura_horas),
        detected_units: extractedData.totales.unidades_detectadas || null,
        paint_material_eur: parseMonetaryValue(extractedData.totales.mat_pintura_eur),
        net_subtotal: parseMonetaryValue(extractedData.totales.subtotal_neto),
        iva_percentage: parseMonetaryValue(extractedData.totales.iva_percentage),
        iva_amount: parseMonetaryValue(extractedData.totales.iva),
        total_with_iva: parseMonetaryValue(extractedData.totales.total_con_iva)
      };

      const { error: insuranceError } = await supabase
        .from('insurance_amounts')
        .update(insuranceUpdateData)
        .eq('analysis_id', caseId);

      if (insuranceError) {
        throw createError(ErrorType.DATABASE_ERROR, `Error actualizando importes de la aseguradora: ${insuranceError.message}`, insuranceError);
      }

      // Update analysis table with valuation_date
      const analysisUpdateData = {
        valuation_date: extractedData.metadata.valuation_date || null
      };

      const { error: analysisError } = await supabase
        .from('analysis')
        .update(analysisUpdateData)
        .eq('id', caseId);

      if (analysisError) {
        throw createError(ErrorType.DATABASE_ERROR, `Error actualizando fecha de análisis: ${analysisError.message}`, analysisError);
      }

      toast({
        title: "Cambios guardados",
        description: "Los datos han sido actualizados correctamente",
      });

      return true;

    } catch (err) {
      handleError(err, toast, 'saving verification changes');
      return false;
    } finally {
      setIsSaving(false);
    }
  };

  const handleEditToggle = async () => {
    if (isEditing) {
      // If we're finishing editing, save changes first
      const saveSuccess = await handleSaveChanges();
      if (saveSuccess) {
        setIsEditing(false);
      }
    } else {
      // If we're starting to edit, just toggle the state
      setIsEditing(true);
    }
  };

  const handleContinue = () => {
    toast({
      title: "Datos verificados",
      description: "Continuando al siguiente paso...",
    });
    // Redirect to costs input with the actual analysis ID
    setTimeout(() => {
      window.location.href = `/app/costes/${caseId}`;
    }, 1000);
  };

  const formatCurrency = (value: string) => {
    const num = parseFloat(value);
    return isNaN(num) ? value : num.toLocaleString('es-ES', { 
      minimumFractionDigits: 2, 
      maximumFractionDigits: 2 
    }) + ' €';
  };

  // Show loading state
  if (isLoading) {
    return (
      <div className="max-w-4xl mx-auto">
        <div className="flex items-center justify-center min-h-[400px]">
          <div className="text-center">
            <Loader2 className="h-8 w-8 animate-spin mx-auto mb-4" />
            <p className="text-lg text-muted-foreground">Cargando datos del análisis...</p>
          </div>
        </div>
      </div>
    );
  }

  // Show error state
  if (error) {
    return (
      <div className="max-w-4xl mx-auto">
        <div className="flex items-center justify-center min-h-[400px]">
          <Card className="w-full max-w-md">
            <CardContent className="p-6 text-center">
              <AlertTriangle className="h-12 w-12 text-destructive mx-auto mb-4" />
              <h2 className="text-xl font-semibold mb-2">Error</h2>
              <p className="text-muted-foreground mb-4">{error}</p>
              <Link to="/app/nuevo">
                <Button>
                  <ArrowLeft className="mr-2 h-4 w-4" />
                  Volver al inicio
                </Button>
              </Link>
            </CardContent>
          </Card>
        </div>
      </div>
    );
  }

  return (
    <div className="max-w-4xl mx-auto">
      {/* Header */}
      <div className="flex items-center justify-between mb-8">
        <div>
          <h1 className="text-3xl font-bold text-foreground mb-2">
            Verificar Datos Extraídos
          </h1>
          <p className="text-lg text-muted-foreground">
            Revisa y corrige los datos extraídos del PDF antes de continuar
          </p>
        </div>
        <Link to="/app/nuevo">
          <Button variant="outline">
            <ArrowLeft className="mr-2 h-4 w-4" />
            Atrás
          </Button>
        </Link>
      </div>

      {/* Confidence indicator */}
      <Card className="mb-6">
        <CardContent className="p-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-3">
              {confidence >= 0.8 ? (
                <CheckCircle2 className="h-6 w-6 text-success" />
              ) : (
                <AlertTriangle className="h-6 w-6 text-warning" />
              )}
              <div>
                <p className="font-medium text-foreground">
                  Confianza de extracción: {(confidence * 100).toFixed(0)}%
                </p>
                <p className="text-sm text-muted-foreground">
                  {confidence >= 0.8 
                    ? "Los datos se han extraído con alta precisión" 
                    : "Revisa cuidadosamente los campos marcados"
                  }
                </p>
              </div>
            </div>
            <Button 
              variant="outline" 
              size="sm"
              onClick={handleEditToggle}
              disabled={isSaving}
            >
              {isSaving ? (
                <>
                  <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                  Guardando...
                </>
              ) : (
                <>
                  <Edit3 className="mr-2 h-4 w-4" />
                  {isEditing ? 'Finalizar edición' : 'Editar datos'}
                </>
              )}
            </Button>
          </div>
        </CardContent>
      </Card>

      <div className="grid lg:grid-cols-2 gap-6 mb-8">
        {/* Vehicle metadata */}
        <Card>
          <CardHeader>
            <CardTitle>Datos del Vehículo</CardTitle>
            <CardDescription>
              Información básica extraída del expediente
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <div>
                <Label htmlFor="matricula">Matrícula</Label>
                <Input
                  id="matricula"
                  value={extractedData.metadata.matricula}
                  onChange={(e) => handleInputChange('metadata', 'matricula', e.target.value)}
                  readOnly={!isEditing}
                  className={!isEditing ? "bg-muted/50" : ""}
                />
              </div>
              <div>
                <Label htmlFor="valuation_date">Fecha de Valoración</Label>
                <Input
                  id="valuation_date"
                  type="date"
                  value={extractedData.metadata.valuation_date}
                  onChange={(e) => handleInputChange('metadata', 'valuation_date', e.target.value)}
                  readOnly={!isEditing}
                  className={!isEditing ? "bg-muted/50" : ""}
                />
              </div>
            </div>
            
            <div>
              <Label htmlFor="bastidor">Número de bastidor</Label>
              <Input
                id="bastidor"
                value={extractedData.metadata.bastidor}
                onChange={(e) => handleInputChange('metadata', 'bastidor', e.target.value)}
                readOnly={!isEditing}
                className={!isEditing ? "bg-muted/50" : ""}
              />
            </div>
            
            <div className="grid grid-cols-2 gap-4">
              <div>
                <Label htmlFor="fabricante">Fabricante</Label>
                <Input
                  id="fabricante"
                  value={extractedData.metadata.fabricante}
                  onChange={(e) => handleInputChange('metadata', 'fabricante', e.target.value)}
                  readOnly={!isEditing}
                  className={!isEditing ? "bg-muted/50" : ""}
                />
              </div>
              <div>
                <Label htmlFor="modelo">Modelo</Label>
                <Input
                  id="modelo"
                  value={extractedData.metadata.modelo}
                  onChange={(e) => handleInputChange('metadata', 'modelo', e.target.value)}
                  readOnly={!isEditing}
                  className={!isEditing ? "bg-muted/50" : ""}
                />
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div>
                <Label htmlFor="referencia">Referencia</Label>
                <Input
                  id="referencia"
                  value={extractedData.metadata.referencia}
                  onChange={(e) => handleInputChange('metadata', 'referencia', e.target.value)}
                  readOnly={!isEditing}
                  className={!isEditing ? "bg-muted/50" : ""}
                />
              </div>
              <div>
                <Label htmlFor="sistema">Sistema</Label>
                <Input
                  id="sistema"
                  value={extractedData.metadata.sistema}
                  onChange={(e) => handleInputChange('metadata', 'sistema', e.target.value)}
                  readOnly={!isEditing}
                  className={!isEditing ? "bg-muted/50" : ""}
                />
              </div>
            </div>


          </CardContent>
        </Card>

        {/* Financial data */}
        <Card>
          <CardHeader>
            <CardTitle>Importes de la Aseguradora</CardTitle>
            <CardDescription>
              Totales extraídos de la valoración (sin IVA)
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <div>
                <Label htmlFor="precio_hora_mecanica">Precio/hora Mecánica (€)</Label>
                <Input
                  id="precio_hora_mecanica"
                  value={extractedData.metadata.precio_hora_mecanica}
                  onChange={(e) => handleInputChange('metadata', 'precio_hora_mecanica', e.target.value)}
                  readOnly={!isEditing}
                  className={!isEditing ? "bg-muted/50" : ""}
                />
              </div>
              <div>
                <Label htmlFor="precio_hora_pintura">Precio/hora Pintura (€)</Label>
                <Input
                  id="precio_hora_pintura"
                  value={extractedData.metadata.precio_hora_pintura}
                  onChange={(e) => handleInputChange('metadata', 'precio_hora_pintura', e.target.value)}
                  readOnly={!isEditing}
                  className={!isEditing ? "bg-muted/50" : ""}
                />
              </div>
            </div>

            <div>
              <Label htmlFor="repuestos_total">Total Repuestos</Label>
              <div className="relative">
                <Input
                  id="repuestos_total"
                  value={extractedData.totales.repuestos_total}
                  onChange={(e) => handleInputChange('totales', 'repuestos_total', e.target.value)}
                  readOnly={!isEditing}
                  className={!isEditing ? "bg-muted/50" : ""}
                />
                {!isEditing && (
                  <div className="absolute right-3 top-2.5 text-sm text-muted-foreground">
                    {formatCurrency(extractedData.totales.repuestos_total)}
                  </div>
                )}
              </div>
            </div>

            <div>
              <Label htmlFor="cantidad_materiales_repuestos">Cantidad de materiales/repuestos</Label>
              <Input
                id="cantidad_materiales_repuestos"
                value={extractedData.totales.cantidad_materiales_repuestos}
                onChange={(e) => handleInputChange('totales', 'cantidad_materiales_repuestos', e.target.value)}
                readOnly={!isEditing}
                className={!isEditing ? "bg-muted/50" : ""}
                placeholder="Número de elementos"
              />
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div>
                <Label htmlFor="mo_mecanica_horas">M.O. Mecánica (Horas)</Label>
                <Input
                  id="mo_mecanica_horas"
                  value={extractedData.totales.mo_mecanica_horas}
                  onChange={(e) => handleInputChange('totales', 'mo_mecanica_horas', e.target.value)}
                  readOnly={!isEditing}
                  className={!isEditing ? "bg-muted/50" : ""}
                />
              </div>
              <div>
                <Label htmlFor="mo_mecanica_eur">M.O. Mecánica (€)</Label>
                <div className="relative">
                  <Input
                    id="mo_mecanica_eur"
                    value={extractedData.totales.mo_mecanica_eur}
                    onChange={(e) => handleInputChange('totales', 'mo_mecanica_eur', e.target.value)}
                    readOnly={!isEditing}
                    className={!isEditing ? "bg-muted/50" : ""}
                  />
                  {!isEditing && (
                    <div className="absolute right-3 top-2.5 text-sm text-muted-foreground">
                      {formatCurrency(extractedData.totales.mo_mecanica_eur)}
                    </div>
                  )}
                </div>
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div>
                <Label htmlFor="mo_pintura_horas">M.O. Pintura (Horas)</Label>
                <Input
                  id="mo_pintura_horas"
                  value={extractedData.totales.mo_pintura_horas}
                  onChange={(e) => handleInputChange('totales', 'mo_pintura_horas', e.target.value)}
                  readOnly={!isEditing}
                  className={!isEditing ? "bg-muted/50" : ""}
                />
              </div>
              <div>
                <Label htmlFor="mo_pintura_eur">M.O. Pintura (€)</Label>
                <div className="relative">
                  <Input
                    id="mo_pintura_eur"
                    value={extractedData.totales.mo_pintura_eur}
                    onChange={(e) => handleInputChange('totales', 'mo_pintura_eur', e.target.value)}
                    readOnly={!isEditing}
                    className={!isEditing ? "bg-muted/50" : ""}
                  />
                  {!isEditing && (
                    <div className="absolute right-3 top-2.5 text-sm text-muted-foreground">
                      {formatCurrency(extractedData.totales.mo_pintura_eur)}
                    </div>
                  )}
                </div>
              </div>
            </div>

            <div>
              <Label htmlFor="mat_pintura_eur">Materiales Pintura (€)</Label>
              <div className="relative">
                <Input
                  id="mat_pintura_eur"
                  value={extractedData.totales.mat_pintura_eur}
                  onChange={(e) => handleInputChange('totales', 'mat_pintura_eur', e.target.value)}
                  readOnly={!isEditing}
                  className={!isEditing ? "bg-muted/50" : ""}
                />
                {!isEditing && (
                  <div className="absolute right-3 top-2.5 text-sm text-muted-foreground">
                    {formatCurrency(extractedData.totales.mat_pintura_eur)}
                  </div>
                )}
              </div>
            </div>

            <div className="border-t pt-4">
              <div className="mb-4">
                <Label htmlFor="subtotal_neto">Subtotal sin IVA</Label>
                <div className="relative">
                  <Input
                    id="subtotal_neto"
                    value={extractedData.totales.subtotal_neto}
                    onChange={(e) => handleInputChange('totales', 'subtotal_neto', e.target.value)}
                    readOnly={!isEditing}
                    className={!isEditing ? "bg-muted/50 font-semibold" : "font-semibold"}
                  />
                  {!isEditing && (
                    <div className="absolute right-3 top-2.5 text-sm font-semibold text-foreground">
                      {formatCurrency(extractedData.totales.subtotal_neto)}
                    </div>
                  )}
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4 mb-4">
                <div>
                  <Label htmlFor="iva_percentage">Porcentaje IVA (%)</Label>
                  <Input
                    id="iva_percentage"
                    value={extractedData.totales.iva_percentage}
                    onChange={(e) => handleInputChange('totales', 'iva_percentage', e.target.value)}
                    readOnly={!isEditing}
                    className={!isEditing ? "bg-muted/50" : ""}
                    placeholder="21"
                  />
                </div>
                <div>
                  <Label htmlFor="iva">Monto IVA (€)</Label>
                  <div className="relative">
                    <Input
                      id="iva"
                      value={extractedData.totales.iva}
                      onChange={(e) => handleInputChange('totales', 'iva', e.target.value)}
                      readOnly={!isEditing}
                      className={!isEditing ? "bg-muted/50" : ""}
                    />
                    {!isEditing && (
                      <div className="absolute right-3 top-2.5 text-sm text-muted-foreground">
                        {formatCurrency(extractedData.totales.iva)}
                      </div>
                    )}
                  </div>
                </div>
              </div>

              <div>
                <Label htmlFor="total_con_iva">Total con IVA</Label>
                <div className="relative">
                  <Input
                    id="total_con_iva"
                    value={extractedData.totales.total_con_iva}
                    onChange={(e) => handleInputChange('totales', 'total_con_iva', e.target.value)}
                    readOnly={!isEditing}
                    className={!isEditing ? "bg-muted/50 font-semibold" : "font-semibold"}
                  />
                  {!isEditing && (
                    <div className="absolute right-3 top-2.5 text-sm font-semibold text-foreground">
                      {formatCurrency(extractedData.totales.total_con_iva)}
                    </div>
                  )}
                </div>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Continue button */}
      <Card className="bg-primary-soft border-primary/20">
        <CardContent className="p-6">
          <div className="flex items-center justify-between">
            <div>
              <h3 className="font-semibold text-primary mb-1">Datos verificados</h3>
              <p className="text-sm text-primary/80">
                Continúa al siguiente paso para introducir los costes reales de tu taller
              </p>
            </div>
            <Button 
              onClick={handleContinue}
              className="bg-gradient-primary text-primary-foreground shadow-glow"
            >
              Introducir Costes
              <ArrowRight className="ml-2 h-4 w-4" />
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  );
};

export default Verification;