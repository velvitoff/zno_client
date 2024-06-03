import 'package:client/locator.dart';
import 'package:client/models/previous_attempt_model.dart';
import 'package:client/services/storage_service.dart';
import 'package:client/services/testing_route_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HistoryRouteStateModel extends ChangeNotifier {
  late Future<List<PreviousAttemptModel>> previousAttempts;

  HistoryRouteStateModel() {
    _updatePreviousAttempts();
  }

  void onBack(BuildContext context) {
    if (!context.canPop()) return;
    context.pop();
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
    previousAttempts = locator
        .get<StorageService>()
        .getPreviousAttemptsListGlobal()
        .then((list) {
      list.sort((a, b) => b.date.compareTo(a.date));
      return list;
    });
    if (notify) {
      notifyListeners();
    }
  }
}
