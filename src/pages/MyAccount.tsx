import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { User, BarChart3, Calendar, FileText, TrendingUp, Crown, ArrowRight, Loader2, Save, X } from "lucide-react";
import { Link, useNavigate } from "react-router-dom";
import { useAuth } from "@/contexts/AuthContext";
import { useState, useEffect } from "react";
import { supabase } from "@/lib/supabase";
import { useToast } from "@/hooks/use-toast";
import { useMonthlyUsage } from "@/hooks/use-monthly-usage";
import { useAnalysisBalance } from "@/hooks/use-analysis-balance";
import { useAnalysisPackages } from "@/hooks/use-analysis-packages";
import PackageSelectionModal from "@/components/PackageSelectionModal";

interface Analysis {
  id: string;
  created_at: string;
  pdf_url?: string;
  vehicle_data: {
    license_plate: string;
    internal_reference: string;
  }[];
  insurance_amounts: {
    total_with_iva: number;
  }[];
  workshop_costs: {
    spare_parts_purchase_cost: number;
    bodywork_actual_hours: number;
    bodywork_hourly_cost: number;
    painting_actual_hours: number;
    painting_hourly_cost: number;
    painting_consumables_cost: number;
    subcontractor_costs: number;
    other_costs: number;
  }[];
}

interface AnalysisWithCalculations extends Analysis {
  matricula: string;
  referencia: string;
  fecha: string;
  margen_eur: number;
  margen_pct: number;
  status: string;
  pdf_url?: string;
}

const MyAccount = () => {
  const { user, profile, workshop, loading, refreshProfile, refreshWorkshop } = useAuth();
  const navigate = useNavigate();
  const { toast } = useToast();
  const { usage: monthlyUsage, loading: usageLoading, refreshUsage } = useMonthlyUsage();
  const { balance: analysisBalance, loading: balanceLoading } = useAnalysisBalance();
  const { packages, loading: packagesLoading } = useAnalysisPackages();
  
  const [userAnalyses, setUserAnalyses] = useState<AnalysisWithCalculations[]>([]);
  const [analysesLoading, setAnalysesLoading] = useState(true);
  const [analysesError, setAnalysesError] = useState<string | null>(null);
  
  // Estados para la edición del perfil
  const [isEditing, setIsEditing] = useState(false);
  const [isSaving, setIsSaving] = useState(false);
  const [formData, setFormData] = useState({
    full_name: '',
    workshop_name: '',
    workshop_email: '',
    workshop_phone: '',
    workshop_address: ''
  });

  // Estado para el modal de paquetes
  const [showPackageModal, setShowPackageModal] = useState(false);

  // Load user's analyses
  useEffect(() => {
    const loadAnalyses = async () => {
      if (!user?.id) return;
      
      try {
        setAnalysesLoading(true);
        setAnalysesError(null);

        // Get analyses for the current user
        const { data: analysisData, error: analysisError } = await supabase
          .from('analysis')
          .select(`
            id,
            created_at,
            pdf_url,
            vehicle_data (
              license_plate,
              internal_reference
            ),
            insurance_amounts (
              total_with_iva
            ),
            workshop_costs (
              spare_parts_purchase_cost,
              bodywork_actual_hours,
              bodywork_hourly_cost,
              painting_actual_hours,
              painting_hourly_cost,
              painting_consumables_cost,
              subcontractor_costs,
              other_costs
            )
          `)
          .eq('user_id', user.id)
          .order('created_at', { ascending: false });

        if (analysisError) {
          console.error('Error loading analyses:', analysisError);
          setAnalysesError('Error al cargar el historial de análisis');
          return;
        }

        // Process the data to calculate margins and status
        const processedAnalyses: AnalysisWithCalculations[] = (analysisData || []).map((analysis: Analysis) => {
          const vehicleData = Array.isArray(analysis.vehicle_data) ? analysis.vehicle_data[0] : analysis.vehicle_data;
          const insuranceAmounts = Array.isArray(analysis.insurance_amounts) ? analysis.insurance_amounts[0] : analysis.insurance_amounts;
          const workshopCosts = Array.isArray(analysis.workshop_costs) ? analysis.workshop_costs[0] : analysis.workshop_costs;

          // Calculate totals
          const ingresos_totales = insuranceAmounts?.total_with_iva || 0;

          // Calculate costs
          const costes_repuestos = workshopCosts?.spare_parts_purchase_cost || 0;
          const costes_mo_chapa = (workshopCosts?.bodywork_actual_hours || 0) * (workshopCosts?.bodywork_hourly_cost || 0);
          const costes_mo_pintura = (workshopCosts?.painting_actual_hours || 0) * (workshopCosts?.painting_hourly_cost || 0);
          const costes_mat_pintura = workshopCosts?.painting_consumables_cost || 0;
          const costes_otros = (workshopCosts?.subcontractor_costs || 0) + (workshopCosts?.other_costs || 0);
          const costes_totales = costes_repuestos + costes_mo_chapa + costes_mo_pintura + costes_mat_pintura + costes_otros;

          // Determine status first
          const hasInsuranceData = !!insuranceAmounts?.total_with_iva;
          const hasWorkshopData = !!(workshopCosts?.spare_parts_purchase_cost ||
            workshopCosts?.bodywork_actual_hours ||
            workshopCosts?.painting_actual_hours ||
            workshopCosts?.painting_consumables_cost ||
            workshopCosts?.subcontractor_costs ||
            workshopCosts?.other_costs);

          let status = 'pending_verification';
          if (hasInsuranceData && hasWorkshopData) {
            status = 'completed';
          } else if (hasInsuranceData && !hasWorkshopData) {
            status = 'pending_costs';
          }

          // Calculate margins only if analysis is completed
          let margen_eur = 0;
          let margen_pct = 0;
          if (status === 'completed') {
            margen_eur = ingresos_totales - costes_totales;
            margen_pct = ingresos_totales > 0 ? (margen_eur / ingresos_totales) * 100 : 0;
          }

          return {
            ...analysis,
            matricula: vehicleData?.license_plate || 'N/A',
            referencia: vehicleData?.internal_reference || 'N/A',
            fecha: analysis.created_at,
            margen_eur,
            margen_pct,
            status,
            pdf_url: analysis.pdf_url
          };
        });

        setUserAnalyses(processedAnalyses);
      } catch (error) {
        console.error('Error loading analyses:', error);
        setAnalysesError('Error al cargar el historial de análisis');
      } finally {
        setAnalysesLoading(false);
      }
    };

    loadAnalyses();
  }, [user?.id]);

  // Inicializar datos del formulario cuando cambie el perfil o workshop
  useEffect(() => {
    setFormData({
      full_name: profile?.full_name || 
                 user?.identities?.[0]?.identity_data?.full_name || 
                 user?.user_metadata?.display_name || 
                 user?.email?.split('@')[0] || 
                 '',
      workshop_name: workshop?.name || '',
      workshop_email: workshop?.email || '',
      workshop_phone: workshop?.phone || '',
      workshop_address: workshop?.address || ''
    });
  }, [profile, workshop, user]);

  // Datos del usuario (dinámicos desde el usuario autenticado)
  const userData = {
    email: user?.email || "No especificado",
    full_name: profile?.full_name || 
               user?.identities?.[0]?.identity_data?.full_name || 
               user?.user_metadata?.display_name || 
               user?.email?.split('@')[0] || 
               "Usuario",
    taller: workshop?.name || "Taller no especificado",
    created_at: profile?.created_at || new Date().toISOString(),
    monthlyUsage: monthlyUsage?.freeAnalysesUsed || 0,
    maxUsage: monthlyUsage?.freeAnalysesLimit || 3,
    totalAnalyses: monthlyUsage?.totalAnalyses || 0,
    remainingFreeAnalyses: monthlyUsage?.remainingFreeAnalyses || 0,
    paidAnalyses: monthlyUsage?.paidAnalysesCount || 0,
    totalAmountDue: monthlyUsage?.totalAmountDue || 0,
    paymentStatus: monthlyUsage?.paymentStatus || 'pending'
  };

  // Funciones auxiliares
  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat('es-ES', {
      style: 'currency',
      currency: 'EUR'
    }).format(value);
  };

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('es-ES', {
      year: 'numeric',
      month: 'short',
      day: 'numeric'
    });
  };

  // Funciones de edición del perfil
  const handleEditClick = () => {
    setIsEditing(true);
  };

  const handleCancelEdit = () => {
    setIsEditing(false);
    // Restaurar valores originales
    setFormData({
      full_name: profile?.full_name || 
                 user?.identities?.[0]?.identity_data?.full_name || 
                 user?.user_metadata?.display_name || 
                 user?.email?.split('@')[0] || 
                 '',
      workshop_name: workshop?.name || '',
      workshop_email: workshop?.email || '',
      workshop_phone: workshop?.phone || '',
      workshop_address: workshop?.address || ''
    });
  };

  const handleSaveChanges = async () => {
    if (!user?.id) return;

    setIsSaving(true);
    try {
      // Actualizar perfil si el nombre ha cambiado
      if (formData.full_name !== (profile?.full_name || '')) {
        const { error: profileError } = await supabase
          .from('profiles')
          .update({ full_name: formData.full_name })
          .eq('id', user.id);

        if (profileError) throw profileError;
      }

      // Actualizar workshop si algún campo ha cambiado
      if (workshop && (
        formData.workshop_name !== workshop.name ||
        formData.workshop_email !== (workshop.email || '') ||
        formData.workshop_phone !== (workshop.phone || '') ||
        formData.workshop_address !== (workshop.address || '')
      )) {
        const { error: workshopError } = await supabase
          .from('workshops')
          .update({ 
            name: formData.workshop_name,
            email: formData.workshop_email || null,
            phone: formData.workshop_phone || null,
            address: formData.workshop_address || null
          })
          .eq('id', workshop.id);

        if (workshopError) throw workshopError;
      }

      // Refrescar datos
      if (refreshProfile) await refreshProfile();
      if (refreshWorkshop) await refreshWorkshop();

      setIsEditing(false);
      toast({
        title: "Perfil actualizado",
        description: "Los cambios se han guardado correctamente.",
      });
    } catch (error) {
      console.error('Error updating profile:', error);
      toast({
        title: "Error",
        description: "No se pudieron guardar los cambios. Inténtalo de nuevo.",
        variant: "destructive",
      });
    } finally {
      setIsSaving(false);
    }
  };

  const handleInputChange = (field: string, value: string) => {
    setFormData(prev => ({
      ...prev,
      [field]: value
    }));
  };

  // Función para abrir el PDF original
  const handleOpenOriginalPDF = (pdfUrl: string | null | undefined) => {
    if (pdfUrl) {
      window.open(pdfUrl, '_blank');
    } else {
      toast({
        title: "PDF no disponible",
        description: "No hay un PDF original disponible para este análisis.",
        variant: "destructive",
      });
    }
  };

  // Cálculos dinámicos - solo incluir análisis completados
  const completedAnalyses = userAnalyses.filter(analysis => analysis.status === 'completed');
  const averageMargin = completedAnalyses.length > 0
    ? completedAnalyses.reduce((sum, analysis) => sum + analysis.margen_pct, 0) / completedAnalyses.length
    : 0;

  const totalMargin = completedAnalyses.reduce((sum, analysis) => sum + analysis.margen_eur, 0);

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <Loader2 className="h-8 w-8 animate-spin" />
      </div>
    );
  }

  return (
    <div className="container mx-auto p-6 space-y-8">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-foreground">Mi Cuenta</h1>
          <p className="text-muted-foreground">Gestiona tu perfil y revisa tu actividad</p>
        </div>
      </div>

      <div className="grid gap-6 md:grid-cols-3 lg:grid-cols-4">
        {/* Información Personal - Card más ancho */}
        <Card className="md:col-span-2 lg:col-span-3">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <User className="h-5 w-5" />
              Información Personal
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-6">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
              {/* Datos del Usuario */}
              <div>
                <h3 className="text-sm font-semibold text-foreground mb-3 flex items-center gap-2">
                  <User className="h-4 w-4" />
                  Datos del Usuario
                </h3>
                <div className="grid gap-4">
                  <div>
                    <Label className="text-sm font-medium text-muted-foreground">Email</Label>
                    <p className="text-foreground">{userData.email}</p>
                  </div>
                  <div>
                    <Label className="text-sm font-medium text-muted-foreground">Nombre</Label>
                    {isEditing ? (
                      <Input
                        value={formData.full_name}
                        onChange={(e) => handleInputChange('full_name', e.target.value)}
                        placeholder="Ingresa tu nombre completo"
                        className="mt-1"
                      />
                    ) : (
                      <p className="text-foreground">{userData.full_name}</p>
                    )}
                  </div>
                  <div>
                    <Label className="text-sm font-medium text-muted-foreground">Miembro desde</Label>
                    <p className="text-foreground">{formatDate(userData.created_at)}</p>
                  </div>
                </div>
              </div>

              {/* Datos del Taller */}
              <div>
                <h3 className="text-sm font-semibold text-foreground mb-3 flex items-center gap-2">
                  <Crown className="h-4 w-4" />
                  Datos del Taller
                </h3>
                <div className="grid gap-4">
                  <div>
                    <Label className="text-sm font-medium text-muted-foreground">Nombre del Taller</Label>
                    {isEditing ? (
                      <Input
                        value={formData.workshop_name}
                        onChange={(e) => handleInputChange('workshop_name', e.target.value)}
                        placeholder="Nombre del taller"
                        className="mt-1"
                      />
                    ) : (
                      <p className="text-foreground">{userData.taller}</p>
                    )}
                  </div>
                  <div>
                    <Label className="text-sm font-medium text-muted-foreground">Email del Taller</Label>
                    {isEditing ? (
                      <>
                        <Input
                          value={formData.workshop_email}
                          onChange={(e) => handleInputChange('workshop_email', e.target.value)}
                          placeholder="contacto@taller.com"
                          type="email"
                          className="mt-1"
                        />
                        <p className="text-xs text-muted-foreground mt-1">Email de contacto comercial del taller</p>
                      </>
                    ) : (
                      <p className="text-foreground">{workshop?.email || "No especificado"}</p>
                    )}
                  </div>
                  <div>
                    <Label className="text-sm font-medium text-muted-foreground">Teléfono del Taller</Label>
                    {isEditing ? (
                      <>
                        <Input
                          value={formData.workshop_phone}
                          onChange={(e) => handleInputChange('workshop_phone', e.target.value)}
                          placeholder="+34 123 456 789"
                          type="tel"
                          className="mt-1"
                        />
                        <p className="text-xs text-muted-foreground mt-1">Teléfono de contacto del taller</p>
                      </>
                    ) : (
                      <p className="text-foreground">{workshop?.phone || "No especificado"}</p>
                    )}
                  </div>
                  <div>
                    <Label className="text-sm font-medium text-muted-foreground">Dirección del Taller</Label>
                    {isEditing ? (
                      <>
                        <Input
                          value={formData.workshop_address}
                          onChange={(e) => handleInputChange('workshop_address', e.target.value)}
                          placeholder="Calle Principal 123, Ciudad"
                          className="mt-1"
                        />
                        <p className="text-xs text-muted-foreground mt-1">Dirección física del taller</p>
                      </>
                    ) : (
                      <p className="text-foreground">{workshop?.address || "No especificado"}</p>
                    )}
                  </div>
                </div>
              </div>
            </div>

            {/* Botones de acción */}
            <div className="flex gap-2 pt-4 border-t">
              {isEditing ? (
                <>
                  <Button 
                    variant="default" 
                    size="sm"
                    onClick={handleSaveChanges}
                    disabled={isSaving}
                    className="flex items-center gap-2"
                  >
                    {isSaving ? (
                      <Loader2 className="h-4 w-4 animate-spin" />
                    ) : (
                      <Save className="h-4 w-4" />
                    )}
                    {isSaving ? 'Guardando...' : 'Guardar'}
                  </Button>
                  <Button 
                    variant="outline" 
                    size="sm"
                    onClick={handleCancelEdit}
                    disabled={isSaving}
                    className="flex items-center gap-2"
                  >
                    <X className="h-4 w-4" />
                    Cancelar
                  </Button>
                </>
              ) : (
                <Button 
                  variant="outline" 
                  size="sm"
                  onClick={() => setIsEditing(true)}
                  className="flex items-center gap-2"
                >
                  <User className="h-4 w-4" />
                  Editar Perfil
                </Button>
              )}
              <Button 
                variant="outline" 
                size="sm"
                onClick={() => {
                  supabase.auth.signOut();
                  navigate('/');
                }}
              >
                Cerrar Sesión
              </Button>
            </div>
          </CardContent>
        </Card>

        {/* Balance de Análisis - A la derecha */}
        <Card className="md:col-span-1 lg:col-span-1">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <BarChart3 className="h-5 w-5" />
              Balance de Análisis
              {(usageLoading || balanceLoading) && <Loader2 className="h-4 w-4 animate-spin" />}
            </CardTitle>
            <CardDescription>
              {analysisBalance ? (
                `${analysisBalance.totalAnalysesAvailable} análisis disponibles en total`
              ) : (
                `${userData.monthlyUsage} de ${userData.maxUsage} análisis gratuitos utilizados`
              )}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {analysisBalance ? (
                <>
                  {/* Análisis gratuitos */}
                  <div className="space-y-2">
                    <div className="flex justify-between text-sm">
                      <span>Análisis gratuitos usados</span>
                      <span>
                        {analysisBalance.freeAnalysesLimit > 0
                          ? `${Math.round((analysisBalance.freeAnalysesUsed / analysisBalance.freeAnalysesLimit) * 100)}%`
                          : '—'}
                      </span>
                    </div>
                    <div className="w-full bg-secondary rounded-full h-2">
                      <div 
                        className="bg-primary h-2 rounded-full transition-all duration-300"
                        style={{
                          width: analysisBalance.freeAnalysesLimit > 0
                            ? `${Math.min(100, (analysisBalance.freeAnalysesUsed / analysisBalance.freeAnalysesLimit) * 100)}%`
                            : '0%'
                        }}
                      ></div>
                    </div>
                    <div className="text-xs text-muted-foreground">
                      {analysisBalance.remainingFreeAnalyses} análisis gratuitos restantes de {analysisBalance.freeAnalysesLimit}
                    </div>
                  </div>

                  {/* Análisis pagados */}
                  {(analysisBalance.paidAnalysesAvailable > 0 || analysisBalance.totalPaidAnalysesPurchased > 0) && (
                    <div className="space-y-2">
                      <div className="flex justify-between text-sm">
                        <span>Análisis pagados</span>
                        <span>{analysisBalance.paidAnalysesAvailable} disponibles</span>
                      </div>
                      {analysisBalance.totalPaidAnalysesPurchased > 0 && (
                        <div className="text-xs text-muted-foreground">
                          {analysisBalance.paidAnalysesUsed} usados de {analysisBalance.totalPaidAnalysesPurchased} comprados
                        </div>
                      )}
                    </div>
                  )}

                  {/* Resumen total */}
                  <div className="pt-2 border-t">
                    <div className="flex justify-between text-sm font-medium">
                      <span>Total disponible</span>
                      <span className={analysisBalance.totalAnalysesAvailable === 0 ? "text-destructive" : "text-primary"}>
                        {analysisBalance.totalAnalysesAvailable} análisis
                      </span>
                    </div>
                  </div>

                  {/* Compra de paquetes para admin_mechanic. Siempre disponible: antes
                      solo aparecia con el saldo a 0, asi que no habia forma de comprar
                      por adelantado ni de probar el flujo de pago teniendo gratuitos. */}
                  {profile?.role === 'admin_mechanic' && (
                    <div className="space-y-2 pt-2 border-t">
                      {analysisBalance.totalAnalysesAvailable === 0 && (
                        <div className="flex justify-between text-sm">
                          <span>Análisis disponibles</span>
                          <span className="text-destructive font-medium">0 análisis</span>
                        </div>
                      )}
                      <div className="bg-blue-50 dark:bg-blue-950/20 p-3 rounded-lg border border-blue-200 dark:border-blue-800">
                        <div className="flex items-center gap-2 text-blue-800 dark:text-blue-200 mb-2">
                          <Crown className="h-4 w-4" />
                          <span className="text-sm font-medium">Comprar Paquete de Análisis</span>
                        </div>
                        {packagesLoading ? (
                          <p className="text-xs text-blue-700 dark:text-blue-300">Cargando paquetes...</p>
                        ) : packages.length > 0 ? (
                          <div className="space-y-1">
                            <p className="text-xs text-blue-700 dark:text-blue-300">
                              Paquetes disponibles desde €{(packages[0]?.total_price / 100).toFixed(2)}
                            </p>
                            <Button 
                              size="sm" 
                              className="w-full mt-2"
                              onClick={() => setShowPackageModal(true)}
                            >
                              Ver Paquetes
                            </Button>
                          </div>
                        ) : (
                          <p className="text-xs text-blue-700 dark:text-blue-300">
                            Contacta con soporte para obtener más análisis
                          </p>
                        )}
                      </div>
                    </div>
                  )}
                </>
              ) : (
                <>
                  {/* Fallback al sistema anterior */}
                  <div className="space-y-2">
                    <div className="flex justify-between text-sm">
                      <span>Análisis gratuitos usados</span>
                      <span>
                        {userData.maxUsage > 0
                          ? `${Math.round((userData.monthlyUsage / userData.maxUsage) * 100)}%`
                          : '—'}
                      </span>
                    </div>
                    <div className="w-full bg-secondary rounded-full h-2">
                      <div
                        className="bg-primary h-2 rounded-full transition-all duration-300"
                        style={{
                          width: userData.maxUsage > 0
                            ? `${Math.min(100, (userData.monthlyUsage / userData.maxUsage) * 100)}%`
                            : '0%'
                        }}
                      ></div>
                    </div>
                    <div className="text-xs text-muted-foreground">
                      {userData.remainingFreeAnalyses} análisis gratuitos restantes
                    </div>
                  </div>

                  {/* Información adicional */}
                  {userData.totalAnalyses > userData.monthlyUsage && (
                    <div className="space-y-2">
                      <div className="flex justify-between text-sm">
                        <span>Análisis de pago</span>
                        <span>{userData.paidAnalyses}</span>
                      </div>

                    </div>
                  )}
                </>
              )}

              {/* Estado del plan */}
              <div className="mt-4 p-3 bg-gradient-to-r from-blue-50 to-indigo-50 dark:from-blue-950/20 dark:to-indigo-950/20 rounded-lg border border-blue-200 dark:border-blue-800">
                <div className="flex items-center gap-2 text-blue-800 dark:text-blue-200">
                  <Crown className="h-4 w-4" />
                  <span className="text-sm font-medium">Plan Básico</span>
                </div>
                <p className="text-xs text-blue-700 dark:text-blue-300 mt-1">
                  {userData.maxUsage} análisis gratuitos por mes
                </p>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Estadísticas de Análisis */}
      <div className="grid gap-6 md:grid-cols-3">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Total Análisis</CardTitle>
            <FileText className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{userAnalyses.length}</div>
            <p className="text-xs text-muted-foreground">
              Análisis completados este mes
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Margen Promedio</CardTitle>
            <TrendingUp className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{averageMargin.toFixed(1)}%</div>
            <p className="text-xs text-muted-foreground">
              Rentabilidad promedio
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Margen Total</CardTitle>
            <TrendingUp className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{formatCurrency(totalMargin)}</div>
            <p className="text-xs text-muted-foreground">
              Beneficio total generado
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Historial de Análisis */}
      <div className="space-y-6">
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Calendar className="h-5 w-5" />
              Historial de Análisis
            </CardTitle>
            <CardDescription>
              Revisa todos tus análisis de rentabilidad anteriores
            </CardDescription>
          </CardHeader>
          <CardContent>
            {analysesLoading ? (
              <div className="flex items-center justify-center py-12">
                <Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
                <span className="ml-2 text-muted-foreground">Cargando análisis...</span>
              </div>
            ) : userAnalyses.length > 0 ? (
              <div className="space-y-4">
                {userAnalyses.map((analysis) => (
                  <div key={analysis.id} className="flex items-center justify-between p-4 border rounded-lg hover:bg-muted/50 transition-colors">
                    <div className="space-y-1">
                      <div className="flex items-center gap-2">
                        <p className="font-medium">Matrícula: {analysis.matricula}</p>
                        <Badge variant={analysis.status === 'completed' ? 'outline' : 'secondary'} className={analysis.status === 'completed' ? 'border-green-500 text-green-700 bg-green-50' : ''}>
                          {analysis.status === 'completed' ? 'Completado' : 
                           analysis.status === 'pending_costs' ? 'Pendiente Costos' :
                           analysis.status === 'pending_verification' ? 'Pendiente Verificación' :
                           'Procesando'}
                        </Badge>
                      </div>
                      <p className="text-sm text-muted-foreground">
                        Referencia: {analysis.referencia} • {formatDate(analysis.fecha)}
                      </p>
                      {analysis.status === 'completed' && (
                        <p className="text-sm">
                          Margen: {formatCurrency(analysis.margen_eur)} ({analysis.margen_pct.toFixed(1)}%)
                        </p>
                      )}
                    </div>
                    <div className="flex items-center gap-2">
                      {analysis.pdf_url && (
                          <Button
                            variant="outline"
                            size="sm"
                            onClick={() => handleOpenOriginalPDF(analysis.pdf_url!)}
                            className="flex items-center gap-2"
                          >
                            <FileText className="h-4 w-4" />
                            Ver Valoración
                          </Button>
                        )}
                      {analysis.status === 'completed' ? (
                        <Link to={`/app/resultados/${analysis.id}`}>
                          <Button variant="outline" size="sm">
                            Ver Resultados
                          </Button>
                        </Link>
                      ) : analysis.status === 'pending_costs' ? (
                        <Link to={`/app/costes/${analysis.id}`}>
                          <Button variant="default" size="sm">
                            Completar Costos
                          </Button>
                        </Link>
                      ) : analysis.status === 'pending_verification' ? (
                        <Link to={`/app/verificacion/${analysis.id}`}>
                          <Button variant="default" size="sm">
                            Verificar Datos
                          </Button>
                        </Link>
                      ) : (
                        <Button variant="outline" size="sm" disabled>
                          {analysis.status === 'processing' ? 'Procesando...' : 'Error'}
                        </Button>
                      )}
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <div className="text-center py-12">
                <FileText className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
                <h3 className="text-lg font-medium text-foreground mb-2">
                  No tienes análisis aún
                </h3>
                <p className="text-muted-foreground mb-6">
                  Empieza tu primer análisis de rentabilidad para ver el historial aquí
                </p>
                <Link to="/app/nuevo">
                  <Button className="bg-gradient-primary text-primary-foreground shadow-glow">
                    Crear Primer Análisis
                    <ArrowRight className="ml-2 h-4 w-4" />
                  </Button>
                </Link>
              </div>
            )}
          </CardContent>
        </Card>
      </div>

      {/* Modal de selección de paquetes */}
      <PackageSelectionModal
        open={showPackageModal}
        onOpenChange={setShowPackageModal}
        onSuccess={() => {
          setShowPackageModal(false);
          // Refresh balance after successful payment
          refreshUsage();
        }}
      />
    </div>
  );
};

export default MyAccount;