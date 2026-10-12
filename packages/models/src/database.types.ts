export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.5"
  }
  public: {
    Tables: {
      article_reader: {
        Row: {
          article_id: string
          created_at: string
          id: string
          ip: string
        }
        Insert: {
          article_id: string
          created_at?: string
          id?: string
          ip: string
        }
        Update: {
          article_id?: string
          created_at?: string
          id?: string
          ip?: string
        }
        Relationships: [
          {
            foreignKeyName: "article_reader_article_id_fkey"
            columns: ["article_id"]
            isOneToOne: false
            referencedRelation: "articles"
            referencedColumns: ["id"]
          },
        ]
      }
      article_tag: {
        Row: {
          article_id: string
          last_upload: string | null
          tag_id: string
          tenant_id: string
        }
        Insert: {
          article_id?: string
          last_upload?: string | null
          tag_id?: string
          tenant_id?: string
        }
        Update: {
          article_id?: string
          last_upload?: string | null
          tag_id?: string
          tenant_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "article_tag_article_id_fkey"
            columns: ["article_id"]
            isOneToOne: false
            referencedRelation: "articles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "article_tag_tag_id_fkey"
            columns: ["tag_id"]
            isOneToOne: false
            referencedRelation: "tags"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "article_tag_tenant_id_fkey"
            columns: ["tenant_id"]
            isOneToOne: false
            referencedRelation: "tenants"
            referencedColumns: ["id"]
          },
        ]
      }
      articles: {
        Row: {
          author: string | null
          content: string
          cover: string | null
          created_at: string | null
          deleted_at: string | null
          id: string
          is_published: boolean
          slug: string
          tenant_id: string
          title: string
          update_at: string | null
        }
        Insert: {
          author?: string | null
          content: string
          cover?: string | null
          created_at?: string | null
          deleted_at?: string | null
          id?: string
          is_published?: boolean
          slug: string
          tenant_id?: string
          title: string
          update_at?: string | null
        }
        Update: {
          author?: string | null
          content?: string
          cover?: string | null
          created_at?: string | null
          deleted_at?: string | null
          id?: string
          is_published?: boolean
          slug?: string
          tenant_id?: string
          title?: string
          update_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "articles_tenant_id_fkey"
            columns: ["tenant_id"]
            isOneToOne: false
            referencedRelation: "tenants"
            referencedColumns: ["id"]
          },
        ]
      }
      discount_tag: {
        Row: {
          discount_id: string
          tag_id: string
          tenant_id: string
        }
        Insert: {
          discount_id: string
          tag_id: string
          tenant_id: string
        }
        Update: {
          discount_id?: string
          tag_id?: string
          tenant_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "discount_tag_discount_id_fkey"
            columns: ["discount_id"]
            isOneToOne: false
            referencedRelation: "discounts"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "discount_tag_tag_id_fkey"
            columns: ["tag_id"]
            isOneToOne: false
            referencedRelation: "tags"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "discount_tag_tenant_id_fkey"
            columns: ["tenant_id"]
            isOneToOne: false
            referencedRelation: "tenants"
            referencedColumns: ["id"]
          },
        ]
      }
      discounts: {
        Row: {
          created_at: string | null
          deleted_at: string | null
          end_at: string | null
          id: string
          max_discount: number | null
          min_purchase: number | null
          percent: number | null
          start_at: string | null
          tenant_id: string
          title: string | null
          update_at: string | null
        }
        Insert: {
          created_at?: string | null
          deleted_at?: string | null
          end_at?: string | null
          id?: string
          max_discount?: number | null
          min_purchase?: number | null
          percent?: number | null
          start_at?: string | null
          tenant_id: string
          title?: string | null
          update_at?: string | null
        }
        Update: {
          created_at?: string | null
          deleted_at?: string | null
          end_at?: string | null
          id?: string
          max_discount?: number | null
          min_purchase?: number | null
          percent?: number | null
          start_at?: string | null
          tenant_id?: string
          title?: string | null
          update_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "discounts_tenant_id_fkey"
            columns: ["tenant_id"]
            isOneToOne: false
            referencedRelation: "tenants"
            referencedColumns: ["id"]
          },
        ]
      }
      invoice_items: {
        Row: {
          discount: number
          id: string
          invoice_id: string
          line_total: number
          name_snapshot: string
          product_variant_id: string
          quantity: number
          tax_amount: number
          tenant_id: string
          unit_price: number
        }
        Insert: {
          discount?: number
          id?: string
          invoice_id: string
          line_total: number
          name_snapshot: string
          product_variant_id: string
          quantity: number
          tax_amount?: number
          tenant_id: string
          unit_price: number
        }
        Update: {
          discount?: number
          id?: string
          invoice_id?: string
          line_total?: number
          name_snapshot?: string
          product_variant_id?: string
          quantity?: number
          tax_amount?: number
          tenant_id?: string
          unit_price?: number
        }
        Relationships: [
          {
            foreignKeyName: "invoice_items_invoice_id_fkey"
            columns: ["invoice_id"]
            isOneToOne: false
            referencedRelation: "invoices"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "invoice_items_product_variant_id_fkey"
            columns: ["product_variant_id"]
            isOneToOne: false
            referencedRelation: "product_variants"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "invoice_items_tenant_id_fkey"
            columns: ["tenant_id"]
            isOneToOne: false
            referencedRelation: "tenants"
            referencedColumns: ["id"]
          },
        ]
      }
      invoices: {
        Row: {
          created_at: string | null
          discount_total: number
          grand_total: number
          id: string
          invoice_no: string
          issued_at: string | null
          location_id: string
          member_id: string | null
          paid_total: number
          status: Database["public"]["Enums"]["invoice_status"]
          subtotal: number
          tax_total: number
          tenant_id: string
          updated_at: string | null
          void_reason: string | null
          voided_at: string | null
        }
        Insert: {
          created_at?: string | null
          discount_total?: number
          grand_total?: number
          id?: string
          invoice_no: string
          issued_at?: string | null
          location_id: string
          member_id?: string | null
          paid_total?: number
          status?: Database["public"]["Enums"]["invoice_status"]
          subtotal?: number
          tax_total?: number
          tenant_id: string
          updated_at?: string | null
          void_reason?: string | null
          voided_at?: string | null
        }
        Update: {
          created_at?: string | null
          discount_total?: number
          grand_total?: number
          id?: string
          invoice_no?: string
          issued_at?: string | null
          location_id?: string
          member_id?: string | null
          paid_total?: number
          status?: Database["public"]["Enums"]["invoice_status"]
          subtotal?: number
          tax_total?: number
          tenant_id?: string
          updated_at?: string | null
          void_reason?: string | null
          voided_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "invoices_location_id_fkey"
            columns: ["location_id"]
            isOneToOne: false
            referencedRelation: "locations"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "invoices_member_id_fkey"
            columns: ["member_id"]
            isOneToOne: false
            referencedRelation: "members"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "invoices_tenant_id_fkey"
            columns: ["tenant_id"]
            isOneToOne: false
            referencedRelation: "tenants"
            referencedColumns: ["id"]
          },
        ]
      }
      locations: {
        Row: {
          address: string | null
          code: string
          created_at: string | null
          deleted_at: string | null
          id: string
          is_active: boolean
          name: string
          tenant_id: string
          updated_at: string | null
        }
        Insert: {
          address?: string | null
          code: string
          created_at?: string | null
          deleted_at?: string | null
          id?: string
          is_active?: boolean
          name: string
          tenant_id: string
          updated_at?: string | null
        }
        Update: {
          address?: string | null
          code?: string
          created_at?: string | null
          deleted_at?: string | null
          id?: string
          is_active?: boolean
          name?: string
          tenant_id?: string
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "locations_tenant_id_fkey"
            columns: ["tenant_id"]
            isOneToOne: false
            referencedRelation: "tenants"
            referencedColumns: ["id"]
          },
        ]
      }
      members: {
        Row: {
          created_at: string | null
          deleted_at: string | null
          email: string
          gender: number | null
          id: string
          role: Database["public"]["Enums"]["role_types"]
          tenant_id: string
          updated_at: string | null
        }
        Insert: {
          created_at?: string | null
          deleted_at?: string | null
          email: string
          gender?: number | null
          id?: string
          role: Database["public"]["Enums"]["role_types"]
          tenant_id?: string
          updated_at?: string | null
        }
        Update: {
          created_at?: string | null
          deleted_at?: string | null
          email?: string
          gender?: number | null
          id?: string
          role?: Database["public"]["Enums"]["role_types"]
          tenant_id?: string
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "member_tenant_id_fkey"
            columns: ["tenant_id"]
            isOneToOne: false
            referencedRelation: "tenants"
            referencedColumns: ["id"]
          },
        ]
      }
      photos: {
        Row: {
          created_at: string | null
          deleted_at: string | null
          description: string | null
          id: string
          src: string
          tenant_id: string
          title: string | null
          updated_at: string | null
        }
        Insert: {
          created_at?: string | null
          deleted_at?: string | null
          description?: string | null
          id?: string
          src: string
          tenant_id?: string
          title?: string | null
          updated_at?: string | null
        }
        Update: {
          created_at?: string | null
          deleted_at?: string | null
          description?: string | null
          id?: string
          src?: string
          tenant_id?: string
          title?: string | null
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "photos_tenant_id_fkey"
            columns: ["tenant_id"]
            isOneToOne: false
            referencedRelation: "tenants"
            referencedColumns: ["id"]
          },
        ]
      }
      product_dicsount: {
        Row: {
          created_at: string | null
          deleted_at: string | null
          discount_id: string
          product_id: string
          tenant_id: string
          updated_at: string | null
        }
        Insert: {
          created_at?: string | null
          deleted_at?: string | null
          discount_id?: string
          product_id?: string
          tenant_id?: string
          updated_at?: string | null
        }
        Update: {
          created_at?: string | null
          deleted_at?: string | null
          discount_id?: string
          product_id?: string
          tenant_id?: string
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "product_dicsount_discount_id_fkey"
            columns: ["discount_id"]
            isOneToOne: false
            referencedRelation: "discounts"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "product_dicsount_tenant_id_fkey"
            columns: ["tenant_id"]
            isOneToOne: false
            referencedRelation: "tenants"
            referencedColumns: ["id"]
          },
        ]
      }
      product_tag: {
        Row: {
          product_id: string
          tag_id: string
          tenant_id: string
        }
        Insert: {
          product_id: string
          tag_id: string
          tenant_id: string
        }
        Update: {
          product_id?: string
          tag_id?: string
          tenant_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "product_tags_product_id_fkey"
            columns: ["product_id"]
            isOneToOne: false
            referencedRelation: "products"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "product_tags_tag_id_fkey"
            columns: ["tag_id"]
            isOneToOne: false
            referencedRelation: "tags"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "product_tags_tenant_id_fkey"
            columns: ["tenant_id"]
            isOneToOne: false
            referencedRelation: "tenants"
            referencedColumns: ["id"]
          },
        ]
      }
      product_variants: {
        Row: {
          barcode: string | null
          cost: number
          created_at: string | null
          deleted_at: string | null
          id: string
          is_active: boolean
          name: string | null
          price: number
          product_id: string
          sku: string
          tenant_id: string
          updated_at: string | null
        }
        Insert: {
          barcode?: string | null
          cost?: number
          created_at?: string | null
          deleted_at?: string | null
          id?: string
          is_active?: boolean
          name?: string | null
          price?: number
          product_id: string
          sku: string
          tenant_id: string
          updated_at?: string | null
        }
        Update: {
          barcode?: string | null
          cost?: number
          created_at?: string | null
          deleted_at?: string | null
          id?: string
          is_active?: boolean
          name?: string | null
          price?: number
          product_id?: string
          sku?: string
          tenant_id?: string
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "product_variants_product_id_fkey"
            columns: ["product_id"]
            isOneToOne: false
            referencedRelation: "products"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "product_variants_tenant_id_fkey"
            columns: ["tenant_id"]
            isOneToOne: false
            referencedRelation: "tenants"
            referencedColumns: ["id"]
          },
        ]
      }
      products: {
        Row: {
          created_at: string | null
          deleted_at: string | null
          description: string
          id: string
          img: string
          price: number
          stock: number
          tenant_id: string
          title: string
          updated_at: string | null
        }
        Insert: {
          created_at?: string | null
          deleted_at?: string | null
          description: string
          id?: string
          img: string
          price: number
          stock?: number
          tenant_id: string
          title: string
          updated_at?: string | null
        }
        Update: {
          created_at?: string | null
          deleted_at?: string | null
          description?: string
          id?: string
          img?: string
          price?: number
          stock?: number
          tenant_id?: string
          title?: string
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "products_tenant_id_fkey"
            columns: ["tenant_id"]
            isOneToOne: false
            referencedRelation: "tenants"
            referencedColumns: ["id"]
          },
        ]
      }
      stock_balances: {
        Row: {
          avg_cost: number
          id: string
          location_id: string
          product_variant_id: string
          quantity: number
          tenant_id: string
          updated_at: string | null
        }
        Insert: {
          avg_cost?: number
          id?: string
          location_id: string
          product_variant_id: string
          quantity?: number
          tenant_id: string
          updated_at?: string | null
        }
        Update: {
          avg_cost?: number
          id?: string
          location_id?: string
          product_variant_id?: string
          quantity?: number
          tenant_id?: string
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "stock_balances_location_id_fkey"
            columns: ["location_id"]
            isOneToOne: false
            referencedRelation: "locations"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "stock_balances_product_variant_id_fkey"
            columns: ["product_variant_id"]
            isOneToOne: false
            referencedRelation: "product_variants"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "stock_balances_tenant_id_fkey"
            columns: ["tenant_id"]
            isOneToOne: false
            referencedRelation: "tenants"
            referencedColumns: ["id"]
          },
        ]
      }
      stock_movements: {
        Row: {
          balance_after: number
          created_at: string | null
          created_by: string
          id: string
          location_id: string
          notes: string | null
          product_variant_id: string
          quantity: number
          ref_id: string | null
          ref_table: string | null
          tenant_id: string
          type: Database["public"]["Enums"]["stock_movement_types"]
          unit_cost: number
        }
        Insert: {
          balance_after: number
          created_at?: string | null
          created_by: string
          id?: string
          location_id: string
          notes?: string | null
          product_variant_id: string
          quantity: number
          ref_id?: string | null
          ref_table?: string | null
          tenant_id: string
          type: Database["public"]["Enums"]["stock_movement_types"]
          unit_cost?: number
        }
        Update: {
          balance_after?: number
          created_at?: string | null
          created_by?: string
          id?: string
          location_id?: string
          notes?: string | null
          product_variant_id?: string
          quantity?: number
          ref_id?: string | null
          ref_table?: string | null
          tenant_id?: string
          type?: Database["public"]["Enums"]["stock_movement_types"]
          unit_cost?: number
        }
        Relationships: [
          {
            foreignKeyName: "stock_movements_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "members"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "stock_movements_location_id_fkey"
            columns: ["location_id"]
            isOneToOne: false
            referencedRelation: "locations"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "stock_movements_product_variant_id_fkey"
            columns: ["product_variant_id"]
            isOneToOne: false
            referencedRelation: "product_variants"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "stock_movements_tenant_id_fkey"
            columns: ["tenant_id"]
            isOneToOne: false
            referencedRelation: "tenants"
            referencedColumns: ["id"]
          },
        ]
      }
      tags: {
        Row: {
          id: string
          tenant_id: string
          title: string
          type: Database["public"]["Enums"]["tag_types"]
        }
        Insert: {
          id?: string
          tenant_id?: string
          title: string
          type: Database["public"]["Enums"]["tag_types"]
        }
        Update: {
          id?: string
          tenant_id?: string
          title?: string
          type?: Database["public"]["Enums"]["tag_types"]
        }
        Relationships: [
          {
            foreignKeyName: "tags_tenant_id_fkey"
            columns: ["tenant_id"]
            isOneToOne: false
            referencedRelation: "tenants"
            referencedColumns: ["id"]
          },
        ]
      }
      tenants: {
        Row: {
          created_at: string | null
          deleted_at: string | null
          id: string
          slug: string | null
          title: string
          update_at: string | null
        }
        Insert: {
          created_at?: string | null
          deleted_at?: string | null
          id?: string
          slug?: string | null
          title: string
          update_at?: string | null
        }
        Update: {
          created_at?: string | null
          deleted_at?: string | null
          id?: string
          slug?: string | null
          title?: string
          update_at?: string | null
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      invoice_status: "DRAFT" | "UNPAID" | "PARTIAL" | "PAID" | "VOID"
      role_types: "ADMIN" | "EMPLOYEE" | "CUSTOMER"
      stock_movement_types:
        | "PURCHASE"
        | "SALE"
        | "RETURN"
        | "ADJUSTMENT"
        | "TRANSFER_IN"
        | "TRANSFER_OUT"
      tag_types: "ARTICLE" | "DISCOUNT" | "PRODUCT"
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
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never) = never,
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
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never) = never,
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
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never) = never,
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
  EnumName extends (DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never) = never,
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
  CompositeTypeName extends (PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never) = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {
      invoice_status: ["DRAFT", "UNPAID", "PARTIAL", "PAID", "VOID"],
      role_types: ["ADMIN", "EMPLOYEE", "CUSTOMER"],
      stock_movement_types: [
        "PURCHASE",
        "SALE",
        "RETURN",
        "ADJUSTMENT",
        "TRANSFER_IN",
        "TRANSFER_OUT",
      ],
      tag_types: ["ARTICLE", "DISCOUNT", "PRODUCT"],
    },
  },
} as const
