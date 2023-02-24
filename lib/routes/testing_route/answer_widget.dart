import 'package:client/routes/testing_route/question_single/question_single_answer_field.dart';
import 'package:flutter/material.dart';

import '../../dto/question_data.dart';

class AnswerWidget extends StatelessWidget {
  final Question question;
  final int index;

  const AnswerWidget({
    Key? key,
    required this.question,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (question.type) {
      case QuestionEnum.single:
        return QuestionSingleAnswerField(
          variants: question.single!.answers.keys.toList(),
          index: index,
        );
      case QuestionEnum.complex:
        return Container();
      case QuestionEnum.noAnswer:
        return Container();
    }
  }
}
