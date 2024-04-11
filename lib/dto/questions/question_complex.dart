part of 'question.dart';

class QuestionComplex extends Question {
  final List<String> titleList;
  final List<Map<String, List<String>>> tableList;
  final List<List<String>> answerMappingList;
  final Map<String, String> correctMap;

  const QuestionComplex(
      {required super.order,
      required super.render,
      required this.titleList,
      required this.tableList,
      required this.answerMappingList,
      required this.correctMap});

  @override
  int get getTotal => correctMap.keys.length;

  factory QuestionComplex.fromJson(Map<String, dynamic> map) => QuestionComplex(
        order: map['order'] as int,
        render: List<List<String>>.from(
            map['render'].map((x) => List<String>.from(x.map((x) => x)))),
        titleList: List<String>.from(map['title_list'].map((x) => x)),
        tableList: List<Map<String, List<String>>>.from(
            List<dynamic>.from(map['table_list'])
                .map((mapItem) => Map<String, List<String>>.fromEntries(
                    Map<String, dynamic>.from(mapItem).entries.map((entry) =>
                        MapEntry<String, List<String>>(entry.key,
                            List<String>.from(entry.value.map((x) => x))))))
                .toList()),
        answerMappingList: List<List<String>>.from(map['answer_mapping_list']
            .map((x) => List<String>.from(x.map((x) => x)))),
        correctMap: Map<String, String>.from(
            Map<String, dynamic>.from(map['correct_map'])),
      );

  ScoringResult getScore(AnswerComplex? answer) {
    if (answer == null) {
      return ScoringResult.wrong(total: correctMap.entries.length);
    }

    int total = 0;
    int score = 0;
    for (final entry in correctMap.entries) {
      total += 1;
      if (answer.data[entry.key] == entry.value) {
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
