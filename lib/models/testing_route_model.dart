import 'package:flutter/material.dart';


class TestingRouteModel extends ChangeNotifier {
  //page_number: answer(String, or Map<String, String>)
  Map<int, dynamic> _answers = {};

  dynamic getAnswer(int key) => _answers[key];

  void addAnswer(int key, dynamic value) {
    print('value: $value');
    if (value is String || value is Map<String, String>) {
      _answers[key] = value;
      notifyListeners();
    }
  }

}