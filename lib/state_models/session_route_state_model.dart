import 'package:client/models/exam_file_adress_model.dart';
import 'package:flutter/material.dart';

class SessionRouteStateModel extends ChangeNotifier {
  final ExamFileAdressModel sessionData;
  bool isTimerSelected;

  SessionRouteStateModel(
      {required this.sessionData, this.isTimerSelected = false});

  void invertTimerSelected() {
    isTimerSelected = !isTimerSelected;
    notifyListeners();
  }
}
