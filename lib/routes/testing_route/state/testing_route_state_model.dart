import 'dart:typed_data';

import 'package:client/auth/state/auth_state_model.dart';
import 'package:client/locator.dart';
import 'package:client/models/answers/answer.dart';
import 'package:client/models/exam_file_adress_model.dart';
import 'package:client/models/previous_attempt_model.dart';
import 'package:client/models/questions/question.dart';
import 'package:client/routes.dart';
import 'package:client/routes/image_view_route/state/image_view_route_input_data.dart';
import 'package:client/routes/testing_route/state/testing_time_state_model.dart';
import 'package:client/services/dialog_service.dart';
import 'package:client/services/storage_service.dart';
import 'package:client/services/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TestingRouteStateModel extends ChangeNotifier {
  final ExamFileAddressModel sessionData;
  final List<Question> questions;
  PreviousAttemptModel? prevSessionData;

  //page_number: answer(String, or Map<String, String> or List<String>)
  Map<String, Answer?> _answers = {};
  late PageController pageController;
  int _pageIndex = 0;

  TestingRouteStateModel(
      {required this.sessionData,
      required this.questions,
      required this.prevSessionData}) {
    _answers = prevSessionData?.answers ?? {};
    if (prevSessionData != null) {
      int lastPage = prevSessionData!.lastPage;
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

  Future<void> onExit(
    BuildContext context,
    TestingTimeStateModel timeStateModel,
    bool isCompleted,
  ) async {
    if (isViewMode || allAnswers.isEmpty) {
      if (!context.canPop()) return;
      context.pop(false);
      return;
    }

    final result = await locator.get<StorageService>().saveSessionEnd(
          this,
          timeStateModel,
          isCompleted,
        );

    if (result == null) return;
    if (!context.mounted) return;
    if (!context.canPop()) return;

    context.pop(true);
  }

  Future<bool> onComplaint(
      BuildContext context, AuthStateModel authModel) async {
    String? text =
        await locator.get<DialogService>().showComplaintDialog(context);

    if (text == null || text == "") return false;

    final complaintResponse =
        await locator.get<SupabaseService>().sendComplaint(
              this,
              text,
              authModel.isPremium,
              userId: authModel.currentUser?.id,
            );

    return complaintResponse;
  }

  void onOpenImage(BuildContext context, Uint8List image) {
    context.push(
      Routes.imageViewRoute,
      extra: ImageViewRouteInputData(
        imageProvider: MemoryImage(image),
      ),
    );
  }
}
