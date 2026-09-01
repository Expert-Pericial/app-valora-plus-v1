export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  graphql_public: {
    Tables: {
      [_ in never]: never
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      graphql: {
        Args: {
          extensions?: Json
          operationName?: string
          query?: string
          variables?: Json
        }
        Returns: Json
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  public: {
    Tables: {
      analysis: {
        Row: {
          analysis_date: string
          created_at: string | null
          error_message: string | null
          id: string
          pdf_filename: string | null
          pdf_url: string | null
          status: string
          updated_at: string | null
          user_id: string
          workshop_id: string | null
          valuation_date: string | null
        }
        Insert: {
          analysis_date?: string
          created_at?: string | null
          error_message?: string | null
          id?: string
          pdf_filename?: string | null
          pdf_url?: string | null
          status?: string
          updated_at?: string | null
          user_id: string
          workshop_id?: string | null
          valuation_date?: string | null
        }
        Update: {
          analysis_date?: string
          created_at?: string | null
          error_message?: string | null
          id?: string
          pdf_filename?: string | null
          pdf_url?: string | null
          status?: string
          updated_at?: string | null
          user_id?: string
          workshop_id?: string | null
          valuation_date?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "analysis_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "analysis_workshop_id_fkey"
            columns: ["workshop_id"]
            isOneToOne: false
            referencedRelation: "workshops"
            referencedColumns: ["id"]
          },
        ]
      }
      insurance_amounts: {
        Row: {
          analysis_id: string
          bodywork_labor_eur: number | null
          bodywork_labor_ut: number | null
          created_at: string | null
          id: string
          iva_amount: number | null
          iva_percentage: number | null
          net_subtotal: number | null
          paint_material_eur: number | null
          painting_labor_eur: number | null
          painting_labor_ut: number | null
          total_spare_parts_eur: number | null
          total_with_iva: number | null
          updated_at: string | null
        }
        Insert: {
          analysis_id: string
          bodywork_labor_eur?: number | null
          bodywork_labor_ut?: number | null
          created_at?: string | null
          id?: string
          iva_amount?: number | null
          iva_percentage?: number | null
          net_subtotal?: number | null
          paint_material_eur?: number | null
          painting_labor_eur?: number | null
          painting_labor_ut?: number | null
          total_spare_parts_eur?: number | null
          total_with_iva?: number | null
          updated_at?: string | null
        }
        Update: {
          analysis_id?: string
          bodywork_labor_eur?: number | null
          bodywork_labor_ut?: number | null
          created_at?: string | null
          id?: string
          iva_amount?: number | null
          iva_percentage?: number | null
          net_subtotal?: number | null
          paint_material_eur?: number | null
          painting_labor_eur?: number | null
          painting_labor_ut?: number | null
          total_spare_parts_eur?: number | null
          total_with_iva?: number | null
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "insurance_amounts_analysis_id_fkey"
            columns: ["analysis_id"]
            isOneToOne: false
            referencedRelation: "analysis"
            referencedColumns: ["id"]
          },
        ]
      }
      profiles: {
        Row: {
          created_at: string
          email: string
          full_name: string | null
          id: string
          phone: string | null
          role: string
          updated_at: string
          workshop_id: string | null
        }
        Insert: {
          created_at?: string
          email: string
          full_name?: string | null
          id: string
          phone?: string | null
          role: string
          updated_at?: string
          workshop_id?: string | null
        }
        Update: {
          created_at?: string
          email?: string
          full_name?: string | null
          id?: string
          phone?: string | null
          role?: string
          updated_at?: string
          workshop_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "profiles_workshop_id_fkey"
            columns: ["workshop_id"]
            isOneToOne: false
            referencedRelation: "workshops"
            referencedColumns: ["id"]
          },
        ]
      }
      vehicle_data: {
        Row: {
          analysis_id: string
          created_at: string | null
          hourly_price: number | null
          id: string
          internal_reference: string | null
          license_plate: string | null
          manufacturer: string | null
          model: string | null
          system: string | null
          updated_at: string | null
          vin: string | null
        }
        Insert: {
          analysis_id: string
          created_at?: string | null
          hourly_price?: number | null
          id?: string
          internal_reference?: string | null
          license_plate?: string | null
          manufacturer?: string | null
          model?: string | null
          system?: string | null
          updated_at?: string | null
          vin?: string | null
        }
        Update: {
          analysis_id?: string
          created_at?: string | null
          hourly_price?: number | null
          id?: string
          internal_reference?: string | null
          license_plate?: string | null
          manufacturer?: string | null
          model?: string | null
          system?: string | null
          updated_at?: string | null
          vin?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "vehicle_data_analysis_id_fkey"
            columns: ["analysis_id"]
            isOneToOne: false
            referencedRelation: "analysis"
            referencedColumns: ["id"]
          },
        ]
      }
      workshop_costs: {
        Row: {
          analysis_id: string
          bodywork_actual_hours: number | null
          bodywork_hourly_cost: number | null
          created_at: string | null
          id: string
          notes: string | null
          other_costs: number | null
          painting_actual_hours: number | null
          painting_consumables_cost: number | null
          painting_hourly_cost: number | null
          spare_parts_purchase_cost: number | null
          subcontractor_costs: number | null
          updated_at: string | null
        }
        Insert: {
          analysis_id: string
          bodywork_actual_hours?: number | null
          bodywork_hourly_cost?: number | null
          created_at?: string | null
          id?: string
          notes?: string | null
          other_costs?: number | null
          painting_actual_hours?: number | null
          painting_consumables_cost?: number | null
          painting_hourly_cost?: number | null
          spare_parts_purchase_cost?: number | null
          subcontractor_costs?: number | null
          updated_at?: string | null
        }
        Update: {
          analysis_id?: string
          bodywork_actual_hours?: number | null
          bodywork_hourly_cost?: number | null
          created_at?: string | null
          id?: string
          notes?: string | null
          other_costs?: number | null
          painting_actual_hours?: number | null
          painting_consumables_cost?: number | null
          painting_hourly_cost?: number | null
          spare_parts_purchase_cost?: number | null
          subcontractor_costs?: number | null
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "workshop_costs_analysis_id_fkey"
            columns: ["analysis_id"]
            isOneToOne: false
            referencedRelation: "analysis"
            referencedColumns: ["id"]
          },
        ]
      }
      workshops: {
        Row: {
          address: string | null
          created_at: string
          email: string | null
          id: string
          name: string
          phone: string | null
          updated_at: string
        }
        Insert: {
          address?: string | null
          created_at?: string
          email?: string | null
          id?: string
          name: string
          phone?: string | null
          updated_at?: string
        }
        Update: {
          address?: string | null
          created_at?: string
          email?: string | null
          id?: string
          name?: string
          phone?: string | null
          updated_at?: string
        }
        Relationships: []
      }
      system_settings: {
        Row: {
          id: string
          setting_key: string
          setting_value: Json
          description: string | null
          created_at: string
          updated_at: string
          updated_by: string | null
        }
        Insert: {
          id?: string
          setting_key: string
          setting_value: Json
          description?: string | null
          created_at?: string
          updated_at?: string
          updated_by?: string | null
        }
        Update: {
          id?: string
          setting_key?: string
          setting_value?: Json
          description?: string | null
          created_at?: string
          updated_at?: string
          updated_by?: string | null
        }
        Relationships: []
      }
      user_monthly_usage: {
        Row: {
          id: string
          user_id: string
          year: number
          month: number
          analyses_count: number
          free_analyses_used: number
          paid_analyses_count: number
          total_amount_due: number
          payment_status: string
          stripe_payment_intent_id: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          user_id: string
          year: number
          month: number
          analyses_count?: number
          free_analyses_used?: number
          paid_analyses_count?: number
          total_amount_due?: number
          payment_status?: string
          stripe_payment_intent_id?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          year?: number
          month?: number
          analyses_count?: number
          free_analyses_used?: number
          paid_analyses_count?: number
          total_amount_due?: number
          payment_status?: string
          stripe_payment_intent_id?: string | null
          created_at?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "user_monthly_usage_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          }
        ]
      }
      payments: {
        Row: {
          id: string
          workshop_id: string
          user_id: string
          stripe_payment_intent_id: string | null
          stripe_session_id: string | null
          stripe_customer_id: string | null
          amount_cents: number
          currency: string
          status: string
          analysis_month: string
          analyses_purchased: number
          unit_price_cents: number
          payment_method: string | null
          stripe_fee_cents: number | null
          net_amount_cents: number | null
          description: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          workshop_id: string
          user_id: string
          stripe_payment_intent_id?: string | null
          stripe_session_id?: string | null
          stripe_customer_id?: string | null
          amount_cents: number
          currency?: string
          status?: string
          analysis_month: string
          analyses_purchased?: number
          unit_price_cents?: number
          payment_method?: string | null
          stripe_fee_cents?: number | null
          net_amount_cents?: number | null
          description?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          workshop_id?: string
          user_id?: string
          stripe_payment_intent_id?: string | null
          stripe_session_id?: string | null
          stripe_customer_id?: string | null
          amount_cents?: number
          currency?: string
          status?: string
          analysis_month?: string
          analyses_purchased?: number
          unit_price_cents?: number
          payment_method?: string | null
          stripe_fee_cents?: number | null
          net_amount_cents?: number | null
          description?: string | null
          created_at?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "payments_workshop_id_fkey"
            columns: ["workshop_id"]
            isOneToOne: false
            referencedRelation: "workshops"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "payments_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          }
        ]
      }
      analysis_packages: {
        Row: {
          id: string
          name: string
          description: string | null
          analyses_count: number
          price_per_analysis: number
          total_price: number
          discount_percentage: number
          is_active: boolean
          sort_order: number
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          name: string
          description?: string | null
          analyses_count: number
          price_per_analysis: number
          total_price: number
          discount_percentage?: number
          is_active?: boolean
          sort_order?: number
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          name?: string
          description?: string | null
          analyses_count?: number
          price_per_analysis?: number
          total_price?: number
          discount_percentage?: number
          is_active?: boolean
          sort_order?: number
          created_at?: string
          updated_at?: string
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      complete_user_registration: {
        Args: { user_id: string; user_phone?: string; workshop_id: string }
        Returns: undefined
      }
      handle_workshop_registration: {
        Args: {
          workshop_email: string
          workshop_name: string
          workshop_phone?: string
        }
        Returns: string
      }
      is_admin_user: {
        Args: Record<PropertyKey, never>
        Returns: boolean
      }
      get_system_setting: {
        Args: { setting_name: string }
        Returns: Json
      }
      update_system_setting: {
        Args: { setting_name: string; new_value: Json }
        Returns: undefined
      }
      get_or_create_monthly_usage: {
        Args: { year?: number; month?: number }
        Returns: Json
      }
      get_current_monthly_usage: {
        Args: Record<PropertyKey, never>
        Returns: Json
      }
      create_payment_record: {
        Args: {
          p_workshop_id: string
          p_stripe_payment_intent_id?: string
          p_stripe_session_id?: string
          p_amount_cents: number
          p_currency?: string
          p_analysis_month: string
          p_description?: string
        }
        Returns: string
      }
      update_payment_status: {
        Args: {
          p_stripe_session_id: string
          p_status: string
          p_stripe_payment_intent_id?: string
          p_payment_method?: string
          p_stripe_fee_cents?: number
        }
        Returns: undefined
      }
      get_workshop_payment_history: {
        Args: {
          p_workshop_id: string
          p_limit?: number
          p_offset?: number
        }
        Returns: Json
      }
      get_payment_statistics: {
        Args: {
          p_start_date?: string
          p_end_date?: string
        }
        Returns: Json
      }
      get_active_packages: {
        Args: Record<PropertyKey, never>
        Returns: Json
      }
      get_package_by_id: {
        Args: { package_id: string }
        Returns: Json
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  graphql_public: {
    Enums: {},
  },
  public: {
    Enums: {},
  },
} as const
