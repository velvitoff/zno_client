import 'dart:async';
import 'package:client/extensions/debug_print.dart';
import 'package:client/locator.dart';
import 'package:client/models/auth_state_model.dart';
import 'package:client/services/dialog_service.dart';
import 'package:client/services/supabase_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchaseWrapper extends StatefulWidget {
  final Widget child;
  const InAppPurchaseWrapper({super.key, required this.child});

  @override
  State<InAppPurchaseWrapper> createState() => _InAppPurchaseWrapperState();
}

class _InAppPurchaseWrapperState extends State<InAppPurchaseWrapper> {
  late final StreamSubscription<List<PurchaseDetails>> _subscription;

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
      dbg('handlePurchaseStreamUpdate => PURCHASE STATUS: ${purchaseDetails.status}');
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
    dbg("_handleRestored getPurchaseState() -> ${prodState.purchaseState}");
    //TO DO: error handling
    if (prodState.purchaseState == PurchaseState.purchased) {
      await _handlePurchased(authState, purchaseDetails);
    }
  }

  Future<void> _handlePurchased(
      AuthStateModel authState, PurchaseDetails purchaseDetails) async {
    final bool valid = await locator
        .get<SupabaseService>()
        .verifyPremiumPurchase(purchaseDetails);
    dbg("_handlePurchased() -> The purchase is valid: $valid");
    if (valid) {
      authState.updatePremiumStatus(ignoreServer: true);
    } else {
      _showErrorDialog("Помилка валідації покупки");
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
