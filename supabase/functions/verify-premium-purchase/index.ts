//import { verifyINAPP } from "../_utils/verifier.ts";
import { GooglePurchasesProducts } from "../_utils/verifier.ts";
import { getCustomer } from "../_utils/supabase.ts";

Deno.serve(async (req) => {
  const { purchaseId, productId, verificationData, transactionDate, status } = await req.json()
  const authHeader: string = req.headers.get("Authorization")!;

  const customer = await getCustomer(authHeader);

  //needs auth header
  const googleApi = new GooglePurchasesProducts(
    {
      packageName: "com.velvit.zno_client",
      productId: productId,
      token: purchaseId
    }
  );
  verifyINAPP(
    {packageName: "com.velvit.zno_client", productId: productId, purchaseToken: purchaseId},
    {email: customer.email, key: ""}
  )
  .then((response) => {
    //add purchase to db
    //ackowledge purchase
  })
  .catch((error) => {
    //return error
  });

  const data = {
    message: `Hello Test!`,
  }


  return new Response(
    JSON.stringify(data),
    { headers: { "Content-Type": "application/json" } },
  )
})
