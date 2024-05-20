import { SupabaseService } from "../_utils/supabase.ts";

Deno.serve(async (req) => {
  const authHeader: string = req.headers.get("Authorization")!;
  const supabaseJwt = authHeader.replace("Bearer ", "");
  const supabaseUserId = await SupabaseService.getUserId(supabaseJwt);

  const purchase = await SupabaseService.getPurchaseByUserId(supabaseUserId);

  if(purchase !== null) {
    return new Response("", {status: 200});
  }

  return new Response("", {status: 400});
});
