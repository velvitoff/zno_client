import 'package:client/models/questions/question.dart';
import 'package:client/routes/testing_route/widgets/question_complex/question_complex_widget.dart';
import 'package:client/routes/testing_route/widgets/question_no_answer/question_no_answer_widget.dart';
import 'package:client/routes/testing_route/widgets/question_single/question_single.dart';
import 'package:client/routes/testing_route/widgets/question_text_fields/question_text_fields_widget.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;
  final int index;

  const QuestionWidget({
    Key? key,
    required this.question,
    required this.index,
  }) : super(key: key);

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
            question: question as QuestionTextFields);
    }
  }
}
