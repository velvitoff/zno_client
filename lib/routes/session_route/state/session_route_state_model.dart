import 'package:client/locator.dart';
import 'package:client/models/exam_file_adress_model.dart';
import 'package:client/models/previous_attempt_model.dart';
import 'package:client/services/storage_service.dart';
import 'package:client/services/testing_route_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SessionRouteStateModel extends ChangeNotifier {
  final ExamFileAddressModel inputSessionData;
  bool isTimerSelected;
  late Future<List<PreviousAttemptModel>> previousAttempts;

  SessionRouteStateModel({
    required this.inputSessionData,
    this.isTimerSelected = false,
  }) {
    _updatePreviousAttempts();
  }

  void invertTimerSelected() {
    isTimerSelected = !isTimerSelected;
    notifyListeners();
  }

  void onBack(BuildContext context) {
    if (!context.canPop()) return;
    context.pop();
  }

  Future<void> onStartAttempt(
    BuildContext context,
  ) async {
    final response = await locator.get<TestingRouteService>().onStartAttempt(
          context,
          this,
        );
    _updatePreviousAttempts(notify: response);
  }

  Future<void> onRestoreAttempt(
    BuildContext context,
    PreviousAttemptModel previousAttemptModel,
  ) async {
    final response = await locator
        .get<TestingRouteService>()
        .onRestoreAttempt(context, previousAttemptModel);
    _updatePreviousAttempts(notify: response);
  }

  void _updatePreviousAttempts({bool notify = false}) {
    previousAttempts = locator.get<StorageService>().getPreviousAttemptsList(
          inputSessionData.folderName,
          inputSessionData.fileNameNoExtension,
        );
    if (notify) {
      notifyListeners();
    }
  }
}
