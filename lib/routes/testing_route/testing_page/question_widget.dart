import 'package:client/dto/question_data.dart';
import 'package:client/routes/testing_route/question_complex/index.dart';
import 'package:client/routes/testing_route/question_no_answer/index.dart';
import 'package:client/routes/testing_route/question_single/index.dart';
import 'package:client/routes/testing_route/question_text_fields/index.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;
  final int index;

  const QuestionWidget({Key? key, required this.question, required this.index})
      : super(key: key);

  //TO DO: why are the columns needed?
  @override
  Widget build(BuildContext context) {
    switch (question.type) {
      case QuestionEnum.single:
        return QuestionSingleWidget(question: question.single!);
      case QuestionEnum.complex:
        return QuestionComplexWidget(question: question.complex!);
      case QuestionEnum.noAnswer:
        return QuestionNoAnswerWidget(question: question.noAnswer!);
      case QuestionEnum.textFields:
        return QuestionTextFieldsWidget(
          question: question.textFields!,
        );
    }
  }
}
