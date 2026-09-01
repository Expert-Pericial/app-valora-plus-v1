import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import type { Tables } from '@/integrations/supabase/types';

export type AnalysisPackage = Tables<'analysis_packages'>;

export interface PackageWithSavings extends AnalysisPackage {
  savings: number;
  formattedPrice: string;
  formattedSavings: string;
}

export const useAnalysisPackages = () => {
  const [packages, setPackages] = useState<PackageWithSavings[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchPackages = async () => {
    try {
      setLoading(true);
      setError(null);

      // Obtener paquetes activos usando la función RPC
      const { data: packagesData, error: packagesError } = await supabase
        .rpc('get_active_packages');

      if (packagesError) {
        throw packagesError;
      }

      // Obtener el precio base de un análisis individual
      const { data: settingData, error: settingError } = await supabase
        .rpc('get_system_setting', { setting_name: 'additional_analysis_price' });

      if (settingError) {
        throw settingError;
      }

      // get_system_setting devuelve JSONB: {"value": 25.00, "currency": "EUR"}, en euros.
      // total_price está en céntimos (así lo pasa payment-session a Stripe como
      // unit_amount), así que hay que convertir el precio base antes de comparar.
      const basePriceInCents = Number((settingData as { value?: number } | null)?.value ?? 0) * 100;

      // Calcular ahorros y formatear precios
      const packagesWithSavings: PackageWithSavings[] = (packagesData as AnalysisPackage[]).map(pkg => {
        const regularPrice = pkg.analyses_count * basePriceInCents;
        const savings = regularPrice - pkg.total_price;
        
        return {
          ...pkg,
          savings,
          formattedPrice: `€${(pkg.total_price / 100).toFixed(2)}`,
          formattedSavings: `€${(savings / 100).toFixed(2)}`
        };
      });

      setPackages(packagesWithSavings);
    } catch (err) {
      console.error('Error fetching analysis packages:', err);
      setError(err instanceof Error ? err.message : 'Error desconocido');
      setPackages([]);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchPackages();
  }, []);

  return {
    packages,
    loading,
    error,
    refetch: fetchPackages
  };
};