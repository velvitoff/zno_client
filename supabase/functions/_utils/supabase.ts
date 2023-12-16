import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';
import { Database } from '../../database.types';

// WARNING: The service role key has admin priviliges and should only be used in secure server environments!
const supabaseAdmin = createClient<Database>(
  Deno.env.get("SUPABASE_URL") ?? "",
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? ""
);

export const getCustomer = async (authHeader: string) => {
    const jwt = authHeader.replace("Bearer ", "");

    const {data: { user } } = await supabaseAdmin.auth.getUser(jwt);
    if (!user) throw new Error("No user found for JWT!");

    const { data, error } = await supabaseAdmin
    .from("users")
    .select("id, user_id, is_premium, purchase_id")
    .eq("id", user?.id);

    if (error) throw error;


    if (data?.length === 1) {
        // Exactly one customer found, return it.
        const customer = data[0];
        return customer;
    }
    else {
        throw new Error(`Unexpected count of customer rows: ${data?.length}`);
    }
}