import { GoogleApiPurchasesProducts } from "../_utils/verifier.ts";
import { generateJwtToken, getOauth2AccessToken } from "../_utils/oauth2.ts";
import { PurchaseDetails, PurchaseVerificationData } from '../_utils/common_types.ts';
import { SupabaseService } from "../_utils/supabase.ts";

//ENV needs to have
//SUPABASE_URL
//SUPABASE_SERVICE_ROLE_KEY
//GOOGLE_KEY_ID
//GOOGLE_SERVICE_EMAIL
//GOOGLE_PRIVATE_KEY

Deno.serve(async (req) => {
  try {
    const { purchaseId, productId, verificationData, transactionDate, status } = await req.json()
    if(purchaseId === null) {
      return new Response(
        "purchaseId is null",
        {
          status: 400,
        }
      );
    }

    const purchaseDetails: PurchaseDetails = {
      purchaseId,
      productId,
      verificationData: verificationData as PurchaseVerificationData,
      transactionDate,
      status
    };

    //check for duplicate purchase Id
    const purchaseExists = await SupabaseService.doesPurchaseExist(purchaseDetails.purchaseId);
    if(purchaseExists) {
      throw new Error("This purchaseId is already in use");
    }

    //get supabase customerId
    const authHeader: string = req.headers.get("Authorization")!;
    const supabaseJwt = authHeader.replace("Bearer ", "");
    const supabaseUserId = await SupabaseService.getUserId(supabaseJwt);

    //get google oauth2 token
    const jwt = await generateJwtToken({
      keyId: Deno.env.get("GOOGLE_SERVICE_ACCOUNT_KEY_ID"),
      email: Deno.env.get("GOOGLE_SERVICE_EMAIL"),
      privateKey: Deno.env.get("GOOGLE_SERVICE_ACCOUNT_KEY")
    });
    const accessToken = await getOauth2AccessToken(jwt);
    //init googleApi class
    const googleApi = new GoogleApiPurchasesProducts(
      {
        packageName: "com.velvit.zno_client",
        productId: purchaseDetails.productId,
        purchaseToken: purchaseDetails.purchaseId,
      },
      accessToken.access_token
    );
    //get purchase
    const purchase = await googleApi.get();
    //check purchaseState. "Possible values are: 0. Purchased 1. Canceled 2. Pending"
    if(purchase.purchaseState !== 0) {
      throw new Error("Purchase state is not purchased");
    }
    //granting entitlement
    await SupabaseService.grantPremium(supabaseUserId, purchaseId);
    //acknowledging purchase
    await googleApi.acknowledge();
  }
  catch(e) {
    throw e;
  }
  
  return new Response("", {status: 200})
})
