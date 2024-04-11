part of 'question.dart';

class QuestionSingle extends Question {
  final List<Map<String, List<String>>> answers;
  final List<String> answerList;
  //is usually one value ["А"]
  final List<String> correct;

  const QuestionSingle(
      {required super.order,
      required super.render,
      required this.answers,
      required this.answerList,
      required this.correct});

  @override
  int get getTotal => correct.length;

  static List<String> _readCorrect(dynamic value) {
    assert(value is String || value is List);
    if (value is String) {
      return [value];
    }
    return List<String>.from(value);
  }

  factory QuestionSingle.fromJson(Map<String, dynamic> map) => QuestionSingle(
        order: map['order'] as int,
        render: List<List<String>>.from(
            map['render'].map((x) => List<String>.from(x.map((x) => x)))),
        answers: List<Map<String, List<String>>>.from(
            List<dynamic>.from(map['answers'])
                .map((mapItem) => Map<String, List<String>>.fromEntries(
                    Map<String, dynamic>.from(mapItem).entries.map((entry) =>
                        MapEntry<String, List<String>>(entry.key,
                            List<String>.from(entry.value.map((x) => x))))))
                .toList()),
        answerList: List<String>.from(map['answer_list'].map((x) => x)),
        correct: _readCorrect(map['correct']),
      );

  Map<String, dynamic> toJson() => {
        "order": order,
        "render": List<dynamic>.from(
            render.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "answers": answers,
        "correct": correct,
      };

  ScoringResult getScore(AnswerSingle? answer) {
    if (answer == null) return ScoringResult.wrong(total: 1);

    var correctList = [...correct];
    correctList.sort();
    var answerList = [...answer.data];
    answerList.sort();
    if (listEquals(correctList, answerList)) {
      return ScoringResult.correct(score: 1, total: 1);
    }

    return ScoringResult.wrong(total: 1);
  }
}
