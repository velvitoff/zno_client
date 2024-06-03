import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PremiumRouteStateModel extends ChangeNotifier {
  final Future<List<String>> premiumText;

  PremiumRouteStateModel({required this.premiumText});

  void onBack(BuildContext context) {
    if (!context.canPop()) return;
    context.pop();
  }
}
