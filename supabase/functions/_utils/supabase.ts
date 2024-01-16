import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { Database } from '../../database.types.ts';
import { PurchaseDetails } from "./common_types.ts";
import { ProductPurchase } from "./verifier.ts";

export interface SupabasePurchase {
    orderId: string,
    userId: string,
    ignoreCorectness: boolean,
    purchaseState: number,
    acknowledgementState: number
}

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

    static supabaseAdmin = createClient<Database>(
        Deno.env.get("SUPABASE_URL"),
        Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")
    );

    //returns id of a user purchase belongs to
    //if no purchase exists, returns empty string
    static async getPurchase(orderId: string): Promise<SupabasePurchase> {

        const { data, error } = await SupabaseService.supabaseAdmin
        .from("premium_purchases")
        .select("orderId, userId, ignoreCorrectness, purchaseState, acknowledgementState")
        .eq("orderId", orderId);
    
        if(error) throw error;

        if(data?.length === 1) {
            return data[0];
        }
        return { orderId: "", userId: "", ignoreCorectness: false, purchaseState: 1, acknowledgementState: 0};
    }

    static async getUserId(supabaseJwt: string): Promise<string> {
        const {data: { user } } = await SupabaseService.supabaseAdmin.auth.getUser(supabaseJwt);
        if (!user) throw new Error("No user found for JWT!");
        return user.id;
    }

    static async insertToPremiumPurchases(
        userId: string,
        purchaseDetails: PurchaseDetails,
        purchaseState: number,
        acknowledgementState: number
    ): Promise<void> {
        const { _, error } = await SupabaseService.supabaseAdmin
        .from("premium_purchases")
        .insert({
            orderId: purchaseDetails.orderId,
            purchaseToken: purchaseDetails.purchaseToken,
            userId: userId,
            productId: purchaseDetails.productId,
            purchaseState: purchaseState,
            acknowledgementState: acknowledgementState
        })
        
        if(error) throw error;
    }

    static async updateToPremiumPurchases(
        userId: string,
        purchaseDetails: PurchaseDetails,
        purchaseState: number,
        acknowledgementState: number
    ): Promise<void> {
        const { _, error } = await SupabaseService.supabaseAdmin
        .from("premium_purchases")
        .update({
            purchaseState: purchaseState,
            acknowledgementState: acknowledgementState
        })
        .eq("orderId", purchaseDetails.orderId)
        .eq("userId", userId);
        
        if(error) throw error;
    }

    static async syncSupabaseWithGoogleApi(
        purchaseGoogleApi: ProductPurchase,
        purchaseSupabase: SupabasePurchase,
        purchaseDetails: PurchaseDetails,
        supabaseUserId: string
    ) : Promise<void> {
        if(purchaseSupabase.orderId === "") {
            await SupabaseService.insertToPremiumPurchases(supabaseUserId, purchaseDetails, purchaseGoogleApi.purchaseState, purchaseGoogleApi.acknowledgementState);
        }
        else if(purchaseSupabase.acknowledgementState !== purchaseGoogleApi.acknowledgementState || purchaseSupabase.purchaseState !== purchaseGoogleApi.purchaseState) {
            await SupabaseService.updateToPremiumPurchases(supabaseUserId, purchaseDetails, purchaseGoogleApi.purchaseState, purchaseGoogleApi.acknowledgementState);
        }
        else {
            return;
        }
    }
}
