import 'package:client/models/previous_attempt_model.dart';
import 'package:client/models/exam_file_adress_model.dart';

class TestingRouteData {
  final ExamFileAddressModel sessionData;
  final PreviousAttemptModel? prevSessionData;
  final bool isTimerActivated;
  final int timerSecondsInTotal;

  const TestingRouteData(
      {required this.sessionData,
      required this.prevSessionData,
      required this.isTimerActivated,
      required this.timerSecondsInTotal});
}
