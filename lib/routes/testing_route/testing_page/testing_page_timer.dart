import 'package:client/models/testing_time_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestingPageTimer extends StatelessWidget {
  const TestingPageTimer({super.key});

  @override
  Widget build(BuildContext context) {
    final timeData = context.select<TestingTimeModel, (int, int)>(
        (value) => (value.secondsSinceStart, value.secondsInTotal));
    if (timeData.$2 - timeData.$1 <= 0) {
      return const Text('0');
    }
    return Text('${timeData.$2 - timeData.$1}');
  }
}
