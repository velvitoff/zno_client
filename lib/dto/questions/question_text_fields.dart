part of 'question.dart';

class QuestionTextFields extends Question {
  final List<String> answerTitles;
  final List<Map<String, List<String>>> answers;
  //Usually it's [["50"], ["20"]], but sometimes one question can have multiple answers
  final List<List<String>> correctList;

  const QuestionTextFields(
      {required super.order,
      required super.render,
      required this.answerTitles,
      required this.answers,
      required this.correctList});

  static List<List<String>> _readCorrectList(dynamic value) {
    assert(value is List);
    List<List<String>> result = [];
    for (final el in value) {
      if (el is String) {
        result.add([el]);
      }
      if (el is List) {
        result.add(List<String>.from(el.map((x) => x as String).toList()));
      }
    }
    return result;
  }

  factory QuestionTextFields.fromJSON(Map<String, dynamic> map) => QuestionTextFields(
      order: map['order'] as int,
      render: List<List<String>>.from(
          map['render'].map((x) => List<String>.from(x.map((x) => x)))),
      answerTitles: (map['answer_titles'] == null || map['answer_titles'] == [])
          ? []
          : List<String>.from(map['answer_titles'].map((x) => x as String)),
      answers: List<Map<String, List<String>>>.from(
          List<dynamic>.from(map['answers'])
              .map((mapItem) => Map<String, List<String>>.fromEntries(
                  Map<String, dynamic>.from(mapItem).entries.map((entry) =>
                      MapEntry<String, List<String>>(
                          entry.key, List<String>.from(entry.value.map((x) => x))))))
              .toList()),
      correctList: _readCorrectList(map['correct_list']));

  ScoringResult getScore(AnswerTextFields? answer) {
    if (answer == null) {
      return ScoringResult.wrong(total: correctList.length);
    }

    int total = 0;
    int score = 0;
    for (final (i, correctValue) in correctList.indexed) {
      total += 1;
      String? userAnswer = answer.data.get(i);
      String? userAnswer2 = userAnswer?.replaceAll('.', ',');
      String? userAnswer3 = userAnswer?.replaceAll(',', '.');
      if (correctValue.contains(userAnswer) ||
          correctValue.contains(userAnswer2) ||
          correctValue.contains(userAnswer3)) {
        score += 1;
      }
    }

    if (total == score) {
      return ScoringResult.correct(score: score, total: total);
    } else if (score > 0) {
      return ScoringResult.partial(score: score, total: total);
    }
    return ScoringResult.wrong(total: total);
  }
}
