enum QuestionEnum{
  single,
  complex,
  noAnswer
}

class Question {
  final QuestionEnum type;
  final QuestionSingle? single;
  final QuestionComplex? complex;
  final QuestionNoAnswer? noAnswer;

  const Question({
    required this.type,
    this.single,
    this.complex,
    this.noAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> map) {
    final single = map['Single'];
    final complex = map['Complex'];
    final noAnswer = map['NoAnswer'];

    if (single != null){
      return Question(
        type: QuestionEnum.single,
        single: QuestionSingle.fromJson(single)
      );
    }
    if (complex != null) {
      return Question(
        type: QuestionEnum.complex,
        complex: QuestionComplex.fromJson(complex)
      );
    }
    if (noAnswer != null) {
      return Question(
        type: QuestionEnum.noAnswer,
        noAnswer: QuestionNoAnswer.fromJson(noAnswer)
      );
    }

    throw const FormatException('No fitting task type found');
  }


  Map<String, dynamic> toJson() {
    switch (type){
      case QuestionEnum.single:
        return {"Single": single?.toJson()};
      case QuestionEnum.complex:
        return {"Complex": complex?.toJson()};
      case QuestionEnum.noAnswer:
        return {"NoAnswer": noAnswer?.toJson()};
    }
  }

}

class QuestionSingle {
  final int order;
  final List<List<String>> render;
  final Map<String, List<String>> answers;//Map<String,List<String>>
  final String correct;

  const QuestionSingle({
    required this.order,
    required this.render,
    required this.answers,
    required this.correct
  });

  factory QuestionSingle.fromJson(Map<String, dynamic> map) =>
      QuestionSingle(
        order: map['order'] as int,
        render: List<List<String>>.from(map['render']
            .map((x) => List<String>.from(x.map((x) => x)))),
        answers: Map<String, List<String>>.fromEntries(
            Map<String, dynamic>.from(map['answers'])
                .entries.map((entry) =>
                MapEntry<String, List<String>>(
                    entry.key,
                    List<String>.from(entry.value.map((x) => x))))
        ),
        correct: map['correct'] as String,
      );

  Map<String, dynamic> toJson() => {
    "order": order,
    "render": List<dynamic>.from(render.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "answers": answers,
    "correct": correct,
  };

}

class QuestionComplex {
  final int order;
  final List<List<String>> render;
  final List<String> titleList;
  //TODO: tableList
  //TODO: correctMap

  const QuestionComplex({
    required this.order,
    required this.render,
    required this.titleList
  });

  factory QuestionComplex.fromJson(Map<String, dynamic> map) => QuestionComplex(
    order: map['order'] as int,
    render: List<List<String>>.from(map['render'].map((x) => List<String>.from(x.map((x) => x)))),
    titleList: List<String>.from(map['title_list'].map((x) => x)),
    //tableList: List<TableList>.from(json["table_list"].map((x) => TableList.fromJson(x))),
    //correctMap: Map.from(json["correct_map"]).map((k, v) => MapEntry<String, Correct>(k, correctValues.map[v]!)),
  );

  Map<String, dynamic> toJson() => {
    "order": order,
    "render": List<dynamic>.from(render.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "title_list": List<dynamic>.from(titleList.map((x) => x)),
    //"table_list": List<dynamic>.from(tableList.map((x) => x.toJson())),
    //"correct_map": Map.from(correctMap).map((k, v) => MapEntry<String, dynamic>(k, correctValues.reverse[v])),
  };

}

class QuestionNoAnswer {
  final int order;
  final List<List<String>> render;

  const QuestionNoAnswer({
    required this.order,
    required this.render
  });

  factory QuestionNoAnswer.fromJson(Map<String, dynamic> map) => QuestionNoAnswer(
    order: map['order'] as int,
    render: List<List<String>>.from(map['render'].map((x) => List<String>.from(x.map((x) => x)))),
  );

  Map<String, dynamic> toJson() => {
    'order': order,
    'render': List<dynamic>.from(render.map((x) => List<dynamic>.from(x.map((x) => x)))),
  };

}
