import 'package:client/locator.dart';
import 'package:client/services/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PremiumRouteStateModel extends ChangeNotifier {
  late Future<List<String>> premiumText;

  PremiumRouteStateModel() {
    _updatePremiumText();
  }

  void _updatePremiumText({bool notify = false}) {
    premiumText = locator.get<SupabaseService>().getPremiumText();
    if (!notify) return;
    notifyListeners();
  }

  void onBack(BuildContext context) {
    if (!context.canPop()) return;
    context.pop();
  }
}
