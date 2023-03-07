import 'package:flutter/material.dart';


class TestingRouteModel extends ChangeNotifier {
  //page_number: answer(String, or Map<String, String>)
  Map<int, dynamic> _answers = {};
  final String subjectFolderName;
  final String sessionFileName;
  PageController pageController = PageController();
  int _pageIndex = 0;
  final int pageAmount;

  TestingRouteModel({
    required this.pageAmount,
    required this.subjectFolderName,
    required this.sessionFileName
  });

  dynamic getAnswer(int key) => _answers[key];

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