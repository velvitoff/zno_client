import 'package:client/routes/history_route/state/history_route_state_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryRouteProvider extends StatelessWidget {
  final Widget child;
  const HistoryRouteProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HistoryRouteStateModel(sessionsList: []),
      child: child,
    );
  }
}
