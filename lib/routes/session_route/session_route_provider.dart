import 'package:client/models/session_route_model.dart';
import 'package:flutter/material.dart';
import 'package:client/dto/session_data.dart';
import 'package:provider/provider.dart';

class SessionRouteProvider extends StatelessWidget {
  final SessionData sessionData;
  final Widget child;

  const SessionRouteProvider({
    Key? key,
    required this.sessionData,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SessionRouteModel(sessionData: sessionData),
      child: child,
    );
  }
}
