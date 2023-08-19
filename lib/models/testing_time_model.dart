import 'dart:async';
import 'package:flutter/material.dart';

class TestingTimeModel extends ChangeNotifier {
  late final Timer timer;
  bool isTimerActivated;
  int secondsSinceStart;
  int secondsInTotal;

  TestingTimeModel(
      {required this.isTimerActivated,
      required this.secondsSinceStart,
      required this.secondsInTotal}) {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      secondsSinceStart += 1;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
