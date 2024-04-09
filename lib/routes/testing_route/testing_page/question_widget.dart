import 'package:client/dto/questions/question.dart';
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
    switch (question) {
      case QuestionSingle():
        return QuestionSingleWidget(question: question as QuestionSingle);
      case QuestionComplex():
        return QuestionComplexWidget(question: question as QuestionComplex);
      case QuestionNoAnswer():
        return QuestionNoAnswerWidget(question: question as QuestionNoAnswer);
      case QuestionTextFields():
        return QuestionTextFieldsWidget(
          question: question as QuestionTextFields,
        );
    }
  }
}
