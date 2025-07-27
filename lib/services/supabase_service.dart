import 'package:client/routes/testing_route/state/testing_route_state_model.dart';
import 'package:flutter/foundation.dart';
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
    TestingRouteStateModel model,
    String text,
  ) async {
    try {
      await client.from('user_complaints').insert({
        'data': {
          "subjectName": model.sessionData.subjectName,
          "sessionName": model.sessionData.sessionName,
          "page": model.pageIndex + 1,
          "text": text
        }.toString(),
      });
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("sendComplaint error: $e");
      }
      return false;
    }
  }
}
