import 'dart:convert';

import 'package:client/models/answers/answer.dart';
import 'package:client/models/exam_file_adress_model.dart';
import 'package:client/models/questions/question.dart';
import 'package:client/routes/testing_route/state/testing_time_state_model.dart';

import '../routes/testing_route/state/testing_route_state_model.dart';

class PreviousAttemptModel {
  final String sessionName;
  final String subjectName;
  final String fileName;
  final String folderName;
  final String sessionId;
  final DateTime date;
  final bool completed;
  final int lastPage;
  final bool isTimerActivated;
  final int timerSeconds;
  final int timerSecondsInTotal;
  final Map<String, Answer?> answers;
  final String? score;

  const PreviousAttemptModel(
      {required this.sessionName,
      required this.subjectName,
      required this.fileName,
      required this.folderName,
      required this.sessionId,
      required this.date,
      required this.completed,
      required this.lastPage,
      required this.isTimerActivated,
      required this.timerSeconds,
      required this.timerSecondsInTotal,
      required this.answers,
      required this.score});

  bool get isEditable => !completed;

  factory PreviousAttemptModel.fromJson(Map<String, dynamic> map) =>
      PreviousAttemptModel(
          sessionName: ExamFileAddressModel.fileNameNoExtensionToSessionName(
              map['session_name'] as String),
          subjectName: map['subject_name'] as String,
          fileName: map['file_name'] as String,
          folderName: map['folder_name'] as String,
          sessionId: map['session_id'] as String,
          date: DateTime.fromMicrosecondsSinceEpoch(
              int.parse(map['date'] as String)),
          completed: map['completed'] as bool,
          lastPage: map['last_page'],
          isTimerActivated: map['is_timer_activated'] != null
              ? map['is_timer_activated'] as bool
              : false,
          timerSeconds:
              map['timer_seconds'] != null ? map['timer_seconds'] as int : 0,
          timerSecondsInTotal: map['timer_seconds_in_total'] != null
              ? map['timer_seconds_in_total'] as int
              : 7200,
          answers: Answer.mapFromJson(jsonDecode(map['answers'] as String)),
          score: map['score'] == null ? null : map['score'] as String);

  Map<String, dynamic> toJson() => {
        'session_name': sessionName,
        'subject_name': subjectName,
        'file_name': fileName,
        'folder_name': folderName,
        'session_id': sessionId,
        'date': date.microsecondsSinceEpoch.toString(),
        'completed': completed,
        'last_page': lastPage,
        'is_timer_activated': isTimerActivated,
        'timer_seconds': timerSeconds,
        'timer_seconds_in_total': timerSecondsInTotal,
        'answers': jsonEncode(Answer.toJsonMap(answers)),
        'score': score
      };

  factory PreviousAttemptModel.fromTestingRouteModel(
      TestingRouteStateModel data,
      TestingTimeStateModel timeData,
      bool completed) {
    int score = 0;
    int total = 0;

    for (final q in data.questions) {
      final answer = data.allAnswers[q.order.toString()];
      switch (q) {
        case QuestionSingle():
          total += q.getTotal;
          if (answer is! AnswerSingle?) {
            continue;
          }
          score += q.getScore(answer).score;
          break;
        case QuestionComplex():
          total += q.getTotal;
          if (answer is! AnswerComplex?) {
            continue;
          }
          score += q.getScore(answer).score;
          break;
        case QuestionTextFields():
          total += q.getTotal;
          if (answer is! AnswerTextFields?) {
            continue;
          }
          score += q.getScore(answer).score;
          break;
        case QuestionNoAnswer():
          break;
      }
    }

    DateTime now = DateTime.now();
    String nowString = now.microsecondsSinceEpoch.toString();

    String fileName;
    final prevData = data.prevSessionData;
    fileName = prevData != null ? prevData.sessionId : nowString;

    return PreviousAttemptModel(
        sessionName: data.sessionData.sessionName,
        subjectName: data.sessionData.subjectName,
        fileName: data.sessionData.fileName,
        folderName: data.sessionData.folderName,
        sessionId: fileName,
        date: now,
        completed: completed,
        lastPage: data.pageIndex,
        isTimerActivated: timeData.isTimerActivated,
        timerSeconds: timeData.secondsSinceStart,
        timerSecondsInTotal: timeData.secondsInTotal,
        answers: data.allAnswers,
        score: '$score/$total');
  }
}
