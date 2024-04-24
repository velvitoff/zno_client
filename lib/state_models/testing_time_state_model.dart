import 'dart:async';
import 'package:flutter/material.dart';

class TestingTimeStateModel extends ChangeNotifier {
  late final Timer timer;
  bool isTimerActivated;
  int secondsSinceStart;
  int secondsInTotal;
  bool isViewMode;

  void switchIsActivated() {
    isTimerActivated = !isTimerActivated;
    notifyListeners();
  }

  TestingTimeStateModel(
      {required this.isTimerActivated,
      required this.secondsSinceStart,
      required this.secondsInTotal,
      required this.isViewMode}) {
    if (!isViewMode) {
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        secondsSinceStart += 1;
        notifyListeners();
      });
    } else {
      timer = Timer(const Duration(seconds: 0), () {});
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
