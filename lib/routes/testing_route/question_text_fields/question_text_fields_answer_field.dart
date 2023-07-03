import 'package:client/dto/question_data.dart';
import 'package:flutter/material.dart';

class QuestionTextFieldsAnswerField extends StatelessWidget {
  final QuestionTextFields question;
  final int index;

  const QuestionTextFieldsAnswerField({
    Key? key,
    required this.question,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("TEXT FIELD"),
    );
  }
}
