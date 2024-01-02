import 'package:client/models/testing_route_model.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseClient get client => Supabase.instance.client;

  const SupabaseService();

  Future<bool> sendComplaint(
      TestingRouteModel model, String text, bool isPremium,
      {String? id}) async {
    try {
      await client.from('user_complaints').insert({
        'id': id,
        'data': {
          "subjectName": model.sessionData.subjectName,
          "sessionName": model.sessionData.sessionName,
          "premium": isPremium,
          "page": model.pageIndex + 1,
          "text": text
        }.toString()
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> verifyPremiumPurchase(PurchaseDetails purchaseDetails) async {
    final res = await client.functions.invoke("verify-premium-purchase", body: {
      "purchaseId": purchaseDetails.purchaseID,
      "productId": purchaseDetails.productID,
      "verificationData": purchaseDetails.verificationData,
      "transactionDate": purchaseDetails.transactionDate,
      "status": purchaseDetails.status.name
    });
    if (res.status != 200) {
      return false;
    }
    return false;
  }
}
