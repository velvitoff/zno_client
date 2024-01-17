import { GoogleApiPurchasesProducts } from "../_utils/google_api.ts";
import { generateJwtToken, getOauth2AccessToken } from "../_utils/oauth2.ts";
import { PurchaseDetails } from '../_utils/common_types.ts';
import { SupabaseService } from "../_utils/supabase.ts";
import { Env } from "../_utils/env.ts";

Deno.serve(async (req: any) => {
  const { purchaseToken, productId, orderId } = await req.json()
  if(purchaseToken === null || productId === null || orderId === null) {
    return new Response("Invalid input data", {status: 400});
  }

  const purchaseDetails: PurchaseDetails = {
    purchaseToken,
    productId,
    orderId
  };

  //get supabase customerId
  const authHeader: string = req.headers.get("Authorization")!;
  const supabaseJwt = authHeader.replace("Bearer ", "");
  const supabaseUserId = await SupabaseService.getUserId(supabaseJwt);

  //get google oauth2 token
  const jwt = await generateJwtToken({
    keyId: Env.i().GOOGLE_SERVICE_ACCOUNT_KEY_ID,
    email: Env.i().GOOGLE_SERVICE_EMAIL,
    privateKey: Env.i().GOOGLE_SERVICE_ACCOUNT_KEY
  });

  //init googleApi class
  const googleApi = new GoogleApiPurchasesProducts(
    {
      packageName: "com.velvit.zno_client",
      productId: purchaseDetails.productId,
      purchaseToken: purchaseDetails.purchaseToken,
    },
    (await getOauth2AccessToken(jwt)).access_token
  );

  //get purchase from android publisher api
  let purchaseGoogleApi = await googleApi.get();

  //if state is not "purchased" -> refuse
  if(purchaseGoogleApi.purchaseState !== 0) {
    return new Response("Purchase state is not \"purchased\"", {status: 400});
  }

  //acknowledge purchase if necessary
  if(purchaseGoogleApi.acknowledgementState === 0) {
    await googleApi.acknowledge();
  }

  //If purchase doesn't exist in the database, create it
  const purchaseSupabase = await SupabaseService.getPurchaseByOrderId(purchaseDetails.orderId);
  if(purchaseSupabase === null) {
    await SupabaseService.insertToPremiumPurchases(supabaseUserId, purchaseDetails);
  }

  return new Response("", {status: 200});
});
