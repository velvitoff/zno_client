part of 'question.dart';

class QuestionNoAnswer extends Question {
  const QuestionNoAnswer({required super.order, required super.render});

  factory QuestionNoAnswer.fromJson(Map<String, dynamic> map) =>
      QuestionNoAnswer(
        order: map['order'] as int,
        render: List<List<String>>.from(
            map['render'].map((x) => List<String>.from(x.map((x) => x)))),
      );

  @override
  int get getTotal => 0;
}
