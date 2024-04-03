import 'package:client/routes/testing_route/question_complex/question_complex_answer_field.dart';
import 'package:client/routes/testing_route/question_single/question_single_answer_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../dto/questions/question_data.dart';
import '../question_text_fields/question_text_fields_answer_field.dart';

class AnswerWidget extends StatelessWidget {
  final Question question;
  final int index;

  const AnswerWidget({Key? key, required this.question, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (question) {
      case QuestionSingle():
        return QuestionSingleAnswerField(
          question: question as QuestionSingle,
          index: index,
        );
      case QuestionComplex():
        return QuestionComplexAnswerField(
            index: index, question: question as QuestionComplex);
      case QuestionNoAnswer():
        return Container(
          margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
          child: Text(
            'Це запитання не має відповіді, яку додаток здатен перевірити',
            style: TextStyle(fontSize: 20.sp),
          ),
        );
      case QuestionTextFields():
        return QuestionTextFieldsAnswerField(
            index: index, question: question as QuestionTextFields);
    }
  }
}
