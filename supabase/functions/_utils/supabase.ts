import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { Database } from '../../database.types.ts';
import { PurchaseDetails } from "./common_types.ts";
import { Env } from "./env.ts";

export interface SupabasePurchase {
    orderId: string,
    userId: string,
    purchaseToken: string,
    productId: string
}

export class SupabaseService {
    static supabaseAdmin = createClient<Database>(Env.i().SUPABASE_URL, Env.i().SUPABASE_SERVICE_ROLE_KEY);

    static async getPurchaseByOrderId(orderId: string): Promise<SupabasePurchase | null> {
        const { data, _error } = await SupabaseService.supabaseAdmin
        .from("premium_purchases")
        .select("orderId, userId, productId")
        .eq("orderId", orderId);

        if(data?.length === 1) {
            return data[0];
        }
        return null;
    }

    static async getPurchaseByUserId(userId: string): Promise<SupabasePurchase | null> {
        const { data, _error } = await SupabaseService.supabaseAdmin
        .from("premium_purchases")
        .select("orderId, userId, productId")
        .eq("userId", userId);

        if(data?.length === 1) {
            return data[0];
        }
        return null;
    }

    static async getUserId(supabaseJwt: string): Promise<string> {
        const {data: { user } } = await SupabaseService.supabaseAdmin.auth.getUser(supabaseJwt);
        if (!user) throw new Error("No user found for JWT!");
        return user.id;
    }

    static async insertToPremiumPurchases(
        userId: string,
        purchaseDetails: PurchaseDetails
    ): Promise<void> {
        const { _, error } = await SupabaseService.supabaseAdmin
        .from("premium_purchases")
        .insert({
            orderId: purchaseDetails.orderId,
            purchaseToken: purchaseDetails.purchaseToken,
            userId: userId,
            productId: purchaseDetails.productId
        });
        
        if(error) throw error;
    }
}
