import 'package:client/models/testing_route_model.dart';
import 'package:client/routes/testing_route/question_complex/question_complex_answer_field.dart';
import 'package:client/routes/testing_route/question_single/question_single_answer_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../dto/question_data.dart';

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
          question: question.single!,
          index: index,
        );
      case QuestionEnum.complex:
        return QuestionComplexAnswerField(
          index: index,
          question: question.complex!
        );
      case QuestionEnum.noAnswer:
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
