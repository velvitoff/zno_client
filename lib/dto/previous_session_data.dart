import 'dart:convert';

import 'package:client/locator.dart';
import 'package:client/models/testing_time_model.dart';
import 'package:client/services/utils_service.dart';

import '../models/testing_route_model.dart';

class PreviousSessionData {
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
  final Map<String, dynamic> answers;
  final String? score;

  const PreviousSessionData(
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

  factory PreviousSessionData.fromJson(Map<String, dynamic> map) =>
      PreviousSessionData(
          sessionName:
              locator.get<UtilsService>().fileNameToSessionName(map[
                  'session_name'] as String),
          subjectName: map['subject_name'] as String,
          fileName: map['file_name'] as String,
          folderName: map['folder_name'] as String,
          sessionId: map['session_id'] as String,
          date:
              DateTime.fromMicrosecondsSinceEpoch(int.parse(map['date']
                  as String)),
          completed: map['completed'] as bool,
          lastPage: map['last_page'],
          isTimerActivated:
              map[
                          'is_timer_activated'] !=
                      null
                  ? map['is_timer_activated'] as bool
                  : false,
          timerSeconds:
              map['timer_seconds'] != null ? map['timer_seconds'] as int : 0,
          timerSecondsInTotal: map['timer_seconds_in_total'] != null
              ? map['timer_seconds_in_total'] as int
              : 7200,
          answers: jsonDecode(map['answers'] as String),
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
        'answers': jsonEncode(answers),
        'score': score
      };

  factory PreviousSessionData.fromTestingRouteModel(
      TestingRouteModel data, TestingTimeModel timeData, bool completed) {
    //calculating a score
    int score = 0;

    for (var answerEntry in data.allAnswers.entries) {
      var q = data.questions[int.parse(answerEntry.key) - 1];
      if (q.single != null) {
        if (q.single!.correct == answerEntry.value) {
          score += 1;
        }
      } else if (q.complex != null) {
        Map<String, dynamic> answerMap =
            answerEntry.value as Map<String, dynamic>;
        for (var correctEntry in q.complex!.correctMap.entries) {
          if (correctEntry.value == answerMap[correctEntry.key]) {
            score += 1;
          }
        }
      } else if (q.textFields != null) {
        List<String> answerList = List<String>.from(answerEntry.value);
        for (int i = 0; i < q.textFields!.correctList.length; ++i) {
          if (q.textFields!.correctList[i] == answerList[i] ||
              q.textFields!.correctList[i].replaceAll('.', ',') ==
                  answerList[i]) {
            score += 1;
          }
        }
      }
    }

    int total = 0;
    for (var q in data.questions) {
      if (q.single != null) {
        total += 1;
      } else if (q.complex != null) {
        total += q.complex!.correctMap.entries.length;
      } else if (q.textFields != null) {
        total += q.textFields!.correctList.length;
      }
    }

    DateTime now = DateTime.now();
    String nowString = now.microsecondsSinceEpoch.toString();

    String fileName;
    if (data.prevSessionData != null) {
      fileName = data.prevSessionData!.sessionId;
    } else {
      fileName = nowString;
    }

    return PreviousSessionData(
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
