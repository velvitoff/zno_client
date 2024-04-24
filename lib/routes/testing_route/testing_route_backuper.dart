import 'dart:async';

import 'package:client/models/answers/answer.dart';
import 'package:client/locator.dart';
import 'package:client/state_models/testing_route_state_model.dart';
import 'package:client/state_models/testing_time_state_model.dart';
import 'package:client/services/storage_service/main_storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestingRouteBackuper extends StatefulWidget {
  final Widget child;
  const TestingRouteBackuper({super.key, required this.child});

  @override
  State<TestingRouteBackuper> createState() => _TestingRouteBackuperState();
}

class _TestingRouteBackuperState extends State<TestingRouteBackuper> {
  late final Timer timer;
  //a snapshot of answers 30 seconds ago
  Map<String, Answer?>? answersCopy;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      final model = context.read<TestingRouteStateModel>();
      if (_isBackupNecessary(model)) {
        await _handleBackup(model);
      }
      answersCopy = Map.from(model.allAnswers);
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  bool _isBackupNecessary(TestingRouteStateModel model) {
    if (model.isViewMode) return false;
    if (mapEquals(model.allAnswers, answersCopy)) return false;
    if (model.allAnswers.isEmpty) return false;
    return true;
  }

  Future<void> _handleBackup(TestingRouteStateModel model) async {
    await locator
        .get<MainStorageService>()
        .saveSessionEnd(model, context.read<TestingTimeStateModel>(),
            model.prevSessionData?.completed ?? false)
        .then((data) {
      context.read<TestingRouteStateModel>().prevSessionData = data;
    });
  }
}
