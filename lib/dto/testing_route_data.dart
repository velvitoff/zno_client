import 'package:client/dto/previous_session_data.dart';
import 'package:client/dto/session_data.dart';

class TestingRouteData {
  final SessionData sessionData;
  final PreviousSessionData? prevSessionData;
  final bool isTimerActivated;
  final int timerSecondsInTotal;

  const TestingRouteData(
      {required this.sessionData,
      required this.prevSessionData,
      required this.isTimerActivated,
      required this.timerSecondsInTotal});
}
