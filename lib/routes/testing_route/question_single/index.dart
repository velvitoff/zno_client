import 'package:client/dto/question_data.dart';
import 'package:client/routes/testing_route/testing_page/answer_variants_table.dart';
import 'package:client/widgets/ui_gen_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../testing_page/answer_variants_complex.dart';

class QuestionSingleWidget extends StatelessWidget {
  final QuestionSingle question;

  const QuestionSingleWidget({Key? key, required this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: question.render
                .map((list) => UiGenHandler(data: list))
                .toList(),
          ),
          AnswerVariantsComplex(
            titleList: question.answers.map((x) => "").toList(),
            tableList: question.answers,
          ),
        ],
      ),
    );
  }
}
