import 'dart:async';

import 'package:client/locator.dart';
import 'package:client/services/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const Set<String> _kIds = <String>{'zno_client_premium'};

class ButtonGooglePay extends StatefulWidget {
  const ButtonGooglePay({super.key});

  @override
  State<ButtonGooglePay> createState() => _ButtonGooglePayState();
}

class _ButtonGooglePayState extends State<ButtonGooglePay> {
  late final StreamSubscription<List<PurchaseDetails>> _subscription;

  final Future<bool> isStoreAvailable = InAppPurchase.instance.isAvailable();
  final Future<ProductDetails> productDetails = InAppPurchase.instance
      .queryProductDetails(_kIds)
      .then((response) => response.productDetails
          .where((e) => e.id == "zno_client_premium")
          .first);

  @override
  void initState() {
    _subscription =
        InAppPurchase.instance.purchaseStream.listen((purchaseDetailsList) {
      _handlePurchaseStreamUpdate(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<void> _handlePurchaseStreamUpdate(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        //_showPendingUI();
        return;
      }
      if (purchaseDetails.status == PurchaseStatus.error) {
        //_handleError(purchaseDetails.error!);
        return;
      }
      if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        bool valid = await _verifyPurchase(purchaseDetails);
        if (valid) {
          print("VERIFIED");
          //_deliverProduct(purchaseDetails);
        } else {
          //_handleInvalidPurchase(purchaseDetails);
        }
        return;
      }
      if (purchaseDetails.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    return locator
        .get<SupabaseService>()
        .verifyPremiumPurchase(purchaseDetails);
  }

  //error handle
  void onClick(ProductDetails productDetails) async {
    await InAppPurchase.instance.buyNonConsumable(
        purchaseParam: PurchaseParam(productDetails: productDetails));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([isStoreAvailable, productDetails]),
        builder: ((BuildContext context, AsyncSnapshot<List<Object>> snapshot) {
          if (snapshot.hasData) {
            final isAvailable = snapshot.data![0] as bool;
            final prodDetails = snapshot.data![1] as ProductDetails;
            if (isAvailable) {
              return GestureDetector(
                onTap: () => onClick(prodDetails),
                child: Container(
                  color: Colors.black,
                  height: 30.h,
                ),
              );
            }
            return const Text('Немає зв\'язку з магазином');
          } else if (snapshot.hasError) {
            return const Text('Помилка завантаження');
          } else {
            return const CircularProgressIndicator(
              color: Color(0xFF428449),
            );
          }
        }));
  }
}
