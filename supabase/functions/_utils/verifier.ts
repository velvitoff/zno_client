export interface ProductPurchase {
  kind: string,
  purchaseState: number,
  consumptionState: number,
  orderId: string,
  purchaseType: number,
  acknowledgementState: number,
  purchaseToken: string,
  productId: string,
  quantity: number,
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
        purchaseState: json.purchaseState,
        consumptionState: json.consumptionState,
        orderId: json.orderId,
        purchaseType: json.purchaseType,
        acknowledgementState: json.acknowledgementState,
        purchaseToken: json.purchaseToken,
        productId: json.productId,
        quantity: json.quantity,
    };
    return productPurchase;
  }
}
