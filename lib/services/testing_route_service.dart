import 'package:client/locator.dart';
import 'package:client/models/exam_file_adress_model.dart';
import 'package:client/models/previous_attempt_model.dart';
import 'package:client/routes.dart';
import 'package:client/routes/session_route/state/session_route_state_model.dart';
import 'package:client/routes/testing_route/state/testing_route_input_data.dart';
import 'package:client/services/dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Every function here eturns a bool that
// shows whether history files have updated
// after the testing route was popped
class TestingRouteService {
  const TestingRouteService();

  Future<bool> onStartAttempt(
    BuildContext context,
    SessionRouteStateModel sessionRouteModel,
  ) async {
    if (!sessionRouteModel.isTimerSelected) {
      return await _pushTestingRoute(
          context, sessionRouteModel.inputSessionData);
    }

    int? timeValue =
        await locator.get<DialogService>().showTimeChoiceDialog(context);
    if (timeValue == null) return false;

    if (!context.mounted) return false;
    return await _pushTestingRoute(
      context,
      sessionRouteModel.inputSessionData,
      timeValue: timeValue,
      isTimerActivated: sessionRouteModel.isTimerSelected,
    );
  }

  Future<bool> onRestoreAttempt(
    BuildContext context,
    PreviousAttemptModel previousAttemptModel,
  ) async {
    return await _pushTestingRoute(
      context,
      ExamFileAddressModel.fromPreviousAttemptModel(previousAttemptModel),
      prevAttemptModel: previousAttemptModel,
      isTimerActivated: previousAttemptModel.isTimerActivated,
      timeValue: previousAttemptModel.timerSecondsInTotal,
    );
  }

  Future<bool> _pushTestingRoute(
    BuildContext context,
    ExamFileAddressModel examFileAddress, {
    int? timeValue,
    PreviousAttemptModel? prevAttemptModel,
    bool isTimerActivated = false,
  }) async {
    // Testing Route returns true if a new attempt file was created
    final response = await context.push(
      Routes.testingRoute,
      extra: TestingRouteInputData(
        examFileAddress: examFileAddress,
        prevAttemptModel: prevAttemptModel,
        isTimerActivated: isTimerActivated,
        timerSecondsInTotal: timeValue ?? 7200,
      ),
    );

    if (response is! bool) return false;
    if (!response) return false;

    return true;
  }
}
