import 'package:client/state_models/session_route_state_model.dart';
import 'package:flutter/material.dart';
import 'package:client/models/exam_file_adress_model.dart';
import 'package:provider/provider.dart';

class SessionRouteProvider extends StatelessWidget {
  final ExamFileAdressModel sessionData;
  final Widget child;

  const SessionRouteProvider(
      {Key? key, required this.sessionData, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SessionRouteStateModel(sessionData: sessionData),
      child: child,
    );
  }
}
