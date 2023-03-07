import 'package:client/dto/question_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/ui_gen_handler.dart';

class QuestionNoAnswerWidget extends StatelessWidget {
  final QuestionNoAnswer question;

  const QuestionNoAnswerWidget({
    Key? key,
    required this.question
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
      child: Column(
        children: question.render.map((list) => UiGenHandler(data: list)).toList(),
      ),
    );
  }
}
