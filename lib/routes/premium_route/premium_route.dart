import 'package:client/locator.dart';
import 'package:client/routes/premium_route/premium_page.dart';
import 'package:client/routes/premium_route/state/premium_route_state_model.dart';
import 'package:client/services/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PremiumRoute extends StatefulWidget {
  const PremiumRoute({super.key});

  @override
  State<PremiumRoute> createState() => _PremiumRouteState();
}

class _PremiumRouteState extends State<PremiumRoute> {
  late final Future<List<String>> premiumText;

  @override
  void initState() {
    super.initState();
    premiumText = locator.get<SupabaseService>().getPremiumText();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PremiumRouteStateModel(
        premiumText: premiumText,
      ),
      child: const Scaffold(
        body: PremiumPage(),
      ),
    );
  }
}
