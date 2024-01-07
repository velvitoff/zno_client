import 'dart:async';
import 'package:client/locator.dart';
import 'package:client/models/auth_state_model.dart';
import 'package:client/services/dialog_service.dart';
import 'package:client/services/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';

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
      _handlePurchaseStreamUpdate(context, purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      _showErrorDialog("Помилка зв'яку з магазином");
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _showErrorDialog(String text) {
    locator.get<DialogService>().showInfoDialog(context, text, 230.h);
  }

  Future<void> _handlePurchaseStreamUpdate(
      BuildContext context, List<PurchaseDetails> purchaseDetailsList) async {
    final authStateModel = context.read<AuthStateModel>();
    for (var purchaseDetails in purchaseDetailsList) {
      print(purchaseDetails.status);
      if (purchaseDetails.status == PurchaseStatus.restored) {
        print('${purchaseDetails.purchaseID}');
        if (purchaseDetails.purchaseID != null) {
          final state = await locator.get<SupabaseService>().getPurchaseState(
              purchaseDetails.productID, purchaseDetails.purchaseID!);
          print('PURCHASE STATE IS ${state}');
        }
      }
      if (purchaseDetails.status == PurchaseStatus.error) {
        _showErrorDialog("Помилка при спробі купівлі");
        return;
      }
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        bool valid = await _verifyPurchase(purchaseDetails);
        if (valid) {
          authStateModel.updatePremiumStatusFromServer();
        } else {
          _showErrorDialog("Помилка валідації покупки");
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

  void onClick(ProductDetails productDetails) async {
    //await InAppPurchase.instance.buyNonConsumable(
    //    purchaseParam: PurchaseParam(productDetails: productDetails));
    await InAppPurchase.instance.restorePurchases();
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
                  height: 40.h,
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
