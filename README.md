# Preneur Bytes Monorepo

Monorepo ini menampung aplikasi React Router dan kode bersama yang digunakan lintas aplikasi. Aplikasi berada di `apps/`, sedangkan package bersama berada di `packages/`.

## Struktur

```text
apps/
  backoffice/       # Aplikasi React Router
  landing-page/     # Aplikasi React Router
  pasir-articles/   # Aplikasi React Router
packages/
  server/           # Service dan integrasi Supabase yang dipakai server-side
  models/           # Database types hasil generate dan alias model bersama
```

Workspace dikelola dengan pnpm. Package lokal dikenali melalui `pnpm-workspace.yaml` dan direferensikan dengan `workspace:*`.

## Persiapan

Gunakan versi pnpm yang dideklarasikan di root `package.json`, kemudian install seluruh dependency dari root:

```sh
pnpm install
```

Build dan typecheck semua package/app yang menyediakan script terkait:

```sh
pnpm build
pnpm typecheck
```

Untuk menjalankan app tertentu, gunakan script yang terdaftar di manifest app tersebut, misalnya:

```sh
pnpm --filter @preneurbytes/pasir-articles dev
```

## Menggunakan package bersama

Tambahkan dependency workspace ke `dependencies` app sebelum mengimpor package. Saat package baru ditambahkan atau dependency berubah, jalankan `pnpm install` dari root.

### Import service dari `@preneurbytes/server`

Package server mengekspor service melalui subpath, bukan melalui root import. Untuk menggunakan suatu service di aplikasi:

1. Pastikan app memiliki dependency `"@preneurbytes/server": "workspace:*"` di `package.json`.
2. Pastikan modul tersebut didaftarkan pada `exports` di `packages/server/package.json`.
3. Build package server, lalu impor service menggunakan subpath yang sama dengan key export.

Contoh: entri `"./services/articles"` pada `exports` memetakan ke file build `dist/services/articles.js`, sehingga dapat diimpor seperti ini:

```ts
import { getArticles } from "@preneurbytes/server/services/articles";
import { getTenants } from "@preneurbytes/server/services/tenants";
```

Build service sebelum menjalankan app atau typecheck yang mengonsumsinya:

```sh
pnpm --filter @preneurbytes/server build
```

### Import model dari `@preneurbytes/models`

Package models mengekspor tipe database dan alias tabel dari root package. Import tipe menggunakan `import type` agar tidak menghasilkan import runtime:

```ts
import type {
  Article,
  ArticleInsert,
  ArticleUpdate,
} from "@preneurbytes/models";
```

Type untuk setiap tabel dibuat dari schema Supabase. Generator menyediakan alias singular dan nama plural tabel, ditambah tipe `Insert` dan `Update`. Generic `TableName`, `TableRow<Name>`, `TableInsert<Name>`, dan `TableUpdate<Name>` juga tersedia.

Contoh pemakaian di server:

```ts
import type { Article } from "@preneurbytes/models";

const articles: Article[] = data;
```

Query Supabase yang menghasilkan `null` karena memakai `maybeSingle()` atau bentuk nullable lain perlu dinyatakan sesuai tipe hasil query, bukan dipaksakan sebagai array.

## Mengubah package server

Semua implementasi service dan utilitas server berada di `packages/server/src/`. Package ini tidak menyediakan ekspor root; setiap API publik harus memiliki subpath export tersendiri.

Untuk menambah atau memperbarui service:

1. Buat atau edit implementasi di `packages/server/src/`, misalnya `src/services/articles.ts`.
2. Jika file baru perlu diimpor aplikasi, daftarkan subpath-nya di `packages/server/package.json` pada `exports`. Contoh untuk `src/services/articles.ts`:

```json
{
  "exports": {
    "./services/articles": {
      "types": "./dist/services/articles.d.ts",
      "import": "./dist/services/articles.js"
    },
    "./services/tenants": {
      "types": "./dist/services/tenants.d.ts",
      "import": "./dist/services/tenants.js"
    }
  }
}
```

Key `./services/articles` menjadi specifier import `@preneurbytes/server/services/articles`. Path target harus menunjuk ke file hasil build di `dist/`: kondisi `types` ke deklarasi `.d.ts` dan `import` ke file `.js`. Pertahankan entri export lain yang sudah ada saat menambahkan subpath baru. 3. Pastikan app pemakai memiliki dependency `"@preneurbytes/server": "workspace:*"` di `dependencies`. 4. Impor service menggunakan subpath export, bukan path source relatif lintas package. 5. Jalankan build dan typecheck package, lalu build/typecheck app terkait:

```sh
pnpm --filter @preneurbytes/server build
pnpm --filter @preneurbytes/server typecheck
pnpm --filter @preneurbytes/pasir-articles build
```

`pnpm build` di root akan membangun semua workspace package secara rekursif. Package server bergantung pada models, sehingga perubahan tipe models harus dibangun dan diperiksa bersama.

## Supabase

`packages/server/src/utils/supabase.ts` membuat server client dengan `@supabase/ssr`, meneruskan cookie request, dan menggunakan tipe `Database` dari models. Service di `packages/server/src/services/` menggunakan client tersebut untuk query dan mengembalikan header cookie bersama hasilnya.

Atur environment variable berikut untuk menjalankan app server-side:

```sh
SUPABASE_URL=...
SUPABASE_PUBLISHABLE_KEY=...
```

Simpan nilainya di environment lokal/deployment, jangan commit secret ke repository. Publishable key dapat digunakan pada client sesuai konfigurasi akses database; jangan pernah mengekspos service-role/secret key ke browser. Akses tabel tetap harus diamankan dengan Row Level Security (RLS) dan policy yang sesuai.

### Menghubungkan project dan menarik schema

Konfigurasi Supabase untuk schema/migration berada di folder `supabase` di proyek manapun. Login satu kali jika CLI belum terautentikasi:

```sh
pnpm dlx supabase login
```

Hubungkan package server ke project Supabase. Pilih project ref yang sesuai:

```sh
pnpm dlx supabase link
```

CLI akan meminta database password jika dibutuhkan. Jangan menaruh password di README, shell history, atau file yang di-commit. Setelah link, tarik perbedaan schema dari project remote ke migration lokal:

```sh
pnpm dlx supabase db pull
```

Periksa migration yang dibuat atau diperbarui di `supabase/migrations/`, lalu tinjau dan commit perubahan tersebut seperti migration biasa. `db pull` memperbarui berkas migration; perintah ini tidak menghasilkan tipe TypeScript.

### Memperbarui generated database types

`packages/models` menyediakan dua helper script:

- `generate:types`: mengambil tipe TypeScript schema `public` dari project Supabase dengan CLI, menulis `src/database.types.ts`, lalu menjalankan alias generator.
- `generate:models`: membaca file generated lokal dan memperbarui `src/models.ts` tanpa menghubungi Supabase. Gunakan ini jika file tipe database sudah diperbarui.

Setelah schema remote diperbarui (atau ketika hanya ingin menyegarkan tipe), pastikan CLI sudah terautentikasi dan sudah melakukan link. Jalankan dari root dengan project ref yang sama:

```sh
pnpm --filter @preneurbytes/models generate:types
```

Jika CLI belum memiliki sesi login, autentikasi lebih dahulu dengan `pnpm --filter @preneurbytes/models exec supabase login` dan ikuti alur CLI. Jangan memasukkan access token ke command yang disimpan, README, atau file yang di-commit.

Untuk generate alias dari `src/database.types.ts` yang sudah ada:

```sh
pnpm --filter @preneurbytes/models generate:models
```

Generator menghasilkan alias dari entri `public.Tables` pada `Database`, misalnya `articles` menjadi `Article` dan `Articles`, beserta `ArticleInsert`, `ArticleUpdate`, `ArticlesInsert`, dan `ArticlesUpdate`. Penamaan singular mengikuti aturan sederhana; periksa `src/models.ts` jika nama tabel tidak beraturan atau berpotensi bertabrakan.

Setelah generate tipe, tinjau perubahan pada `packages/models/src/database.types.ts` dan `packages/models/src/models.ts`, lalu verifikasi package dan pemakainya:

```sh
pnpm --filter @preneurbytes/models build
pnpm --filter @preneurbytes/models typecheck
pnpm --filter @preneurbytes/server typecheck
pnpm build
```

Tipe tersebut mencerminkan schema saat proses generate dan tidak mengubah database. Perubahan database tetap perlu dikelola melalui workflow migration Supabase proyek.
