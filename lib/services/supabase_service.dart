import 'package:client/extensions/debug_print.dart';
import 'package:client/state_models/testing_route_state_model.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//https://developers.google.com/android-publisher/api-ref/rest/v3/purchases.products
//"Possible values are: 0. Purchased 1. Canceled 2. Pending"
enum PurchaseState { purchased, canceled, pending }

//The consumption state of the inapp product. Possible values are: 0. Yet to be consumed 1. Consumed
enum ConsumptionState { notConsumed, consumed }

//The acknowledgement state of the inapp product. Possible values are: 0. Yet to be acknowledged 1. Acknowledged
enum AcknowledgementState { notAcknowledged, acknowledged }

class ProductPurchase {
  final String kind;
  final PurchaseState purchaseState;
  final ConsumptionState consumptionState;
  final String orderId;
  final AcknowledgementState acknowledgementState;

  ProductPurchase(
      {required this.kind,
      required this.purchaseState,
      required this.consumptionState,
      required this.orderId,
      required this.acknowledgementState});

  factory ProductPurchase.fromJSON(Map<String, dynamic> map) {
    return ProductPurchase(
        kind: map['kind'] as String,
        purchaseState: PurchaseState.values[map['purchaseState'] as int],
        consumptionState:
            ConsumptionState.values[map['consumptionState'] as int],
        orderId: map['orderId'] as String,
        acknowledgementState:
            AcknowledgementState.values[map['acknowledgementState'] as int]);
  }
}

class SupabaseService {
  SupabaseClient get client => Supabase.instance.client;
  const SupabaseService();

  Future<bool> sendComplaint(
      TestingRouteStateModel model, String text, bool isPremium,
      {String? userId}) async {
    try {
      await client.from('user_complaints').insert({
        'data': {
          "subjectName": model.sessionData.subjectName,
          "sessionName": model.sessionData.sessionName,
          "premium": isPremium,
          "page": model.pageIndex + 1,
          "text": text
        }.toString(),
        'user_id': userId,
      });
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("sendComplaint error: $e");
      }
      return false;
    }
  }

  Future<bool> isUserPremium(User user) async {
    dbg('call isUserPremium()');
    final res = await client.functions.invoke("is-user-premium");
    if (res.status != 200) {
      dbg('call isUserPremium() -> false, calling restorePurchases');
      await InAppPurchase.instance.restorePurchases();
      return false;
    }
    dbg('call isUserPremium() -> true');
    return true;
  }

  Future<bool> verifyPremiumPurchase(PurchaseDetails purchaseDetails) async {
    final res = await client.functions.invoke("verify-premium-purchase", body: {
      "orderId": purchaseDetails.purchaseID,
      "purchaseToken": purchaseDetails.verificationData.serverVerificationData,
      "productId": purchaseDetails.productID
    });

    if (res.status != 200) {
      return false;
    }
    return true;
  }

  //throws
  Future<ProductPurchase> getPurchaseState(
      PurchaseDetails purchaseDetails) async {
    final FunctionResponse res =
        await client.functions.invoke("get-purchase-state", body: {
      "orderId": purchaseDetails.purchaseID,
      "purchaseToken": purchaseDetails.verificationData.serverVerificationData,
      "productId": purchaseDetails.productID,
    });

    return ProductPurchase.fromJSON(Map<String, dynamic>.from(res.data));
  }

  //throws
  Future<List<String>> getPremiumText() async {
    final FunctionResponse res =
        await client.functions.invoke("get-premium-text");
    return List<String>.from(res.data);
  }
}
