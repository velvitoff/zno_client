import 'package:client/models/questions/question.dart';
import 'package:client/routes/testing_route/widgets/testing_page/answer_variants_complex.dart';
import 'package:client/routes/testing_route/ui_creator/ui_creator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionComplexWidget extends StatelessWidget {
  final QuestionComplex question;

  const QuestionComplexWidget({Key? key, required this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                question.render.map((list) => UiCreator(data: list)).toList(),
          ),
          AnswerVariantsComplex(
            titleList: question.titleList,
            tableList: question.tableList,
          )
        ],
      ),
    );
  }
}
