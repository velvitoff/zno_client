import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';
import { Database } from '../../database.types';

// WARNING: The service role key has admin priviliges and should only be used in secure server environments!
const supabaseAdmin = createClient<Database>(
  Deno.env.get("SUPABASE_URL") ?? "",
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? ""
);

export const doesPurchaseExist = async (purchaseId: string): Promise<boolean> => {
    const { data, error } = await supabaseAdmin
        .from("premium_purchases")
        .select("purchaseid")
        .eq("purchaseid", purchaseId);
    
    if(error) throw error;

    if(data?.lenth === 0) {
        return false;
    }
    return true;
}

export const getCustomer = async (supabaseJwt: string) => {
    const {data: { user } } = await supabaseAdmin.auth.getUser(supabaseJwt);
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

export const grantEntitlement = async (customer: any, purchaseId: string): Promise<void> => {
    const { _data, error } = await supabaseAdmin
        .from("premium_purchases")
        .insert({purchaseid: purchaseId})
    
    if(error) throw error;

    const { _data2, error2 } = await supabaseAdmin
        .from("users")
        .update({purchaseid: purchaseId})
        .eq("id", customer.id)

    if(error2) throw error;
}