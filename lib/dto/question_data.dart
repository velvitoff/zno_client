sealed class Question {
  const Question();

  factory Question.fromJson(Map<String, dynamic> map) {
    final single = map['Single'];
    final complex = map['Complex'];
    final noAnswer = map['NoAnswer'];
    final textFields = map['TextFields'];

    if (single != null) return QuestionSingle.fromJson(single);
    if (complex != null) return QuestionComplex.fromJson(complex);
    if (noAnswer != null) return QuestionNoAnswer.fromJson(noAnswer);
    if (textFields != null) return QuestionTextFields.fromJSON(textFields);

    throw const FormatException('No fitting task type found');
  }
}

class QuestionSingle extends Question {
  final int order;
  final List<List<String>> render;
  final List<Map<String, List<String>>> answers;
  final List<String> answerList;
  final String correct;

  const QuestionSingle(
      {required this.order,
      required this.render,
      required this.answers,
      required this.answerList,
      required this.correct});

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
        correct: map['correct'] as String,
      );

  Map<String, dynamic> toJson() => {
        "order": order,
        "render": List<dynamic>.from(
            render.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "answers": answers,
        "correct": correct,
      };
}

class QuestionTextFields extends Question {
  final int order;
  final List<List<String>> render;
  final List<String> answerTitles;
  final List<Map<String, List<String>>> answers;
  final List<String> correctList;

  const QuestionTextFields(
      {required this.order,
      required this.render,
      required this.answerTitles,
      required this.answers,
      required this.correctList});

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
      correctList: List<String>.from(map['correct_list'].map((x) => x as String).toList()));
}

class QuestionComplex extends Question {
  final int order;
  final List<List<String>> render;
  final List<String> titleList;
  final List<Map<String, List<String>>> tableList;
  final List<List<String>> answerMappingList;
  final Map<String, String> correctMap;

  const QuestionComplex(
      {required this.order,
      required this.render,
      required this.titleList,
      required this.tableList,
      required this.answerMappingList,
      required this.correctMap});

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
}

class QuestionNoAnswer extends Question {
  final int order;
  final List<List<String>> render;

  const QuestionNoAnswer({required this.order, required this.render});

  factory QuestionNoAnswer.fromJson(Map<String, dynamic> map) =>
      QuestionNoAnswer(
        order: map['order'] as int,
        render: List<List<String>>.from(
            map['render'].map((x) => List<String>.from(x.map((x) => x)))),
      );
}
