import 'package:client/locator.dart';
import 'package:client/models/exam_file_adress_model.dart';
import 'package:client/models/previous_attempt_model.dart';
import 'package:client/routes.dart';
import 'package:client/routes/testing_route/state/testing_route_input_data.dart';
import 'package:client/services/dialog_service.dart';
import 'package:client/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SessionRouteStateModel extends ChangeNotifier {
  final ExamFileAddressModel sessionData;
  bool isTimerSelected;
  late Future<List<PreviousAttemptModel>> previousAttempts;

  SessionRouteStateModel({
    required this.sessionData,
    this.isTimerSelected = false,
  }) {
    _updatePreviousAttempts();
  }

  void invertTimerSelected() {
    isTimerSelected = !isTimerSelected;
    notifyListeners();
  }

  void onStartAttempt(
    BuildContext context,
  ) {
    if (!isTimerSelected) {
      _pushTestingRoute(context, sessionData, null);
      return;
    }

    locator
        .get<DialogService>()
        .showTimeChoiceDialog(context)
        .then((int? value) {
      if (value == null) return;
      _pushTestingRoute(context, sessionData, value);
    });
  }

  void _updatePreviousAttempts({bool notify = false}) {
    previousAttempts = locator.get<StorageService>().getPreviousAttemptsList(
          sessionData.folderName,
          sessionData.fileNameNoExtension,
        );
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> _pushTestingRoute(BuildContext context,
      ExamFileAddressModel examFileAddress, int? timeValue) async {
    // Testing Route returns true if a new attempt file was created
    final response = await context.push(
      Routes.testingRoute,
      extra: TestingRouteInputData(
        examFileAddress: examFileAddress,
        prevAttemptModel: null,
        isTimerActivated: false,
        timerSecondsInTotal: timeValue ?? 7200,
      ),
    );
    if (response is! bool) return;
    if (!response) return;

    _updatePreviousAttempts(notify: true);
  }
}
