import 'package:client/state_models/storage_route_state_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StorageRouteProvider extends StatelessWidget {
  final Widget child;

  const StorageRouteProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StorageRouteStateModel(fileMap: {}),
      child: child,
    );
  }
}
