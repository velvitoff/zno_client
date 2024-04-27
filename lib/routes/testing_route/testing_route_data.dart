import 'package:client/models/previous_attempt_model.dart';
import 'package:client/models/exam_file_adress_model.dart';

class TestingRouteData {
  final ExamFileAddressModel examFileAddress;
  final PreviousAttemptModel? prevAttemptModel;
  final bool isTimerActivated;
  final int timerSecondsInTotal;

  const TestingRouteData(
      {required this.examFileAddress,
      required this.prevAttemptModel,
      required this.isTimerActivated,
      required this.timerSecondsInTotal});
}
