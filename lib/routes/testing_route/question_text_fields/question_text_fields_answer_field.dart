import 'package:client/dto/answers/answer.dart';
import 'package:client/dto/questions/question.dart';
import 'package:client/routes/testing_route/question_text_fields/text_field_answer_show.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../state_models/testing_route_state_model.dart';

class QuestionTextFieldsAnswerField extends StatelessWidget {
  final QuestionTextFields question;
  final int index;

  const QuestionTextFieldsAnswerField({
    Key? key,
    required this.question,
    required this.index,
  }) : super(key: key);

  void handleChange(BuildContext context, int answerIndex, String newAnswer) {
    context
        .read<TestingRouteStateModel>()
        .addAnswerTextFields(question.order, answerIndex, newAnswer);
  }

  @override
  Widget build(BuildContext context) {
    final bool editable = !context.read<TestingRouteStateModel>().isViewMode;

    Answer? answer =
        context.read<TestingRouteStateModel>().getAnswer(question.order);
    if (answer is! AnswerTextFields?) {
      return Container();
    }

    List<String> values;
    if (answer == null) {
      values = List<String>.generate(question.correctList.length, (i) => "");
    } else if (answer.data.isNotEmpty) {
      values = answer.data;
    } else {
      values = List<String>.generate(question.correctList.length, (i) => "");
    }

    if (editable) {
      return Column(
        children: question.correctList.mapIndexed((i, item) {
          return Container(
            width: 300.w,
            margin: EdgeInsets.fromLTRB(0, 8.h, 0, 8.h),
            child: TextField(
                cursorColor: Colors.black,
                controller: TextEditingController(text: values[i]),
                enabled: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF418C4A)))),
                onChanged: !editable
                    ? null
                    : (String value) {
                        handleChange(context, i, value);
                      },
                style: TextStyle(fontSize: 21.sp)),
          );
        }).toList(),
      );
    } else {
      return Container(
        width: 300.w,
        margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldAnswerShow(
                leftText: 'Правильна відповідь:',
                rightText: question.correctList
                    .map((e) => e.join(" або "))
                    .join(" , ")),
            TextFieldAnswerShow(
                leftText: 'Ваша відповідь:', rightText: values.join(" , "))
          ],
        ),
      );
    }
  }
}
