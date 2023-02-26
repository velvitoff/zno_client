import 'package:client/dto/question_data.dart';
import 'package:client/routes/testing_route/answer_variants_complex.dart';
import 'package:client/routes/testing_route/question_render_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionComplexWidget extends StatelessWidget {
  final QuestionComplex question;

  const QuestionComplexWidget({
    Key? key,
    required this.question
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QuestionRenderData(data: question.render),
          AnswerVariantsComplex(
            titleList: question.titleList,
            tableList: question.tableList,
          )
        ],
      ),
    );
  }
}
