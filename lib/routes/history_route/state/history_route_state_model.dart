import 'package:client/locator.dart';
import 'package:client/models/previous_attempt_model.dart';
import 'package:client/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HistoryRouteStateModel extends ChangeNotifier {
  late Future<List<PreviousAttemptModel>> previousAttempts;

  HistoryRouteStateModel() {
    _updatePreviousAttempts();
  }

  void _updatePreviousAttempts({bool notify = false}) {
    previousAttempts =
        locator.get<StorageService>().getPreviousAttemptsListGlobal();
    if (!notify) return;
    notifyListeners();
  }

  void onBack(BuildContext context) {
    if (!context.canPop()) return;
    context.pop();
  }
}
