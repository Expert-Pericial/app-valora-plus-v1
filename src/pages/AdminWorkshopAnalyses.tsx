import { useEffect, useMemo, useState } from "react";
import { useParams, Link } from "react-router-dom";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { AlertCircle, ArrowLeft, Building2, Loader2 } from "lucide-react";
import { supabase } from "@/lib/supabase";

type AnalysisRow = {
  id: string;
  status: string;
  analysis_date: string;
  valuation_date: string | null;
  user_id: string;
  insurance_amounts?: Array<{
    net_subtotal: number | null;
    total_with_iva: number | null;
    iva_amount: number | null;
  }> | null;
  workshop_costs?: Array<{
    painting_hourly_cost: number | null;
    painting_actual_hours: number | null;
    painting_consumables_cost: number | null;
    bodywork_hourly_cost: number | null;
    bodywork_actual_hours: number | null;
    spare_parts_purchase_cost: number | null;
    subcontractor_costs: number | null;
    other_costs: number | null;
  }> | null;
};

const PAGE_SIZE = 10;

// Evita inferencias profundas de TypeScript en selects con joins anidados
const SELECT_COLUMNS = `id,status,analysis_date,valuation_date,user_id,
  insurance_amounts:insurance_amounts(net_subtotal,total_with_iva,iva_amount),
  workshop_costs:workshop_costs(painting_hourly_cost,painting_actual_hours,painting_consumables_cost,bodywork_hourly_cost,bodywork_actual_hours,spare_parts_purchase_cost,subcontractor_costs,other_costs)`;

function sumCost(row: AnalysisRow) {
  const c = row.workshop_costs?.[0];
  if (!c) return 0;
  const num = (v: number | null | undefined) => (typeof v === "number" ? v : 0);
  const body = num(c.bodywork_hourly_cost) * num(c.bodywork_actual_hours);
  const paint = num(c.painting_hourly_cost) * num(c.painting_actual_hours);
  const consum = num(c.painting_consumables_cost);
  const parts = num(c.spare_parts_purchase_cost);
  const subc = num(c.subcontractor_costs);
  const other = num(c.other_costs);
  return body + paint + consum + parts + subc + other;
}

function income(row: AnalysisRow) {
  const ia = row.insurance_amounts?.[0];
  if (!ia) return 0;
  
  // IMPORTANTE: Siempre usar net_subtotal (base imponible) para cálculos de rentabilidad
  // NUNCA restar IVA del total, ya que esto es matemáticamente incorrecto
  const net = ia.net_subtotal;
  if (typeof net === "number" && !Number.isNaN(net) && net > 0) {
    return net;
  }
  
  // Solo como fallback si net_subtotal no está disponible
  // pero esto indica un problema en la extracción de datos
  console.warn('net_subtotal no disponible para análisis:', row.id);
  return 0;
}

const AdminWorkshopAnalyses = () => {
  const { id } = useParams();
  const [workshopName, setWorkshopName] = useState<string>("Taller");
  const [rows, setRows] = useState<AnalysisRow[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  // Consultamos por workshop_id directamente; si la columna aún no existe, hacemos fallback por usuarios del taller

  const fetchData = async () => {
    if (!id) return;
    setLoading(true);
    setError(null);

    // Obtener nombre del taller
    const wsRes = await supabase
      .from("workshops")
      .select("id,name")
      .eq("id", id)
      .single();
    if (wsRes.data && typeof wsRes.data.name === "string") {
      setWorkshopName(wsRes.data.name);
    }

    // 1) Intento directo: filtrar por workshop_id en analysis
    const directQuery = (supabase as any)
      .from("analysis")
      .select(SELECT_COLUMNS as any, { count: "exact" })
      .eq("workshop_id", id)
      .order("analysis_date", { ascending: false })
      .range(page * PAGE_SIZE, page * PAGE_SIZE + PAGE_SIZE - 1);

    const directRes = await directQuery;
    if (!directRes.error) {
      setRows((directRes.data ?? []) as AnalysisRow[]);
      setTotal(directRes.count ?? 0);
      setLoading(false);
      return;
    }

    // 2) Fallback: si todavía no existe la columna workshop_id, resolves por usuarios del taller
    const { data: users, error: usersErr } = await supabase
      .from("profiles")
      .select("id")
      .eq("workshop_id", id);
    if (usersErr) {
      console.error("Error cargando usuarios del taller:", usersErr);
      setError(usersErr.message);
      setRows([]);
      setTotal(0);
      setLoading(false);
      return;
    }
    const userIds = (users ?? []).map((u: { id: string }) => u.id).filter(Boolean);
    if (userIds.length === 0) {
      setRows([]);
      setTotal(0);
      setLoading(false);
      return;
    }

    const query = (supabase as any)
      .from("analysis")
      .select(SELECT_COLUMNS as any, { count: "exact" })
      .in("user_id", userIds)
      .order("analysis_date", { ascending: false })
      .range(page * PAGE_SIZE, page * PAGE_SIZE + PAGE_SIZE - 1);

    const { data, count, error } = await query;
    if (error) {
      console.error("Error cargando análisis del taller:", error);
      setError(error.message);
      setRows([]);
      setTotal(0);
    } else {
      setRows((data ?? []) as AnalysisRow[]);
      setTotal(count ?? 0);
    }
    setLoading(false);
  };

  useEffect(() => {
    fetchData();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [id, page]);

  const totalPages = Math.ceil(total / PAGE_SIZE) || 0;

  const summary = useMemo(() => {
    if (!rows.length) return { avgMargin: 0, avgPercent: 0 };
    let sumM = 0;
    let sumPerc = 0;
    let count = 0;
    for (const r of rows) {
      const inc = income(r);
      const ct = sumCost(r);
      const m = inc - ct;
      const perc = inc > 0 ? (m / inc) * 100 : 0;
      sumM += m;
      sumPerc += perc;
      count++;
    }
    return {
      avgMargin: Math.round(sumM / count),
      avgPercent: Math.round((sumPerc / count) * 100) / 100,
    };
  }, [rows]);

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div className="flex items-center space-x-3">
          <Building2 className="h-6 w-6 text-primary" />
          <h2 className="text-xl font-semibold">{workshopName}</h2>
        </div>
        <div className="text-sm text-muted-foreground">
          Media margen: <span className="font-medium">€{summary.avgMargin}</span> · Media %: <span className="font-medium">{summary.avgPercent}%</span>
        </div>
      </div>

      <Card>
        <CardHeader className="space-y-3">
          <CardTitle className="text-lg">Análisis del taller</CardTitle>
          <div className="flex items-center gap-3">
            <Link to="/admin/workshops">
              <Button variant="outline" size="sm" className="inline-flex items-center">
                <ArrowLeft className="h-4 w-4 mr-2" /> Volver a talleres
              </Button>
            </Link>
            {loading && <Loader2 className="h-4 w-4 animate-spin text-muted-foreground" />}
            <div className="text-sm text-muted-foreground">{total} resultados</div>
          </div>
        </CardHeader>
        <CardContent>
          {error && (
            <div className="mb-4 flex items-center rounded-md border border-destructive/50 bg-destructive/10 px-3 py-2 text-destructive">
              <AlertCircle className="mr-2 h-4 w-4" />
              <span>Error al cargar análisis: {error}</span>
            </div>
          )}

          <div className="rounded-md border">
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Fecha</TableHead>
                  <TableHead>Estado</TableHead>
                  <TableHead>Ingresos</TableHead>
                  <TableHead>Costes</TableHead>
                  <TableHead>Margen</TableHead>
                  <TableHead>%</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {loading ? (
                  Array.from({ length: 6 }).map((_, i) => (
                    <TableRow key={i}>
                      <TableCell colSpan={6}>
                        <div className="h-6 w-full bg-muted animate-pulse rounded" />
                      </TableCell>
                    </TableRow>
                  ))
                ) : rows.length === 0 ? (
                  <TableRow>
                    <TableCell colSpan={6} className="text-center text-muted-foreground">
                      No hay análisis de este taller.
                    </TableCell>
                  </TableRow>
                ) : (
                  rows.map((r) => {
                    const inc = income(r);
                    const ct = sumCost(r);
                    const m = inc - ct;
                    const perc = inc > 0 ? Math.round(((m / inc) * 100) * 100) / 100 : 0;
                    return (
                      <TableRow key={r.id}>
                        <TableCell>{new Date(r.analysis_date).toLocaleDateString()}</TableCell>
                        <TableCell>{r.status}</TableCell>
                        <TableCell>€{Math.round(inc)}</TableCell>
                        <TableCell>€{Math.round(ct)}</TableCell>
                        <TableCell className={m >= 0 ? "text-green-600" : "text-red-600"}>€{Math.round(m)}</TableCell>
                        <TableCell className={m >= 0 ? "text-green-600" : "text-red-600"}>{perc}%</TableCell>
                      </TableRow>
                    );
                  })
                )}
              </TableBody>
            </Table>
          </div>

          <div className="mt-4 flex items-center justify-between">
            <div className="text-sm text-muted-foreground">Página {totalPages === 0 ? 0 : page + 1} de {totalPages}</div>
            <div className="flex items-center gap-2">
              <Button variant="outline" disabled={loading || page === 0} onClick={() => setPage((p) => Math.max(0, p - 1))}>Anterior</Button>
              <Button variant="outline" disabled={loading || page + 1 >= totalPages} onClick={() => setPage((p) => p + 1)}>Siguiente</Button>
            </div>
          </div>
        </CardContent>
      </Card>

    </div>
  );
};

export default AdminWorkshopAnalyses;