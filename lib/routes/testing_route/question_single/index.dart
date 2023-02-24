import 'package:client/dto/question_data.dart';
import 'package:client/routes/testing_route/question_render_data.dart';
import 'package:client/routes/testing_route/question_single/question_single_answer_field.dart';
import 'package:client/routes/testing_route/question_single/question_single_answer_variants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionSingleWidget extends StatelessWidget {
  final QuestionSingle question;
  final int index;

  const QuestionSingleWidget({
    Key? key,
    required this.question,
    required this.index
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
          QuestionSingleAnswerVariants(
              answers: question.answers
          ),
        ],
      ),
    );
  }
}
