import 'package:client/models/testing_route_model.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//"Possible values are: 0. Purchased 1. Canceled 2. Pending"
enum PurchaseState { purchased, canceled, pending }

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

  Future<bool> isUserPremium(User user) async {
    try {
      final List<dynamic> response = await client
          .from('premium_public_view')
          .select('is_premium')
          .eq('user', user.id);
      if (response.length != 1) {
        return false;
      }

      return Map<String, dynamic>.from(response[0])['is_premium'] as bool;
    } catch (e) {
      if (kDebugMode) {
        print('userHasPremium() threw an error: $e');
      }
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

  Future<PurchaseState?> getPurchaseState(
      PurchaseDetails purchaseDetails) async {
    /*
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
    */
    final FunctionResponse res;
    print(
        'productId: ${purchaseDetails.productID}, purchaseId: ${purchaseDetails.purchaseID}');
    try {
      res = await client.functions.invoke("get-purchase-state", body: {
        "purchaseId": purchaseDetails.verificationData.serverVerificationData,
        "productId": purchaseDetails.productID,
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }

    print(res.status);
    if (res.status != 200) {
      return null;
    }
    final int stateNumber;
    try {
      stateNumber = res.data["purchaseState"] as int;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
    switch (stateNumber) {
      case 0:
        return PurchaseState.purchased;
      case 1:
        return PurchaseState.canceled;
      case 2:
        return PurchaseState.pending;
      default:
        return null;
    }
  }
}
