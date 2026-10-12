import { createClient } from "../utils/supabase.js";

export async function getTenants(request: Request) {
    const { supabase, headers } = createClient(request);
    const { data, error } = await supabase
        .from("tenants")
        .select("*")
        .is("deleted_at", null);

    if (error) throw error;

    return { data, headers };
}