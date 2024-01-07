import { GoogleApiPurchasesProducts } from "../_utils/verifier.ts";
import { generateJwtToken, getOauth2AccessToken } from "../_utils/oauth2.ts";

Deno.serve(async (req) => {
  const { productId, purchaseId } = await req.json()
  if(productId == null || purchaseId == null) {
    return new Response("", {status: 400});
  }

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
      productId: productId,
      purchaseToken: purchaseId,
    },
    accessToken.access_token
  );

  const purchase = await googleApi.get();

  return new Response(
    JSON.stringify(purchase),
    { headers: { "Content-Type": "application/json" }, status: 200 },
  )
})

