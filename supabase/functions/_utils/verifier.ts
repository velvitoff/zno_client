import { create } from "https://deno.land/x/djwt@3.0.1/mod.ts";

function str2ab(str: string): ArrayBuffer {
  const buf = new ArrayBuffer(str.length);
  const bufView = new Uint8Array(buf);
  for (let i = 0, strLen = str.length; i < strLen; i++) {
    bufView[i] = str.charCodeAt(i);
  }
  return buf;
}

export async function generateJwtToken(keyId: string, email: string, privateKey: string) {
  const header = { alg: "RS256", typ: "JWT", kid: keyId };
  const payload = { iss: email, scope: ['https://www.googleapis.com/auth/androidpublisher'], exp: Date.now()+120, iat: Date.now()};
  
  const binaryDerString = atob(privateKey);
  const binaryDer = str2ab(binaryDerString);
  const key = crypto.subtle.importKey(
    "pkcs8",
    binaryDer,
    {
      name: "RSASSA-PKCS1-v1_5",
      hash: "SHA-256",
    },
    true,
    ["sign", "verify"]
  )

  const jwt = await create(header, payload, key);

}

export async function getOauth2AccessToken() {

}











export interface ProductPurchase {
  kind: string,
  purchaseTimeMillis: string,
  purchaseState: number,
  consumptionState: number,
  developerPayload: string,
  orderId: string,
  purchaseType: number,
  acknowledgementState: number,
  purchaseToken: string,
  productId: string,
  quantity: number,
  obfuscatedExternalAccountId: string,
  obfuscatedExternalProfileId: string,
  regionCode: string
}

export interface ProductData {
  packageName: string,
  productId: string,
  token: string
}

enum PurchasesProductsRequestType {
  get,
  consume,
  acknowledge,
}

export class GooglePurchasesProducts {
  data: ProductData;

  constructor(data: ProductData) {
    this.data = data;
  }

  public async get() : Promise<ProductPurchase> {
    return this.request(this.data, PurchasesProductsRequestType.get);
  }

  public async consume() : Promise<ProductPurchase> {
    return this.request(this.data, PurchasesProductsRequestType.consume);
  }

  public async acknowledge() : Promise<ProductPurchase> {
    return this.request(this.data, PurchasesProductsRequestType.acknowledge);
  }

  private async request(data: ProductData, requestType: PurchasesProductsRequestType): Promise<ProductPurchase> {
    let url: string = "https://androidpublisher.googleapis.com/androidpublisher/v3/applications/${data.packageName}/purchases/products/${data.productId}/tokens/${data.token}";
    if(requestType == PurchasesProductsRequestType.acknowledge) {
      url = url + ":acknowledge";
    }
    else if (requestType == PurchasesProductsRequestType.consume) {
      url = url + ":consume";
    }
    const response = await fetch(url);

    if(!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }

    try {
      const json = await response.json();
      const productPurchase: ProductPurchase = {
        kind: json.kind,
        purchaseTimeMillis: json.purchaseTimeMillis,
        purchaseState: json.purchaseState,
        consumptionState: json.consumptionState,
        developerPayload: json.developerPayload,
        orderId: json.orderId,
        purchaseType: json.purchaseType,
        acknowledgementState: json.acknowledgementState,
        purchaseToken: json.purchaseToken,
        productId: json.productId,
        quantity: json.quantity,
        obfuscatedExternalAccountId: json.obfuscatedExternalAccountId,
        obfuscatedExternalProfileId: json.obfuscatedExternalProfileId,
        regionCode: json.regionCode,
      };
      return productPurchase;
    }
    catch(e) {
      throw e;
    }
  }
}

/*

import { requestWithJWT } from "https://esm.sh/google-oauth-jwt";

function isValidJson(string: string) {
  try {
    JSON.parse(string);
  } catch (e) {
    return false;
  }
  return true;
}

export const verifyINAPP = (
    receipt:
    {
      packageName: string,
      productId: string,
      purchaseToken: string,
      developerPayload?: string
    },
    authData: {
      email: string,
      key: string
    }
    ) => {
  
      let options : {
          uri: string,
          method: string,
          body: {},
          json: boolean,
          jwt: {}
        } = {
          uri: "",
          method: 'get',
          body: {},
          json: false,
          jwt: {}
        }
  
  
      let url = "https://www.googleapis.com/androidpublisher/v3/applications/${encodeURIComponent(receipt.packageName)}/purchases/products/${encodeURIComponent(receipt.productId)}/tokens/${encodeURIComponent(receipt.purchaseToken)}";
      if ("developerPayload" in receipt) {
          url += ":acknowledge";
          options.body = {
            "developerPayload": receipt.developerPayload
          }
          options.method = 'post';
          options.json = true;
      }
  
      //verify
      options = {
          uri: url,
          method: options.method,
          body: options.body,
          json: options.json,
          jwt: {
            email: authData.email,
            key: authData.key,
            scopes: ['https://www.googleapis.com/auth/androidpublisher']
          }
      };
  
      return new Promise(function (resolve, reject) {
        requestWithJWT(options, function (err, res, body) {
            
          let resultInfo: {
            isSuccessful: boolean,
            errorMessage: string,
            payload: object,
            errorCode? : number
          } = {
            isSuccessful: false,
            errorMessage: "",
            payload: {}
          };
    
          if (err) {
            // Google Auth Errors returns here
            let errBody = err.body;
            let errorMessage;
            if (errBody) {
              errorMessage = err.body.error_description;
            } else {
              errorMessage = err;
            }
            resultInfo.isSuccessful = false;
            resultInfo.errorMessage = errorMessage;
    
            reject(resultInfo);
          } else {
    
            let obj = {
              isError: true,
              code: res.statusCode,
              message: "Invalid response, please check 'Verifier' configuration or the statusCode above"
            };
            if (res.statusCode === 204) {
              obj = {
                isError: false,
                code: res.statusCode,
                message: "Acknowledged Purchase Successfully"
              };
            }
    
            if (isValidJson(body)) {
              obj = JSON.parse(body);
            }
    
            if (res.statusCode === 200 || res.statusCode === 204) {
              // All Good
    
              resultInfo.isSuccessful = true;
              resultInfo.errorMessage = "";
    
              resultInfo.payload = obj;
    
              resolve(resultInfo);
    
            } else {
              // Error
              let errorMessage = obj.message;
              let errorCode = obj.code;
    
              resultInfo.isSuccessful = false;
              resultInfo.errorCode = errorCode;
              resultInfo.errorMessage = errorMessage;
    
              reject(resultInfo);
            }
    
          }
        });
    
      })
    };
*/