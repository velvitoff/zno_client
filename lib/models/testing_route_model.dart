import 'package:flutter/material.dart';

import '../dto/previous_session_data.dart';
import '../dto/question_data.dart';
import '../dto/session_data.dart';


class TestingRouteModel extends ChangeNotifier {
  final SessionData sessionData;
  final PreviousSessionData? prevSessionData;
  final List<Question> questions;

  //page_number: answer(String, or Map<String, String>)
  Map<String, dynamic> _answers = {};
  PageController pageController = PageController();
  int _pageIndex = 0;

  TestingRouteModel({
    required this.sessionData,
    required this.questions,
    required this.prevSessionData
  }) {
    if (prevSessionData != null) {
      _answers = prevSessionData!.answers;
    }
  }


  dynamic getAnswer(String key) => _answers[key];

  int get pageAmount => questions.length;
  int get pageIndex => _pageIndex;
  Map<String, dynamic> get allAnswers => _answers;

  void addAnswer(String key, dynamic value) {
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