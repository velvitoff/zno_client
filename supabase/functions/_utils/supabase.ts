import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { Database } from '../../database.types.ts';
import { PurchaseDetails } from "./common_types.ts";

export class SupabaseService {
    //singleton
    private static instance: SupabaseService | null = null;

    private constructor() {}

    static getInstance(): SupabaseService{
        if (SupabaseService.instance === null) {
          SupabaseService.instance = new SupabaseService();
        }
    
        return SupabaseService.instance;
    }

    // WARNING: The service role key has admin priviliges and should only be used in secure server environments!
    static supabaseAdmin = createClient<Database>(
        Deno.env.get("SUPABASE_URL") ?? "",
        Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? ""
    );

    static async doesPurchaseExist(purchaseId: string): Promise<boolean> {
        const { data, error } = await supabaseAdmin
        .from("premium_purchases")
        .select("purchaseid")
        .eq("purchaseid", purchaseId);
    
        if(error) throw error;

        if(data?.lenth === 1) {
            return true;
        }
        return false;
    }

    static async getUserId(supabaseJwt: string): Promise<string> {
        const {data: { user } } = await supabaseAdmin.auth.getUser(supabaseJwt);
        if (!user) throw new Error("No user found for JWT!");
        return user.id;
    }

    static async grantPremium(userId: string, purchaseDetails: PurchaseDetails): Promise<void> {
        const { _data, error } = await supabaseAdmin
        .from("premium_purchases")
        .insert({
            purchaseid: purchaseDetails.purchaseId,
            productid: purchaseDetails.productId,
            status: purchaseDetails.status,
            user: userId
        })
        
        if(error) throw error;
    }
}
