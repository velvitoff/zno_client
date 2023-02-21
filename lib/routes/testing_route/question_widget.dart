import 'package:client/dto/question_data.dart';
import 'package:client/routes/testing_route/question_complex/index.dart';
import 'package:client/routes/testing_route/question_no_answer/index.dart';
import 'package:client/routes/testing_route/question_single/index.dart';
import 'package:client/widgets/zno_divider.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;
  final int index;

  const QuestionWidget({
    Key? key,
    required this.question,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (question.type) {
      case QuestionEnum.single:
        return Column(
          children: [
            ZnoDivider(text: '${index+1}'),
            QuestionSingleWidget(question: question.single!)
          ],
        );
      case QuestionEnum.complex:
        return Column(
          children: [
            ZnoDivider(text: '${index+1}'),
            QuestionComplexWidget(question: question.complex!)
          ],
        );
      case QuestionEnum.noAnswer:
        return Column(
          children: [
            ZnoDivider(text: '${index+1}'),
            QuestionNoAnswerWidget(question: question.noAnswer!)
          ],
        );
    }
  }
}
