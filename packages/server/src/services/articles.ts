import { createClient } from "../utils/supabase.js";

export async function getArticles(request: Request) {
    const { supabase, headers } = createClient(request);
    const { data, error } = await supabase
        .from("articles")
        .select("*")
        .eq("is_published", true)
        .is("deleted_at", null);

    if (error) throw error;
    return { data, headers };
}