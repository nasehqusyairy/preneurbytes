import { useState } from "react";
import { Form, Link } from "react-router";
import { RiMenuLine, RiSearchLine } from "@remixicon/react";
import { Button } from "~/components/ui/button";
import { Input } from "~/components/ui/input";
import { cn } from "~/lib/utils";

const sections = [
  "Terkini",
  "Nasional",
  "Dunia",
  "Ekonomi",
  "Olahraga",
  "Teknologi",
  "Gaya Hidup",
  "Analisis",
];

export function SiteHeader() {
  const [menuOpen, setMenuOpen] = useState(false);
  const [searchOpen, setSearchOpen] = useState(false);
  return (
    <>
      <div className="border-b text-xs text-muted-foreground">
        <div className="mx-auto flex h-8 max-w-7xl items-center justify-between px-4 sm:px-6">
          <span>RABU, 7 OKTOBER 2026</span>
          <span className="hidden sm:inline">Jernih melihat. Berani bicara.</span>
          <Link className="text-foreground" to="/search?query=terkini">
            Berita terkini →
          </Link>
        </div>
      </div>
      <header className="mx-auto flex min-h-20 max-w-7xl items-center justify-between gap-3 px-4 sm:px-6">
        <Button
          variant="outline"
          size="icon"
          className="md:hidden"
          aria-label="Buka menu"
          onClick={() => setMenuOpen(!menuOpen)}
        >
          <RiMenuLine />
        </Button>
        <Link to="/" className="brand block text-center no-underline" aria-label="Pasir beranda">
          <img
            src="/logo.jpeg"
            alt="Pasir - Berani Bicara Fakta"
            className="block h-auto w-32 sm:w-36"
          />
        </Link>
        <div className="flex items-center gap-2 sm:gap-4">
          <span className="hidden text-[10px] tracking-widest text-muted-foreground lg:block">
            EDISI INDONESIA
          </span>
          <Button
            variant="outline"
            size="icon"
            aria-label="Cari berita"
            onClick={() => setSearchOpen(!searchOpen)}
          >
            <RiSearchLine />
          </Button>
          <Link
            to="/#newsletter"
            className="hidden h-8 items-center bg-primary px-3 text-xs font-medium text-primary-foreground transition-colors hover:bg-primary/80 sm:inline-flex"
          >
            IKUTI PASIR →
          </Link>
        </div>
      </header>
      {searchOpen && (
        <Form
          action="/search"
          method="get"
          className="mx-auto flex max-w-7xl items-center gap-2 border-t px-4 py-3 sm:px-6"
        >
          <RiSearchLine className="size-4 text-muted-foreground" />
          <Input
            name="query"
            placeholder="Cari berita, topik, atau tokoh…"
            aria-label="Cari berita"
            autoFocus
          />
          <Button type="submit">Cari</Button>
        </Form>
      )}
      <nav aria-label="Navigasi utama" className="border-y-2 border-b-highlight bg-foreground text-background">
        <div
          className={cn(
            "mx-auto max-w-7xl flex-wrap items-center gap-x-7 px-4 text-background sm:px-6",
            menuOpen ? "flex py-2" : "hidden md:flex",
          )}
        >
          {sections.map((section) => (
            <Link
              key={section}
              to={`/search?query=${encodeURIComponent(section)}`}
              onClick={() => setMenuOpen(false)}
              className="flex min-h-11 items-center text-[10px] font-bold uppercase tracking-[.08em] text-background/85 no-underline transition-colors hover:text-highlight"
            >
              {section}
            </Link>
          ))}
        </div>
      </nav>
    </>
  );
}

export function AdSlot({ variant = "banner" }: { variant?: "banner" | "rectangle" }) {
  return (
    <aside
      aria-label="Ruang iklan"
      className={cn(
        "ad-slot flex items-center justify-center border border-dashed bg-muted/30 text-center text-[10px] font-medium uppercase tracking-[.2em] text-muted-foreground",
        variant === "banner" ? "min-h-24 w-full" : "min-h-64 w-full",
      )}
    >
      <span>
        Ruang Iklan <span className="normal-case tracking-normal">· {variant === "banner" ? "728 × 90" : "300 × 250"}</span>
      </span>
    </aside>
  );
}
