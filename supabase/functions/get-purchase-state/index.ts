import { GoogleApiPurchasesProducts, ProductPurchase } from "../_utils/google_api.ts";
import { generateJwtToken, getOauth2AccessToken } from "../_utils/oauth2.ts";
import { PurchaseDetails } from "../_utils/common_types.ts";
import { Env } from "../_utils/env.ts";

Deno.serve(async (req) => {
  const { productId, purchaseToken, orderId } = await req.json()
  if(productId == null || purchaseToken == null) {
    return new Response("Bad input data", {status: 400});
  }

  const purchaseDetails: PurchaseDetails = {
    purchaseToken,
    productId,
    orderId
  };

  //get google oauth2 token
  const jwt = await generateJwtToken({
    keyId: Env.i().GOOGLE_SERVICE_ACCOUNT_KEY_ID,
    email: Env.i().GOOGLE_SERVICE_EMAIL,
    privateKey: Env.i().GOOGLE_SERVICE_ACCOUNT_KEY
  });
  
  const googleApi = new GoogleApiPurchasesProducts(
    {
      packageName: "com.velvit.zno_client",
      productId:  purchaseDetails.productId,
      purchaseToken:  purchaseDetails.purchaseToken,
    },
    (await getOauth2AccessToken(jwt)).access_token
  );

  const purchase = await googleApi.get();
  
  return new Response(
    JSON.stringify(purchase),
    { headers: { "Content-Type": "application/json" }, status: 200 },
  );
});
