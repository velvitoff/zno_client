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
      print('PURCHASE STATUS: ${purchaseDetails.status}');
      switch (purchaseDetails.status) {
        case PurchaseStatus.error:
          _showErrorDialog("Помилка при спробі купівлі");
          break;
        case PurchaseStatus.canceled:
          _showErrorDialog("Купівлю відмінено");
          break;
        case PurchaseStatus.pending:
          break;
        case PurchaseStatus.restored:
          await _handleRestored(authStateModel, purchaseDetails);
          break;
        case PurchaseStatus.purchased:
          await _handlePurchased(authStateModel, purchaseDetails);
          break;
      }
    }
  }

  Future<void> _handleRestored(
      AuthStateModel authState, PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.purchaseID == null) {
      return;
    }
    final ProductPurchase prodState =
        await locator.get<SupabaseService>().getPurchaseState(purchaseDetails);
    //TO DO: error handling
    if (prodState.purchaseState == PurchaseState.purchased) {
      await _handlePurchased(authState, purchaseDetails);
    }
  }

  Future<void> _handlePurchased(
      AuthStateModel authState, PurchaseDetails purchaseDetails) async {
    print('_handlePurchased');
    final bool valid = await locator
        .get<SupabaseService>()
        .verifyPremiumPurchase(purchaseDetails);
    print('received response');
    if (valid) {
      authState.updatePremiumStatusFromServer();
    } else {
      _showErrorDialog("Помилка валідації покупки");
    }
  }

  void onClickBuy(ProductDetails productDetails) async {
    await InAppPurchase.instance.buyNonConsumable(
        purchaseParam: PurchaseParam(productDetails: productDetails));
    await InAppPurchase.instance.restorePurchases();
  }

  void onClickRestore(ProductDetails productDetails) async {
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
              return Column(
                children: [
                  GestureDetector(
                    onTap: () => onClickBuy(prodDetails),
                    child: Container(
                      color: Colors.black,
                      height: 40.h,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () => onClickRestore(prodDetails),
                    child: Container(
                      color: Colors.black,
                      height: 40.h,
                    ),
                  )
                ],
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
