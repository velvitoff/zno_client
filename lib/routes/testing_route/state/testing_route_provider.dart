import 'package:client/routes/testing_route/state/testing_route_input_data.dart';
import 'package:client/routes/testing_route/state/testing_time_state_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/exam_file_model.dart';
import 'testing_route_state_model.dart';

class TestingRouteProvider extends StatelessWidget {
  final ExamFileModel testData;
  final TestingRouteInputData data;
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
            create: (context) => TestingRouteStateModel(
                questions: testData.questions,
                sessionData: data.examFileAddress,
                prevSessionData: data.prevAttemptModel)),
        ChangeNotifierProvider(
          create: (context) {
            final prevData = data.prevAttemptModel;
            if (prevData != null) {
              return TestingTimeStateModel(
                  isTimerActivated: prevData.isTimerActivated,
                  secondsSinceStart: prevData.timerSeconds,
                  isViewMode: prevData.completed);
            }
            return TestingTimeStateModel(
                isTimerActivated: data.isTimerActivated,
                secondsSinceStart: 0,
                isViewMode: false);
          },
        )
      ],
      child: child,
    );
  }
}
