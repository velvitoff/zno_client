import 'package:client/dto/answers/answer.dart';
import 'package:client/extensions/list_get_extension.dart';
import 'package:flutter/foundation.dart';

part 'question_single.dart';
part 'question_text_fields.dart';
part 'question_complex.dart';
part 'question_no_answer.dart';
part 'scoring_result.dart';

sealed class Question {
  final int order;
  final List<List<String>> render;

  const Question({
    required this.order,
    required this.render,
  });

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
