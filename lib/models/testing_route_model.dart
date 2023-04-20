import 'package:flutter/material.dart';

import '../dto/session_data.dart';


class TestingRouteModel extends ChangeNotifier {
  //page_number: answer(String, or Map<String, String>)
  Map<int, dynamic> _answers = {};
  final SessionData sessionData;
  PageController pageController = PageController();
  int _pageIndex = 0;
  int pageAmount;

  TestingRouteModel({
    required this.pageAmount,
    required this.sessionData
  });

  void setPageAmount(int i) => pageAmount = i;

  dynamic getAnswer(int key) => _answers[key];

  int get pageIndex => _pageIndex;
  Map<int, dynamic> get allAnswers => _answers;

  void addAnswer(int key, dynamic value) {
    if (value is String || value is Map<String, String>) {
      _answers[key] = value;
      notifyListeners();
    }
  }

  void jumpPage(int index) {
    if (index >= 0 && index < pageAmount) {
      _pageIndex = index;
      pageController.jumpToPage(index);
      notifyListeners();
    }
  }

  void incrementPage() {
    if (_pageIndex < pageAmount-1) {
      _pageIndex++;
      pageController.nextPage(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOutSine
      );
      notifyListeners();
    }
  }

  void decrementPage() {
    if(_pageIndex > 0) {
      _pageIndex--;
      pageController.previousPage(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOutSine
      );
      notifyListeners();
    }
  }

  int getPageIndex() => _pageIndex;



}