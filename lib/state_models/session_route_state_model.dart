import 'package:client/dto/session_data.dart';
import 'package:flutter/material.dart';

class SessionRouteStateModel extends ChangeNotifier {
  final SessionData sessionData;
  bool isTimerSelected;

  SessionRouteStateModel(
      {required this.sessionData, this.isTimerSelected = false});

  void invertTimerSelected() {
    isTimerSelected = !isTimerSelected;
    notifyListeners();
  }
}
