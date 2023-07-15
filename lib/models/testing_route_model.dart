import 'package:flutter/material.dart';
import '../dto/previous_session_data.dart';
import '../dto/question_data.dart';
import '../dto/session_data.dart';

class TestingRouteModel extends ChangeNotifier {
  final SessionData sessionData;
  final PreviousSessionData? prevSessionData;
  final List<Question> questions;

  //page_number: answer(String, or Map<String, String> or List<String>)
  Map<String, dynamic> _answers = {};
  late PageController pageController;
  int _pageIndex = 0;

  TestingRouteModel(
      {required this.sessionData,
      required this.questions,
      required this.prevSessionData}) {
    if (prevSessionData != null) {
      _answers = prevSessionData!.answers;
      int lastPage = prevSessionData != null ? prevSessionData!.lastPage : 0;
      pageController = PageController(initialPage: lastPage);
      _pageIndex = lastPage;
    } else {
      pageController = PageController();
    }
  }

  bool get isViewMode => prevSessionData?.completed ?? false;

  int get pageAmount => questions.length;
  int get pageIndex => _pageIndex;

  dynamic getAnswer(String key) => _answers[key];
  Map<String, dynamic> get allAnswers => _answers;

  void addAnswer(String key, dynamic value) {
    if (value is String ||
        value is Map<String, String> ||
        value is List<String>) {
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
    if (_pageIndex < pageAmount - 1) {
      _pageIndex++;
      pageController.nextPage(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOutSine);
      notifyListeners();
    }
  }

  void decrementPage() {
    if (_pageIndex > 0) {
      _pageIndex--;
      pageController.previousPage(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOutSine);
      notifyListeners();
    }
  }
}
