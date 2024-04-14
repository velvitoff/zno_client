import 'package:client/dto/testing_route_data.dart';
import 'package:client/models/testing_time_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dto/test_data.dart';
import '../models/testing_route_model.dart';

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
            final prevData = data.prevSessionData;
            if (prevData != null) {
              return TestingTimeModel(
                  isTimerActivated: prevData.isTimerActivated,
                  secondsSinceStart: prevData.timerSeconds,
                  secondsInTotal: prevData.timerSecondsInTotal,
                  isViewMode: prevData.completed);
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
