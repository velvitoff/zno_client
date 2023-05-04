import 'dart:convert';

class PreviousSessionData {
  final String sessionName;
  final String sessionId;
  final DateTime date;
  final bool completed;
  final int lastPage;
  final Map<String, dynamic> answers;
  final String? score;

  const PreviousSessionData({
    required this.sessionName,
    required this.sessionId,
    required this.date,
    required this.completed,
    required this.lastPage,
    required this.answers,
    required this.score
  });

  factory PreviousSessionData.fromJson(Map<String, dynamic> map) =>
      PreviousSessionData(
        sessionName: map['session_name'] as String,
        sessionId: map['session_id'] as String,
        date: DateTime.fromMicrosecondsSinceEpoch(int.parse(map['date'] as String)),
        completed: map['completed'] as bool,
        lastPage: map['last_page'],
        answers: jsonDecode(map['answers'] as String),
        score: map['score'] == null ? null : map['score'] as String
      );

  bool get isEditable => !completed;

}
