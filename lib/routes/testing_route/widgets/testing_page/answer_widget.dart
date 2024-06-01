import 'package:client/models/questions/question.dart';
import 'package:client/routes/testing_route/widgets/question_complex/question_complex_answer_field.dart';
import 'package:client/routes/testing_route/widgets/question_single/question_single_answer_field.dart';
import 'package:client/routes/testing_route/widgets/question_text_fields/question_text_fields_answer_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          index: index,
          question: question as QuestionSingle,
        );
      case QuestionComplex():
        return QuestionComplexAnswerField(
          index: index,
          question: question as QuestionComplex,
        );
      case QuestionTextFields():
        return QuestionTextFieldsAnswerField(
          index: index,
          question: question as QuestionTextFields,
        );
      case QuestionNoAnswer():
        return Container(
          margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
          child: Text(
            'Це запитання не має відповіді, яку додаток здатен перевірити',
            style: TextStyle(fontSize: 20.sp),
          ),
        );
    }
  }
}
