import { serve } from 'https://deno.land/std@0.131.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.0.0';

const SUPABASE_URL = Deno.env.get('SUPABASE_URL') || "https://tumueonqqmelnndwgupq.supabase.co";
const SUPABASE_KEY = Deno.env.get('SUPABASE_KEY') || "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR1bXVlb25xcW1lbG5uZHdndXBxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE1MTQ0OTEsImV4cCI6MjA0NzA5MDQ5MX0.jpaRr3sGwmDP0jS6LXqSkHzw_Td21GIcvwA8nZI4NR4";

if (!SUPABASE_URL || !SUPABASE_KEY) {
  console.error('Supabase URL or API key is not set.');
  Deno.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

serve(async (req) => {
  try {
    const url = new URL(req.url);
    const authorId = url.searchParams.get('author_id');
    const sortBy = url.searchParams.get('sort_by') || 'publish_date';
    const page = parseInt(url.searchParams.get('page')) || 1;
    const limit = parseInt(url.searchParams.get('limit')) || 10;
    const offset = (page - 1) * limit;

    let query = supabase.from('books').select('*, authors(name)').range(offset, offset + limit - 1).order(sortBy, { ascending: true });

    if (authorId) {
      query = query.eq('author_id', authorId);
    }

    const { data, error } = await query;

    if (error) {
      return new Response(JSON.stringify({ error: error.message }), { status: 500 });
    }

    return new Response(JSON.stringify(data), { status: 200, headers: { 'Content-Type': 'application/json' } });
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500 });
  }
});
