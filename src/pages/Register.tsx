import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Checkbox } from "@/components/ui/checkbox";
import { Calculator, Mail, ArrowLeft, Eye, EyeOff } from "lucide-react";
import { Link, useNavigate } from "react-router-dom";
import { useToast } from "@/hooks/use-toast";
import { supabase } from "@/lib/supabase";

// Error types for better error handling
enum ErrorType {
  VALIDATION_ERROR = 'validation_error',
  DATABASE_ERROR = 'database_error',
  NETWORK_ERROR = 'network_error',
  AUTHENTICATION_ERROR = 'authentication_error',
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
  } else if (error?.message?.includes('email')) {
    errorMessage = 'Error relacionado con el email. Verifica que sea válido.';
  } else if (error?.message) {
    errorMessage = error.message;
  }
  
  toast({
    title: "Error",
    description: errorMessage,
    variant: "destructive",
  });
};

const Register = () => {
  const [email, setEmail] = useState(''); // Email del usuario para autenticación
  const [fullName, setFullName] = useState(''); // Nombre completo del usuario
  const [workshopEmail, setWorkshopEmail] = useState(''); // Email del taller (opcional)
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [tallerName, setTallerName] = useState('');
  const [phone, setPhone] = useState('');
  const [address, setAddress] = useState('');
  const [acceptTerms, setAcceptTerms] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const { toast } = useToast();
  const navigate = useNavigate();

  const validatePassword = (password: string): string[] => {
    const errors: string[] = [];
    
    if (password.length < 8) {
      errors.push('La contraseña debe tener al menos 8 caracteres');
    }
    
    if (!/[A-Z]/.test(password)) {
      errors.push('Debe contener al menos una letra mayúscula');
    }
    
    if (!/[a-z]/.test(password)) {
      errors.push('Debe contener al menos una letra minúscula');
    }
    
    if (!/\d/.test(password)) {
      errors.push('Debe contener al menos un número');
    }
    
    if (!/[!@#$%^&*(),.?":{}|<>-]/.test(password)) {
      errors.push('Debe contener al menos un carácter especial (!@#$%^&*(),.?":{}|<>-)');
    }
    
    return errors;
  };

  const validateForm = (): boolean => {
    // Validar email
    if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
      toast({
        title: "Email inválido",
        description: "Por favor, introduce un email válido",
        variant: "destructive"
      });
      return false;
    }

    // Validar nombre del usuario
    if (!fullName.trim()) {
      toast({
        title: "Nombre requerido",
        description: "Tu nombre completo es obligatorio",
        variant: "destructive"
      });
      return false;
    }

    // Validar nombre del taller
    if (!tallerName.trim()) {
      toast({
        title: "Nombre del taller requerido",
        description: "El nombre del taller es obligatorio",
        variant: "destructive"
      });
      return false;
    }

    // Validar teléfono
    if (!phone.trim()) {
      toast({
        title: "Teléfono requerido",
        description: "El teléfono del taller es obligatorio",
        variant: "destructive"
      });
      return false;
    }

    // Validar formato de teléfono (básico)
    const phoneRegex = /^[+]?[1-9][\d]{0,15}$/;
    if (!phoneRegex.test(phone.replace(/[\s\-()]/g, ''))) {
      toast({
        title: "Teléfono inválido",
        description: "Por favor, introduce un número de teléfono válido",
        variant: "destructive"
      });
      return false;
    }

    // Validar contraseña
    const passwordErrors = validatePassword(password);
    if (passwordErrors.length > 0) {
      toast({
        title: "Contraseña inválida",
        description: passwordErrors.join(', '),
        variant: "destructive"
      });
      return false;
    }

    // Validar confirmación de contraseña
    if (password !== confirmPassword) {
      toast({
        title: "Contraseñas no coinciden",
        description: "Las contraseñas introducidas no son iguales",
        variant: "destructive"
      });
      return false;
    }

    // Validar términos y condiciones
    if (!acceptTerms) {
      toast({
        title: "Términos requeridos",
        description: "Debes aceptar los términos y condiciones",
        variant: "destructive"
      });
      return false;
    }

    return true;
  };

  const handleRegister = async (e: React.FormEvent) => {
    e.preventDefault();
    
    // Validar formulario
    if (!validateForm()) {
      return;
    }

    setIsLoading(true);
    
    try {
      // PASO 1: Cerrar cualquier sesión activa para evitar conflictos
      await supabase.auth.signOut();
      
      // PASO 2: Registrar usuario SIN auto-confirmación para evitar login automático
      const { data, error } = await supabase.auth.signUp({
        email,
        password,
        options: {
          data: {
            workshop_name: tallerName,
            role: 'admin_mechanic',
            full_name: fullName
          },
          emailRedirectTo: undefined // Evitar auto-confirmación
        }
      });

      if (error) {
        throw error;
      }

      if (data.user) {
        console.log('Usuario creado, ID:', data.user.id);
        
        // PASO 3: Crear workshop
        try {
          const workshopId = await createWorkshop();
          
          // PASO 4: Actualizar perfil con workshop_id
          await updateProfileWithWorkshop(data.user.id, workshopId);
          
          // PASO 5: Mostrar mensaje de verificación de email
          toast({
            title: "¡Registro completado!",
            description: "Tu cuenta y taller se han creado correctamente. Revisa tu email para verificar tu cuenta antes de iniciar sesión.",
          });
          navigate('/login');
          
        } catch (workshopError: any) {
          const appError = createError(
            ErrorType.DATABASE_ERROR,
            `Tu cuenta se creó pero hubo un problema configurando el taller: ${workshopError.message}. Verifica tu email y contacta con soporte.`,
            workshopError
          );
          handleError(appError, toast);
          navigate('/login');
        }
      }
    } catch (error: any) {
      let appError: AppError;
      
      if (error?.message?.includes('email')) {
        appError = createError(
          ErrorType.AUTHENTICATION_ERROR,
          'Error con el email. Verifica que sea válido y no esté ya registrado.',
          error
        );
      } else if (error?.message?.includes('password')) {
        appError = createError(
          ErrorType.VALIDATION_ERROR,
          'Error con la contraseña. Debe tener al menos 6 caracteres.',
          error
        );
      } else {
        appError = createError(
          ErrorType.UNKNOWN_ERROR,
          'Hubo un problema al crear tu cuenta. Inténtalo de nuevo.',
          error
        );
      }
      
      handleError(appError, toast);
    } finally {
      setIsLoading(false);
    }
  };

  const createWorkshop = async () => {
    try {
      console.log('Creando workshop con datos:', { name: tallerName, email: workshopEmail || email });
      const { data: workshopData, error: workshopError } = await supabase
        .from('workshops')
        .insert({
          name: tallerName,
          email: workshopEmail || email,
          phone: phone || null,
          address: address || null
        })
        .select();

      if (workshopError) {
        console.error('Error creating workshop:', workshopError);
        throw new Error(`Error creando taller: ${workshopError.message}`);
      }

      if (!workshopData || workshopData.length === 0) {
        throw new Error('No se pudo crear el taller');
      }

      const workshop = workshopData[0];
      console.log('Workshop creado exitosamente:', workshop.id);
      return workshop.id;

    } catch (error: any) {
      console.error('Error in createWorkshop:', error);
      throw error;
    }
  };

  const updateProfileWithWorkshop = async (userId: string, workshopId: string) => {
    try {
      console.log('Actualizando perfil con workshop_id:', workshopId);
      
      // Usar UPSERT para manejar tanto UPDATE como INSERT
      const { error: profileError } = await supabase
        .from('profiles')
        .upsert({
          id: userId,
          email: email,
          full_name: fullName,
          role: 'admin_mechanic',
          workshop_id: workshopId
        }, {
          onConflict: 'id'
        });

      if (profileError) {
        console.error('Error upserting profile:', profileError);
        throw new Error(`Error actualizando perfil: ${profileError.message}`);
      }

      console.log('Profile actualizado exitosamente con workshop_id:', workshopId);

    } catch (error: any) {
      console.error('Error in updateProfileWithWorkshop:', error);
      throw error;
    }
  };

  return (
    <div className="min-h-screen bg-gradient-hero flex items-center justify-center p-4">
      <div className="w-full max-w-md">
        {/* Header */}
        <div className="text-center mb-8">
          <Link to="/" className="inline-flex items-center text-primary-foreground hover:text-primary-foreground/80 transition-colors mb-4">
            <ArrowLeft className="h-4 w-4 mr-2" />
            Volver al inicio
          </Link>
          <div className="flex items-center justify-center space-x-2 mb-4">
            <Calculator className="h-8 w-8 text-primary-foreground" />
            <span className="text-2xl font-bold text-primary-foreground">Valora Plus</span>
          </div>
          <p className="text-primary-foreground/80">Registra tu taller para empezar</p>
        </div>

        <Card className="bg-card/95 backdrop-blur-sm border-border/50 shadow-elegant">
          <CardHeader className="text-center">
            <CardTitle className="flex items-center justify-center space-x-2">
              <Mail className="h-5 w-5 text-primary" />
              <span>Registrar Taller</span>
            </CardTitle>
            <CardDescription>
              Crea tu cuenta para empezar a analizar la rentabilidad de tu taller
            </CardDescription>
          </CardHeader>
          
          <CardContent>
            <form onSubmit={handleRegister} className="space-y-4">
                <div className="space-y-2">
                  <Label htmlFor="email">Tu email *</Label>
                  <Input
                    id="email"
                    type="email"
                    placeholder="tu.email@ejemplo.com"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    required
                    className="transition-all duration-300 focus:shadow-glow"
                  />
                  <p className="text-sm text-muted-foreground">
                    Este será tu email para iniciar sesión
                  </p>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="fullName">Tu nombre completo *</Label>
                  <Input
                    id="fullName"
                    type="text"
                    placeholder="Juan Pérez"
                    value={fullName}
                    onChange={(e) => setFullName(e.target.value)}
                    required
                    className="transition-all duration-300 focus:shadow-glow"
                  />
                </div>
                
                <div className="space-y-2">
                  <Label htmlFor="taller">Nombre del taller *</Label>
                  <Input
                    id="taller"
                    placeholder="Mi Taller Mecánico"
                    value={tallerName}
                    onChange={(e) => setTallerName(e.target.value)}
                    required
                    className="transition-all duration-300 focus:shadow-glow"
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="phone">Teléfono del taller *</Label>
                  <Input
                    id="phone"
                    type="tel"
                    placeholder="+34 123 456 789"
                    value={phone}
                    onChange={(e) => setPhone(e.target.value)}
                    required
                    className="transition-all duration-300 focus:shadow-glow"
                  />
                  <p className="text-sm text-muted-foreground">
                    Número de contacto principal del taller
                  </p>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="password">Contraseña *</Label>
                  <div className="relative">
                    <Input
                      id="password"
                      type={showPassword ? "text" : "password"}
                      placeholder="Mínimo 8 caracteres"
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                      required
                      className="transition-all duration-300 focus:shadow-glow pr-10"
                    />
                    <Button
                      type="button"
                      variant="ghost"
                      size="sm"
                      className="absolute right-0 top-0 h-full px-3 py-2 hover:bg-transparent"
                      onClick={() => setShowPassword(!showPassword)}
                    >
                      {showPassword ? (
                        <EyeOff className="h-4 w-4 text-muted-foreground" />
                      ) : (
                        <Eye className="h-4 w-4 text-muted-foreground" />
                      )}
                    </Button>
                  </div>
                  <p className="text-xs text-muted-foreground">
                    Debe contener al menos 8 caracteres, una mayúscula, una minúscula, un número y un carácter especial (!@#$%^&*(),.?":{}|{'<>'}-)
                  </p>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="confirmPassword">Confirmar contraseña *</Label>
                  <div className="relative">
                    <Input
                      id="confirmPassword"
                      type={showConfirmPassword ? "text" : "password"}
                      placeholder="Repite tu contraseña"
                      value={confirmPassword}
                      onChange={(e) => setConfirmPassword(e.target.value)}
                      required
                      className="transition-all duration-300 focus:shadow-glow pr-10"
                    />
                    <Button
                      type="button"
                      variant="ghost"
                      size="sm"
                      className="absolute right-0 top-0 h-full px-3 py-2 hover:bg-transparent"
                      onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                    >
                      {showConfirmPassword ? (
                        <EyeOff className="h-4 w-4 text-muted-foreground" />
                      ) : (
                        <Eye className="h-4 w-4 text-muted-foreground" />
                      )}
                    </Button>
                  </div>
                </div>

                <div className="flex items-start space-x-2">
                  <Checkbox
                    id="terms"
                    checked={acceptTerms}
                    onCheckedChange={(checked) => setAcceptTerms(checked as boolean)}
                    className="mt-1"
                  />
                  <Label htmlFor="terms" className="text-sm leading-relaxed">
                    Acepto los{' '}
                    <Link to="/terms" className="text-primary hover:underline">
                      términos y condiciones
                    </Link>{' '}
                    y la{' '}
                    <Link to="/privacy" className="text-primary hover:underline">
                      política de privacidad
                    </Link>
                    . Doy mi consentimiento para el tratamiento de mis datos según el RGPD.
                  </Label>
                </div>

                <Button 
                  type="submit" 
                  className="w-full bg-gradient-primary text-primary-foreground shadow-glow hover:shadow-lg transition-all duration-300"
                  disabled={isLoading}
                >
                  {isLoading ? 'Creando cuenta...' : 'Crear cuenta'}
                </Button>
              </form>

              {/* Enlaces dentro del recuadro */}
              <div className="text-center space-y-2 mt-6 pt-4 border-t border-border/50">
                <p className="text-sm text-muted-foreground">
                  ¿Ya tienes una cuenta?{' '}
                  <Link to="/login" className="text-primary hover:underline font-medium">
                    Inicia sesión
                  </Link>
                </p>
                <p className="text-sm text-muted-foreground">
                  ¿Necesitas ayuda?{' '}
                  <Link to="/contact" className="text-primary hover:underline">
                    Contáctanos
                  </Link>
                </p>
              </div>
          </CardContent>
        </Card>

        {/* Footer info */}
        <div className="text-center mt-6 text-primary-foreground/60 text-sm">
          <p>🔒 Tus datos están protegidos con cifrado de extremo a extremo</p>
          <p className="mt-1">3 análisis gratuitos al mes • Sin tarjeta de crédito</p>
        </div>
      </div>
    </div>
  );
};

export default Register;