import 'package:client/dto/answers/answer.dart';
import 'package:flutter/material.dart';
import '../dto/previous_session_data.dart';
import '../dto/questions/question.dart';
import '../dto/session_data.dart';

class TestingRouteModel extends ChangeNotifier {
  final SessionData sessionData;
  final List<Question> questions;
  PreviousSessionData? prevSessionData;

  //page_number: answer(String, or Map<String, String> or List<String>)
  Map<String, Answer?> _answers = {};
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

  Answer? getAnswer(int key) => _answers[key.toString()];
  Map<String, Answer?> get allAnswers => _answers;

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

  void addAnswerSingle(int key, String value) {
    final question = questions[key - 1] as QuestionSingle;
    final answer = _answers[key.toString()] as AnswerSingle?;
    Answer? result;

    if (answer == null) {
      result = AnswerSingle([value]);
    } else if (answer.data.contains(value)) {
      final newAnswerData = [...answer.data];
      newAnswerData.remove(value);
      result = AnswerSingle(newAnswerData);
    } else if (question.correct.length == 1) {
      result = AnswerSingle([value]);
    } else if (answer.data.length < question.correct.length) {
      final newAnswerData = [...answer.data];
      newAnswerData.add(value);
      result = AnswerSingle(newAnswerData);
    } else {
      return;
    }

    _answers[key.toString()] = result;
    notifyListeners();
  }

  void addAnswerComplex(int key, String newAnswerKey, String newAnswerValue) {
    final answer = _answers[key.toString()] as AnswerComplex?;
    Answer? result;

    if (answer == null) {
      result = AnswerComplex({newAnswerKey: newAnswerValue});
    } else if (answer.data[newAnswerKey] == newAnswerValue) {
      var newData = Map<String, String>.from(answer.data);
      newData.remove(newAnswerKey);
      result = AnswerComplex(newData);
    } else {
      var newData = Map<String, String>.from(answer.data);
      newData[newAnswerKey] = newAnswerValue;
      result = AnswerComplex(newData);
    }

    _answers[key.toString()] = result;
    notifyListeners();
  }

  void addAnswerTextFields(int key, int answerIndex, String newAnswer) {
    final question = questions[key - 1] as QuestionTextFields;
    final answer = _answers[key.toString()] as AnswerTextFields?;
    Answer? result;

    if (answer == null) {
      var newData = List<String>.filled(question.correctList.length, "");
      newData[answerIndex] = newAnswer;
      result = AnswerTextFields(newData);
    } else {
      var newData = [...answer.data];
      newData[answerIndex] = newAnswer;
      result = AnswerTextFields(newData);
    }

    _answers[key.toString()] = result;
    notifyListeners();
  }
}
