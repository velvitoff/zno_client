import 'package:client/dto/session_data.dart';
import 'package:flutter/material.dart';

class SessionRouteModel extends ChangeNotifier {
  final SessionData sessionData;
  bool isTimerSelected;

  SessionRouteModel({required this.sessionData, this.isTimerSelected = false});

  void invertTimerSelected() {
    isTimerSelected = !isTimerSelected;
    notifyListeners();
  }
}
