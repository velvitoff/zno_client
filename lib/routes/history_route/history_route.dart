import 'package:client/routes/history_route/history_page.dart';
import 'package:flutter/material.dart';
import 'package:client/routes/history_route/state/history_route_state_model.dart';
import 'package:provider/provider.dart';

class HistoryRoute extends StatelessWidget {
  const HistoryRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HistoryRouteStateModel(),
      child: const Scaffold(
        body: HistoryPage(),
      ),
    );
  }
}
