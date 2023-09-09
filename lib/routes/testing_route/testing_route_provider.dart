import 'package:client/dto/testing_route_data.dart';
import 'package:client/models/testing_time_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../dto/test_data.dart';
import '../../models/testing_route_model.dart';

class TestingRouteProvider extends StatelessWidget {
  final TestData testData;
  final TestingRouteData data;
  final Widget child;

  const TestingRouteProvider(
      {Key? key,
      required this.testData,
      required this.data,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => TestingRouteModel(
                questions: testData.questions,
                sessionData: data.sessionData,
                prevSessionData: data.prevSessionData)),
        ChangeNotifierProvider(
          create: (context) {
            if (data.prevSessionData != null) {
              return TestingTimeModel(
                  isTimerActivated: data.prevSessionData!.isTimerActivated,
                  secondsSinceStart: data.prevSessionData!.timerSeconds,
                  secondsInTotal: data.prevSessionData!.timerSecondsInTotal,
                  isViewMode: data.prevSessionData!.completed);
            }
            return TestingTimeModel(
                isTimerActivated: data.isTimerActivated,
                secondsSinceStart: 0,
                secondsInTotal: data.timerSecondsInTotal,
                isViewMode: false);
          },
        )
      ],
      child: child,
    );
  }
}
