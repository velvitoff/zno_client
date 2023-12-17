import { GooglePurchasesProducts } from "../_utils/verifier.ts";
import { getCustomer, doesPurchaseExist, grantEntitlement } from "../_utils/supabase.ts";
import { generateJwtToken, getOauth2AccessToken } from "../_utils/oauth2.ts";

Deno.serve(async (req) => {
  try {
    const { purchaseId, productId, verificationData, transactionDate, status } = await req.json()
    const authHeader: string = req.headers.get("Authorization")!;
    const supabaseJwt = authHeader.replace("Bearer ", "");


    //check for duplicate purchase Id
    const purchaseExists = await doesPurchaseExist(purchaseId);
    if(purchaseExists) {
      throw new Error("This purchase Id is already in use");
    }

    //get supabase customer
    const customer = await getCustomer(supabaseJwt);
    const jwt = await generateJwtToken({
      keyId:"fa912181377f570abebf306de5d89beab1084284",
      email: "zno-client-purchace-validator@zno-client.iam.gserviceaccount.com",
      privateKey: ""
    });
    const accessToken = await getOauth2AccessToken(jwt);
    //init googleApi class
    const googleApi = new GooglePurchasesProducts(
      {
        packageName: "com.velvit.zno_client",
        productId: productId,
        token: purchaseId,
      },
      accessToken.access_token
    );
    //get purchase
    const purchase = await googleApi.get();
    //check purchaseState. "Possible values are: 0. Purchased 1. Canceled 2. Pending"
    if(purchase.purchaseState !== 0) {
      throw new Error("Purchase state is either pending or cancelled");
    }
    //granting entitlement
    await grantEntitlement(customer, purchaseId);
    //acknowledging purchase
    await googleApi.acknowledge();
  }
  catch(e) {
    throw e;
  }
  
  return new Response(
    "",
    {
      status: 200,
      headers: { "Content-Type": "application/json" }
    },
  )
})
