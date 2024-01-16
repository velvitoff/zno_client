import { GoogleApiPurchasesProducts } from "../_utils/verifier.ts";
import { generateJwtToken, getOauth2AccessToken } from "../_utils/oauth2.ts";
import { PurchaseDetails } from '../_utils/common_types.ts';
import { SupabaseService } from "../_utils/supabase.ts";

//ENV needs to have
//SUPABASE_URL
//SUPABASE_SERVICE_ROLE_KEY
//GOOGLE_KEY_ID
//GOOGLE_SERVICE_EMAIL
//GOOGLE_PRIVATE_KEY

Deno.serve(async (req) => {
  const { purchaseToken, productId, orderId } = await req.json()
  if(purchaseToken === null || productId == null) {
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
    keyId: Deno.env.get("GOOGLE_SERVICE_ACCOUNT_KEY_ID"),
    email: Deno.env.get("GOOGLE_SERVICE_EMAIL"),
    privateKey: Deno.env.get("GOOGLE_SERVICE_ACCOUNT_KEY").replaceAll('\\n', '\n')
  });
  const accessToken = await getOauth2AccessToken(jwt);

  //init googleApi class
  const googleApi = new GoogleApiPurchasesProducts(
    {
      packageName: "com.velvit.zno_client",
      productId: purchaseDetails.productId,
      purchaseToken: purchaseDetails.purchaseToken,
    },
    accessToken.access_token
  );

  const purchaseSupabase = await SupabaseService.getPurchase(purchaseDetails.orderId);

  //get purchase from android publisher api
  let purchaseGoogleApi = await googleApi.get();
  if(purchaseGoogleApi.purchaseState !== 0) {
    return new Response("Purchase state is not \"purchased\"", {status: 400});
  }

  if(purchaseGoogleApi.acknowledgementState === 0) {
    await googleApi.acknowledge();
    purchaseGoogleApi = await googleApi.get();
  }

  await SupabaseService.syncSupabaseWithGoogleApi(purchaseGoogleApi, purchaseSupabase, purchaseDetails, supabaseUserId);

  return new Response("", {status: 200});
});
