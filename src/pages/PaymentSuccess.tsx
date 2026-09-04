import { useEffect, useState } from "react";
import { useSearchParams, Link } from "react-router-dom";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { CheckCircle2, ArrowRight, FileText, CreditCard } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/contexts/AuthContext";

// Error types for better error handling
enum ErrorType {
  DATABASE_ERROR = 'database_error',
  NETWORK_ERROR = 'network_error',
  VALIDATION_ERROR = 'validation_error',
  PAYMENT_ERROR = 'payment_error',
  UNKNOWN_ERROR = 'unknown_error'
}

interface AppError {
  type: ErrorType;
  message: string;
  originalError?: any;
}

// Helper function to create standardized errors
const createError = (type: ErrorType, message: string, originalError?: any): AppError => ({
  type,
  message,
  originalError
});

// Helper function to handle errors consistently
const handleError = (error: any, toast: any): void => {
  console.error('Error details:', error);
  
  let errorMessage = 'Ha ocurrido un error inesperado';
  
  if (error?.type) {
    // It's our custom AppError
    errorMessage = error.message;
  } else if (error?.message?.includes('fetch') || error?.message?.includes('network')) {
    errorMessage = 'Error de conexión. Verifica tu conexión a internet.';
  } else if (error?.code?.startsWith('PGRST') || error?.message?.includes('database')) {
    errorMessage = 'Error en la base de datos. Inténtalo de nuevo.';
  } else if (error?.message?.includes('payment') || error?.message?.includes('stripe')) {
    errorMessage = 'Error al verificar el pago. Contacta con soporte si el problema persiste.';
  } else if (error?.message) {
    errorMessage = error.message;
  }
  
  toast({
    title: "Error",
    description: errorMessage,
    variant: "destructive",
  });
};

const PaymentSuccess = () => {
  const [searchParams] = useSearchParams();
  const [isLoading, setIsLoading] = useState(true);
  const [paymentDetails, setPaymentDetails] = useState<any>(null);
  const { toast } = useToast();
  const { session } = useAuth();

  const sessionId = searchParams.get('session_id');

  useEffect(() => {
    const verifyPayment = async () => {
      if (!sessionId || !session?.user?.id) {
        setIsLoading(false);
        return;
      }

      try {
        // Verificar el estado del pago en nuestra base de datos
        const { data: payment, error } = await supabase
          .from('payments')
          .select('*')
          .eq('stripe_session_id', sessionId)
          .eq('user_id', session.user.id)
          .single();

        if (error) {
          const appError = createError(
            ErrorType.DATABASE_ERROR,
            'No se pudo verificar el estado del pago en la base de datos.',
            error
          );
          handleError(appError, toast);
        } else {
          setPaymentDetails(payment);
        }
      } catch (error) {
        const appError = createError(
          ErrorType.PAYMENT_ERROR,
          'Ocurrió un error al verificar el pago. Contacta con soporte si el problema persiste.',
          error
        );
        handleError(appError, toast);
      } finally {
        setIsLoading(false);
      }
    };

    verifyPayment();
  }, [sessionId, session?.user?.id, toast]);

  if (isLoading) {
    return (
      <div className="max-w-2xl mx-auto">
        <Card>
          <CardContent className="p-8 text-center">
            <div className="animate-spin h-8 w-8 border-2 border-primary border-t-transparent rounded-full mx-auto mb-4"></div>
            <p className="text-muted-foreground">Verificando el pago...</p>
          </CardContent>
        </Card>
      </div>
    );
  }

  if (!sessionId) {
    return (
      <div className="max-w-2xl mx-auto">
        <Card>
          <CardContent className="p-8 text-center">
            <div className="text-destructive mb-4">
              <FileText className="h-12 w-12 mx-auto" />
            </div>
            <h2 className="text-xl font-semibold mb-2">Sesión no válida</h2>
            <p className="text-muted-foreground mb-6">
              No se encontró información de la sesión de pago.
            </p>
            <Link to="/app/nuevo">
              <Button>Volver a intentar</Button>
            </Link>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="max-w-2xl mx-auto">
      <div className="text-center mb-8">
        <div className="text-success mb-4">
          <CheckCircle2 className="h-16 w-16 mx-auto" />
        </div>
        <h1 className="text-3xl font-bold text-foreground mb-4">
          ¡Pago Exitoso!
        </h1>
        <p className="text-lg text-muted-foreground">
          Tu pago se ha procesado correctamente
        </p>
      </div>

      {paymentDetails && (
        <Card className="mb-6">
          <CardHeader>
            <CardTitle className="flex items-center space-x-2">
              <CreditCard className="h-5 w-5 text-primary" />
              <span>Detalles del Pago</span>
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-2 gap-4 text-sm">
              <div>
                <span className="text-muted-foreground">Monto:</span>
                <p className="font-medium">{(paymentDetails.amount_cents / 100).toFixed(2)}€</p>
              </div>
              <div>
                <span className="text-muted-foreground">Estado:</span>
                <p className="font-medium text-success">
                  {paymentDetails.status === 'completed' || paymentDetails.status === 'succeeded'
                    ? 'Completado'
                    : paymentDetails.status}
                </p>
              </div>
              <div>
                <span className="text-muted-foreground">Fecha:</span>
                <p className="font-medium">
                  {new Date(paymentDetails.created_at).toLocaleDateString('es-ES')}
                </p>
              </div>
              <div>
                <span className="text-muted-foreground">Mes de análisis:</span>
                <p className="font-medium">{paymentDetails.analysis_month}</p>
              </div>
            </div>
            
            {paymentDetails.description && (
              <div className="mt-4 pt-4 border-t">
                <span className="text-muted-foreground text-sm">Descripción:</span>
                <p className="font-medium">{paymentDetails.description}</p>
              </div>
            )}
          </CardContent>
        </Card>
      )}

      <Card className="bg-primary-soft border-primary/20">
        <CardContent className="p-6">
          <div className="text-center">
            <h3 className="font-semibold text-primary mb-2">¡Ya puedes continuar!</h3>
            <p className="text-sm text-primary/80 mb-4">
              Tu pago se ha procesado exitosamente. Ahora puedes crear tu análisis adicional.
            </p>
            <div className="flex flex-col sm:flex-row gap-3 justify-center">
              <Link to="/app/nuevo">
                <Button className="bg-gradient-primary text-primary-foreground shadow-glow">
                  Crear Nuevo Análisis
                  <ArrowRight className="ml-2 h-4 w-4" />
                </Button>
              </Link>
              <Link to="/app/historial-pagos">
                <Button variant="outline">
                  Ver Historial de Pagos
                </Button>
              </Link>
            </div>
          </div>
        </CardContent>
      </Card>

      <div className="mt-6 text-center text-sm text-muted-foreground">
        <p>• Recibirás una factura por email</p>
        <p>• El análisis adicional ya está disponible en tu cuenta</p>
        <p>• Si tienes algún problema, contacta con soporte</p>
      </div>
    </div>
  );
};

export default PaymentSuccess;