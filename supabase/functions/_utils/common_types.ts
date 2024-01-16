export interface PurchaseVerificationData {
    localVerificationData: string,
    serverVerificationData: string,
    source: string,
}
  
export interface PurchaseDetails {
    purchaseToken: string,
    productId: string,
    orderId: string
  }