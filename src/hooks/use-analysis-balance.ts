import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';

export interface AnalysisBalance {
  // Análisis gratuitos
  freeAnalysesUsed: number;
  freeAnalysesLimit: number;
  remainingFreeAnalyses: number;
  
  // Análisis pagados
  paidAnalysesAvailable: number;
  paidAnalysesUsed: number;
  totalPaidAnalysesPurchased: number;
  
  // Totales
  totalAnalysesThisMonth: number;
  totalAnalysesAvailable: number; // gratuitos + pagados disponibles
  
  // Estado de pago
  totalAmountDue: number;
  paymentStatus: string;
  
  // Información temporal
  year: number;
  month: number;
}

export const useAnalysisBalance = () => {
  const [balance, setBalance] = useState<AnalysisBalance | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const { toast } = useToast();

  const fetchBalance = async () => {
    try {
      setLoading(true);
      setError(null);

      // Obtener el uso mensual actual (que ya incluye información de análisis pagados)
      const { data: monthlyData, error: monthlyError } = await supabase.rpc('get_current_monthly_usage');
      
      if (monthlyError) {
        console.error('Error fetching monthly usage:', monthlyError);
        throw monthlyError;
      }

      //console.log('Monthly data:', monthlyData);

      if (monthlyData) {
        const usageData = monthlyData as any; // Cast para acceder a las propiedades
        
        const analysisBalance: AnalysisBalance = {
          // Análisis gratuitos
          freeAnalysesUsed: usageData.free_analyses_used || 0,
          freeAnalysesLimit: usageData.free_analyses_limit || 3,
          remainingFreeAnalyses: usageData.remaining_free_analyses || 0,
          
          // Análisis pagados (totales históricos, no del mes en curso)
          paidAnalysesAvailable: usageData.remaining_paid_analyses || 0,
          paidAnalysesUsed: usageData.total_paid_analyses_used || 0,
          totalPaidAnalysesPurchased: usageData.total_paid_analyses || 0,
          
          // Totales
          totalAnalysesThisMonth: usageData.total_analyses || 0,
          totalAnalysesAvailable: (usageData.remaining_free_analyses || 0) + (usageData.remaining_paid_analyses || 0),
          
          // Estado de pago
          totalAmountDue: usageData.total_amount_due || 0,
          paymentStatus: usageData.payment_status || 'pending',
          
          // Información temporal
          year: usageData.year || new Date().getFullYear(),
          month: usageData.month || new Date().getMonth() + 1
        };

        //console.log('Final analysis balance:', analysisBalance);
        setBalance(analysisBalance);
      }
    } catch (err) {
      console.error('Error fetching analysis balance:', err);
      setError(err instanceof Error ? err.message : 'Error desconocido');
      toast({
        title: "Error",
        description: "No se pudo cargar el balance de análisis",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  const refreshBalance = () => {
    return fetchBalance();
  };

  // Función para verificar si el usuario puede crear un análisis
  const canCreateAnalysis = () => {
    if (!balance) return false;
    return balance.totalAnalysesAvailable > 0;
  };

  // Función para obtener el costo del próximo análisis
  const getNextAnalysisCost = async () => {
    try {
      if (!balance) {
        await fetchBalance();
      }
      
      if (!balance) return 0;
      
      // Obtener el precio adicional de system_settings
      const { data: additionalPrice } = await supabase
        .from('system_settings')
        .select('setting_value')
        .eq('setting_key', 'additional_analysis_price')
        .single();
        
      // Obtener si el billing está habilitado
      const { data: billingEnabled } = await supabase
        .from('system_settings')
        .select('setting_value')
        .eq('setting_key', 'billing_enabled')
        .single();
      
      const isBillingEnabled = (billingEnabled?.setting_value as any)?.value === true;
      const price = (additionalPrice?.setting_value as any)?.value || 0;
      
      // Si tiene análisis disponibles (gratuitos o pagados), el costo es 0
      if (balance.totalAnalysesAvailable > 0) {
        return 0;
      }
      
      // Si no tiene análisis disponibles y el billing está habilitado, devolver el precio
      if (isBillingEnabled) {
        return price;
      }
      
      return 0;
    } catch (err) {
      console.error('Error calculando el costo del próximo análisis:', err);
      return 0;
    }
  };

  // Función para obtener un resumen legible del estado
  const getBalanceSummary = () => {
    if (!balance) return "Cargando...";
    
    const parts = [];
    
    // Análisis gratuitos
    if (balance.remainingFreeAnalyses > 0) {
      parts.push(`${balance.remainingFreeAnalyses} gratuitos`);
    } else {
      parts.push(`${balance.freeAnalysesUsed}/${balance.freeAnalysesLimit} gratuitos usados`);
    }
    
    // Análisis pagados
    if (balance.paidAnalysesAvailable > 0) {
      parts.push(`${balance.paidAnalysesAvailable} pagados disponibles`);
    }
    
    return parts.join(', ');
  };

  useEffect(() => {
    fetchBalance();
    
    // Configurar polling para actualizar el balance cada 30 segundos
    const interval = setInterval(() => {
      fetchBalance();
    }, 30000);
    
    return () => clearInterval(interval);
  }, []);

  return {
    balance,
    loading,
    error,
    refreshBalance,
    canCreateAnalysis,
    getNextAnalysisCost,
    getBalanceSummary
  };
};