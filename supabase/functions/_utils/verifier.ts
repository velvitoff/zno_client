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
  purchaseToken: string
}

enum PurchasesProductsRequestType {
  get,
  consume,
  acknowledge,
}

export class GoogleApiPurchasesProducts {
  data: ProductData;
  accessToken: string;

  constructor(data: ProductData, accessToken: string) {
    this.data = data;
    this.accessToken = accessToken;
  }

  public async get() : Promise<ProductPurchase> {
    return this.request(PurchasesProductsRequestType.get);
  }

  public async consume() : Promise<ProductPurchase> {
    return this.request(PurchasesProductsRequestType.consume);
  }

  public async acknowledge() : Promise<ProductPurchase> {
    return this.request(PurchasesProductsRequestType.acknowledge);
  }

  private async request(requestType: PurchasesProductsRequestType): Promise<ProductPurchase> {
    const baseurl = "https://androidpublisher.googleapis.com/androidpublisher/v3/applications/";
    let stringToAdd = "";
    if(requestType == PurchasesProductsRequestType.acknowledge) {
      stringToAdd = ":acknowledge";
    }
    else if (requestType == PurchasesProductsRequestType.consume) {
      stringToAdd = ":consume";
    }

    let url = new URL(`${baseurl}${encodeURIComponent(this.data.packageName)}/purchases/products/${encodeURIComponent(this.data.productId)}/tokens/${encodeURIComponent(this.data.purchaseToken)}${stringToAdd}`);

    let method = "GET";
    if(requestType == PurchasesProductsRequestType.acknowledge || requestType == PurchasesProductsRequestType.consume) {
      method = "POST";
    }

    const response = await fetch(url, {
      method: method,
      headers: {
        Authorization: `Bearer ${this.accessToken}`
      }
    });

    if(!response.ok) {
      throw new Error(`ap req error: Status: ${response.status}, ${JSON.stringify(await response.json())}, packageName: ${this.data.packageName}, purchaseToken: ${this.data.purchaseToken}, productId: ${this.data.productId}, access_token: ${this.accessToken}`);
    }

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
}
