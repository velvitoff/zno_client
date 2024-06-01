import 'package:client/models/answers/answer.dart';
import 'package:client/models/questions/question.dart';
import 'package:client/routes/testing_route/state/testing_route_state_model.dart';
import 'package:client/routes/testing_route/widgets/question_text_fields/text_field_answer_show.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
    final bool editable = !context.read<TestingRouteStateModel>().isViewMode;

    Answer? answer =
        context.read<TestingRouteStateModel>().getAnswer(question.order);
    if (answer is! AnswerTextFields?) {
      return Container();
    }

    List<String> values;
    if (answer == null || answer.data.isEmpty) {
      values = List<String>.generate(question.correctList.length, (i) => "");
    } else {
      values = answer.data;
    }

    if (!editable) {
      return _NotEditable(question: question, values: values);
    }
    return _Editable(question: question, values: values);
  }
}

class _Editable extends StatelessWidget {
  final QuestionTextFields question;
  final List<String> values;
  const _Editable({
    required this.question,
    required this.values,
  });

  void _handleChange(BuildContext context, int answerIndex, String newAnswer) {
    context.read<TestingRouteStateModel>().addAnswerTextFields(
          question.order,
          answerIndex,
          newAnswer,
        );
  }

  @override
  Widget build(BuildContext context) {
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
              onChanged: (String value) => _handleChange(context, i, value),
              style: TextStyle(fontSize: 21.sp)),
        );
      }).toList(),
    );
  }
}

class _NotEditable extends StatelessWidget {
  final QuestionTextFields question;
  final List<String> values;
  const _NotEditable({
    required this.question,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldAnswerShow(
            leftText: 'Правильна відповідь:',
            rightText:
                question.correctList.map((e) => e.join(" або ")).join(" , "),
          ),
          TextFieldAnswerShow(
            leftText: 'Ваша відповідь:',
            rightText: values.join(" , "),
          )
        ],
      ),
    );
  }
}
