import 'dart:convert';

import 'package:client/locator.dart';
import 'package:client/services/interfaces/utils_service_interface.dart';

class PreviousSessionData {
  final String sessionName;
  final String subjectName;
  final String fileName;
  final String folderName;
  final String sessionId;
  final DateTime date;
  final bool completed;
  final int lastPage;
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
      required this.answers,
      required this.score});

  factory PreviousSessionData.fromJson(
          Map<String, dynamic> map) =>
      PreviousSessionData(
          sessionName: locator
              .get<UtilsServiceInterface>()
              .fileNameToSessionName(map['session_name'] as String),
          fileName: map['session_name'] as String,
          folderName: map['folder_name'] as String,
          subjectName: map['subject_name'] as String,
          sessionId: map['session_id'] as String,
          date: DateTime.fromMicrosecondsSinceEpoch(
              int.parse(map['date'] as String)),
          completed: map['completed'] as bool,
          lastPage: map['last_page'],
          answers: jsonDecode(map['answers'] as String),
          score: map['score'] == null ? null : map['score'] as String);

  bool get isEditable => !completed;
}
