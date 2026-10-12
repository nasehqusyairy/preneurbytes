SET local check_function_bodies = off;

CREATE TABLE "public"."article_reader" (
  "id"         uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "article_id" uuid                     NOT NULL,
  "ip"         text                     NOT NULL,
  "created_at" timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT "article_reader_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."article_reader"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."article_tag" (
  "article_id"  uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "tag_id"      uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "tenant_id"   uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "last_upload" timestamp with time zone,
  CONSTRAINT "article_tag_pkey" PRIMARY KEY (article_id, tag_id, tenant_id)
);

ALTER TABLE "public"."article_tag"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."articles" (
  "id"           uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "tenant_id"    uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "slug"         text                     NOT NULL,
  "title"        text                     NOT NULL,
  "author"       text,
  "cover"        text,
  "content"      text                     NOT NULL,
  "is_published" boolean                  NOT NULL DEFAULT false,
  "created_at"   timestamp with time zone,
  "update_at"    timestamp with time zone,
  "deleted_at"   timestamp with time zone,
  CONSTRAINT "articles_pkey" PRIMARY KEY (id),
  CONSTRAINT "articles_slug_key" UNIQUE (slug)
);

ALTER TABLE "public"."articles"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."discount_tag" (
  "tenant_id"   uuid NOT NULL,
  "discount_id" uuid NOT NULL,
  "tag_id"      uuid NOT NULL,
  CONSTRAINT "discount_tag_pkey" PRIMARY KEY (tenant_id, discount_id, tag_id)
);

ALTER TABLE "public"."discount_tag"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."discounts" (
  "id"           uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "tenant_id"    uuid                     NOT NULL,
  "title"        character varying,
  "percent"      numeric,
  "max_discount" numeric,
  "min_purchase" numeric,
  "start_at"     timestamp with time zone,
  "end_at"       timestamp with time zone,
  "created_at"   timestamp with time zone,
  "update_at"    timestamp with time zone,
  "deleted_at"   timestamp with time zone,
  CONSTRAINT "discounts_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."discounts"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."invoice_items" (
  "id"                 uuid    NOT NULL DEFAULT gen_random_uuid(),
  "tenant_id"          uuid    NOT NULL,
  "invoice_id"         uuid    NOT NULL,
  "product_variant_id" uuid    NOT NULL,
  "name_snapshot"      text    NOT NULL,
  "quantity"           numeric NOT NULL,
  "unit_price"         numeric NOT NULL,
  "discount"           numeric NOT NULL DEFAULT 0,
  "tax_amount"         numeric NOT NULL DEFAULT 0,
  "line_total"         numeric NOT NULL,
  CONSTRAINT "invoice_items_pkey" PRIMARY KEY (id),
  CONSTRAINT "invoice_items_quantity_check" CHECK ((quantity > (0)::numeric))
);

ALTER TABLE "public"."invoice_items"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."invoices" (
  "id"             uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "tenant_id"      uuid                     NOT NULL,
  "location_id"    uuid                     NOT NULL,
  "member_id"      uuid,
  "invoice_no"     text                     NOT NULL,
  "subtotal"       numeric                  NOT NULL DEFAULT 0,
  "discount_total" numeric                  NOT NULL DEFAULT 0,
  "tax_total"      numeric                  NOT NULL DEFAULT 0,
  "grand_total"    numeric                  NOT NULL DEFAULT 0,
  "paid_total"     numeric                  NOT NULL DEFAULT 0,
  "issued_at"      timestamp with time zone DEFAULT now(),
  "voided_at"      timestamp with time zone,
  "void_reason"    text,
  "created_at"     timestamp with time zone DEFAULT now(),
  "updated_at"     timestamp with time zone DEFAULT now(),
  CONSTRAINT "invoices_pkey" PRIMARY KEY (id),
  CONSTRAINT "invoices_tenant_id_invoice_no_key" UNIQUE (tenant_id, invoice_no)
);

ALTER TABLE "public"."invoices"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."locations" (
  "id"         uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "tenant_id"  uuid                     NOT NULL,
  "code"       text                     NOT NULL,
  "name"       text                     NOT NULL,
  "address"    text,
  "is_active"  boolean                  NOT NULL DEFAULT true,
  "created_at" timestamp with time zone DEFAULT now(),
  "updated_at" timestamp with time zone DEFAULT now(),
  "deleted_at" timestamp with time zone,
  CONSTRAINT "locations_pkey" PRIMARY KEY (id),
  CONSTRAINT "locations_tenant_id_code_key" UNIQUE (tenant_id, code)
);

ALTER TABLE "public"."locations"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."members" (
  "id"         uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "email"      text                     NOT NULL,
  "created_at" timestamp with time zone DEFAULT now(),
  "updated_at" timestamp with time zone DEFAULT now(),
  "gender"     smallint,
  "deleted_at" timestamp with time zone,
  "tenant_id"  uuid                     NOT NULL DEFAULT gen_random_uuid(),
  CONSTRAINT "member_email_key1" UNIQUE (email),
  CONSTRAINT "member_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."members"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."photos" (
  "id"          uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "tenant_id"   uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "src"         text                     NOT NULL,
  "title"       text                     DEFAULT 'Untitled'::text,
  "description" text,
  "created_at"  timestamp with time zone DEFAULT now(),
  "updated_at"  timestamp with time zone DEFAULT now(),
  "deleted_at"  timestamp with time zone,
  CONSTRAINT "photos_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."photos"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."product_dicsount" (
  "tenant_id"   uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "product_id"  uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "discount_id" uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "created_at"  timestamp with time zone DEFAULT now(),
  "updated_at"  timestamp with time zone DEFAULT now(),
  "deleted_at"  timestamp with time zone,
  CONSTRAINT "product_dicsount_pkey" PRIMARY KEY (tenant_id, product_id, discount_id)
);

ALTER TABLE "public"."product_dicsount"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."product_tag" (
  "product_id" uuid NOT NULL,
  "tag_id"     uuid NOT NULL,
  "tenant_id"  uuid NOT NULL,
  CONSTRAINT "product_tags_pkey" PRIMARY KEY (product_id, tag_id, tenant_id)
);

ALTER TABLE "public"."product_tag"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."product_variants" (
  "id"         uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "tenant_id"  uuid                     NOT NULL,
  "product_id" uuid                     NOT NULL,
  "sku"        text                     NOT NULL,
  "barcode"    text,
  "name"       text,
  "cost"       numeric                  NOT NULL DEFAULT 0,
  "price"      numeric                  NOT NULL DEFAULT 0,
  "is_active"  boolean                  NOT NULL DEFAULT true,
  "created_at" timestamp with time zone DEFAULT now(),
  "updated_at" timestamp with time zone DEFAULT now(),
  "deleted_at" timestamp with time zone,
  CONSTRAINT "product_variants_pkey" PRIMARY KEY (id),
  CONSTRAINT "product_variants_tenant_id_barcode_key" UNIQUE (tenant_id, barcode),
  CONSTRAINT "product_variants_tenant_id_sku_key" UNIQUE (tenant_id, sku)
);

ALTER TABLE "public"."product_variants"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."products" (
  "id"          uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "tenant_id"   uuid                     NOT NULL,
  "title"       character varying        NOT NULL,
  "description" text                     NOT NULL,
  "price"       numeric                  NOT NULL,
  "stock"       integer                  NOT NULL DEFAULT 0,
  "img"         text                     NOT NULL,
  "created_at"  timestamp with time zone DEFAULT now(),
  "updated_at"  timestamp with time zone DEFAULT now(),
  "deleted_at"  timestamp with time zone,
  CONSTRAINT "products_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."products"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."stock_balances" (
  "id"                 uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "tenant_id"          uuid                     NOT NULL,
  "location_id"        uuid                     NOT NULL,
  "product_variant_id" uuid                     NOT NULL,
  "quantity"           numeric                  NOT NULL DEFAULT 0,
  "avg_cost"           numeric                  NOT NULL DEFAULT 0,
  "updated_at"         timestamp with time zone DEFAULT now(),
  CONSTRAINT "stock_balances_location_id_product_variant_id_key" UNIQUE (location_id, product_variant_id),
  CONSTRAINT "stock_balances_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."stock_balances"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."stock_movements" (
  "id"                 uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "tenant_id"          uuid                     NOT NULL,
  "location_id"        uuid                     NOT NULL,
  "product_variant_id" uuid                     NOT NULL,
  "quantity"           numeric                  NOT NULL,
  "unit_cost"          numeric                  NOT NULL DEFAULT 0,
  "balance_after"      numeric                  NOT NULL,
  "ref_table"          text,
  "ref_id"             uuid,
  "notes"              text,
  "created_by"         uuid                     NOT NULL,
  "created_at"         timestamp with time zone DEFAULT now(),
  CONSTRAINT "stock_movements_pkey" PRIMARY KEY (id),
  CONSTRAINT "stock_movements_quantity_check" CHECK ((quantity <> (0)::numeric))
);

ALTER TABLE "public"."stock_movements"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."tags" (
  "id"        uuid NOT NULL DEFAULT gen_random_uuid(),
  "tenant_id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "title"     text NOT NULL,
  CONSTRAINT "tags_pkey" PRIMARY KEY (id)
);

ALTER TABLE "public"."tags"
  ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."tenants" (
  "id"         uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "title"      text                     NOT NULL,
  "slug"       text,
  "created_at" timestamp with time zone,
  "update_at"  timestamp with time zone,
  "deleted_at" timestamp with time zone,
  CONSTRAINT "tenants_pkey" PRIMARY KEY (id),
  CONSTRAINT "tenants_slug_key" UNIQUE (slug)
);

ALTER TABLE "public"."tenants"
  ENABLE ROW LEVEL SECURITY;

CREATE TYPE "public"."invoice_status" AS ENUM (
  'DRAFT',
  'UNPAID',
  'PARTIAL',
  'PAID',
  'VOID'
);

ALTER TABLE "public"."invoices"
  ADD COLUMN "status" public.invoice_status NOT NULL DEFAULT 'DRAFT'::public.invoice_status;

CREATE TYPE "public"."role_types" AS ENUM (
  'ADMIN',
  'EMPLOYEE',
  'CUSTOMER'
);

ALTER TABLE "public"."members"
  ADD COLUMN "role" public.role_types NOT NULL;

CREATE TYPE "public"."stock_movement_types" AS ENUM (
  'PURCHASE',
  'SALE',
  'RETURN',
  'ADJUSTMENT',
  'TRANSFER_IN',
  'TRANSFER_OUT'
);

ALTER TABLE "public"."stock_movements"
  ADD COLUMN "type" public.stock_movement_types NOT NULL;

CREATE TYPE "public"."tag_types" AS ENUM (
  'ARTICLE',
  'DISCOUNT',
  'PRODUCT'
);

ALTER TABLE "public"."tags"
  ADD COLUMN "type" public.tag_types NOT NULL;

CREATE OR REPLACE FUNCTION public.forbid_mutation()
  RETURNS TRIGGER
  LANGUAGE plpgsql
  AS $function$
BEGIN
  RAISE EXCEPTION 'Tabel % bersifat append-only: % tidak diizinkan', TG_TABLE_NAME, TG_OP
    USING ERRCODE = 'restrict_violation';
END
$function$;

ALTER TABLE "public"."article_reader"
  ADD CONSTRAINT "article_reader_article_id_fkey" FOREIGN KEY (article_id) REFERENCES public.articles(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "public"."article_tag"
  ADD CONSTRAINT "article_tag_article_id_fkey" FOREIGN KEY (article_id) REFERENCES public.articles(id);

ALTER TABLE "public"."discount_tag"
  ADD CONSTRAINT "discount_tag_discount_id_fkey" FOREIGN KEY (discount_id) REFERENCES public.discounts(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "public"."invoice_items"
  ADD CONSTRAINT "invoice_items_invoice_id_fkey" FOREIGN KEY (invoice_id) REFERENCES public.invoices(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "public"."invoices"
  ADD CONSTRAINT "invoices_location_id_fkey" FOREIGN KEY (location_id) REFERENCES public.locations(id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE "public"."members"
  ADD CONSTRAINT "member_email_key2" UNIQUE (email);

ALTER TABLE "public"."members"
  ADD CONSTRAINT "member_email_key" UNIQUE (email);

ALTER TABLE "public"."members"
  ADD CONSTRAINT "member_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "public"."invoices"
  ADD CONSTRAINT "invoices_member_id_fkey" FOREIGN KEY (member_id) REFERENCES public.members(id) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE "public"."product_dicsount"
  ADD CONSTRAINT "product_dicsount_discount_id_fkey" FOREIGN KEY (discount_id) REFERENCES public.discounts(id);

ALTER TABLE "public"."invoice_items"
  ADD CONSTRAINT "invoice_items_product_variant_id_fkey" FOREIGN KEY (product_variant_id) REFERENCES public.product_variants(id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE "public"."product_tag"
  ADD CONSTRAINT "product_tags_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public.products(id);

ALTER TABLE "public"."product_variants"
  ADD CONSTRAINT "product_variants_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "public"."stock_balances"
  ADD CONSTRAINT "stock_balances_location_id_fkey" FOREIGN KEY (location_id) REFERENCES public.locations(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "public"."stock_balances"
  ADD CONSTRAINT "stock_balances_product_variant_id_fkey" FOREIGN KEY (product_variant_id) REFERENCES public.product_variants(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "public"."stock_movements"
  ADD CONSTRAINT "stock_movements_created_by_fkey" FOREIGN KEY (created_by) REFERENCES public.members(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "public"."stock_movements"
  ADD CONSTRAINT "stock_movements_location_id_fkey" FOREIGN KEY (location_id) REFERENCES public.locations(id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE "public"."stock_movements"
  ADD CONSTRAINT "stock_movements_product_variant_id_fkey" FOREIGN KEY (product_variant_id) REFERENCES public.product_variants(id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE "public"."article_tag"
  ADD CONSTRAINT "article_tag_tag_id_fkey" FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "public"."discount_tag"
  ADD CONSTRAINT "discount_tag_tag_id_fkey" FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "public"."product_tag"
  ADD CONSTRAINT "product_tags_tag_id_fkey" FOREIGN KEY (tag_id) REFERENCES public.tags(id);

ALTER TABLE "public"."article_tag"
  ADD CONSTRAINT "article_tag_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);

ALTER TABLE "public"."articles"
  ADD CONSTRAINT "articles_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);

ALTER TABLE "public"."discount_tag"
  ADD CONSTRAINT "discount_tag_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "public"."discounts"
  ADD CONSTRAINT "discounts_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);

ALTER TABLE "public"."invoice_items"
  ADD CONSTRAINT "invoice_items_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "public"."invoices"
  ADD CONSTRAINT "invoices_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "public"."locations"
  ADD CONSTRAINT "locations_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "public"."members"
  ADD CONSTRAINT "member_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);

ALTER TABLE "public"."photos"
  ADD CONSTRAINT "photos_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);

ALTER TABLE "public"."product_dicsount"
  ADD CONSTRAINT "product_dicsount_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);

ALTER TABLE "public"."product_tag"
  ADD CONSTRAINT "product_tags_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);

ALTER TABLE "public"."product_variants"
  ADD CONSTRAINT "product_variants_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "public"."products"
  ADD CONSTRAINT "products_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);

ALTER TABLE "public"."stock_balances"
  ADD CONSTRAINT "stock_balances_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "public"."stock_movements"
  ADD CONSTRAINT "stock_movements_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "public"."tags"
  ADD CONSTRAINT "tags_tenant_id_fkey" FOREIGN KEY (tenant_id) REFERENCES public.tenants(id);

CREATE INDEX invoice_items_invoice_id_idx ON public.invoice_items USING btree (tenant_id, invoice_id);

CREATE INDEX invoices_tenant_id_issued_at_idx ON public.invoices USING btree (tenant_id, issued_at DESC);

CREATE INDEX stock_movements_item_idx ON public.stock_movements USING btree (tenant_id, product_variant_id, location_id, created_at);

CREATE TRIGGER stock_movements_forbid_mutation
  BEFORE DELETE OR UPDATE ON public.stock_movements
  FOR EACH ROW
  EXECUTE FUNCTION public.forbid_mutation();

COMMENT ON COLUMN "public"."articles"."content" IS 'file dokumen';

COMMENT ON COLUMN "public"."articles"."cover" IS 'file gambar';

GRANT EXECUTE ON FUNCTION "public"."forbid_mutation"() TO PUBLIC, "anon", "authenticated";

REVOKE ALL ON FUNCTION "public"."forbid_mutation"() FROM "postgres";

GRANT EXECUTE ON FUNCTION "public"."forbid_mutation"() TO "postgres";

GRANT EXECUTE ON FUNCTION "public"."forbid_mutation"() TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."article_reader" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."article_reader" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."article_reader" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."article_reader" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."article_tag" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."article_tag" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."article_tag" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."article_tag" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."articles" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."articles" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."articles" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."articles" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."discount_tag" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."discount_tag" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."discount_tag" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."discount_tag" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."discounts" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."discounts" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."discounts" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."discounts" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."invoice_items" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."invoice_items" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."invoice_items" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."invoice_items" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."invoices" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."invoices" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."invoices" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."invoices" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."locations" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."locations" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."locations" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."locations" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."members" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."members" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."members" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."members" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."photos" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."photos" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."photos" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."photos" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."product_dicsount" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."product_dicsount" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."product_dicsount" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."product_dicsount" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."product_tag" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."product_tag" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."product_tag" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."product_tag" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."product_variants" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."product_variants" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."product_variants" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."product_variants" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."products" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."products" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."products" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."products" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."stock_balances" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."stock_balances" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."stock_balances" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."stock_balances" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."stock_movements" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."stock_movements" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."stock_movements" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."stock_movements" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."tags" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."tags" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."tags" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."tags" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."tenants" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."tenants" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."tenants" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."tenants" TO "service_role";

