import 'package:client/routes/premium_route/premium_page.dart';
import 'package:client/routes/premium_route/state/premium_route_state_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PremiumRoute extends StatelessWidget {
  const PremiumRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PremiumRouteStateModel(),
      child: const Scaffold(
        body: PremiumPage(),
      ),
    );
  }
}
