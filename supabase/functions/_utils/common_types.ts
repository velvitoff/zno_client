export interface PurchaseVerificationData {
    localVerificationData: string,
    serverVerificationData: string,
    source: string,
}
  
export interface PurchaseDetails {
    purchaseId: string,
    productId: string,
    verificationData: PurchaseVerificationData,
    transactionDate?: string,
    status: string, // pending, purchased, error, restored, canceled
  }