import 'package:client/dto/question_data.dart';
import 'package:client/routes/testing_route/question_text_fields/text_field_answer_show.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../models/testing_route_model.dart';

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
    final bool editable = !context.read<TestingRouteModel>().isViewMode;

    dynamic initialValues =
        context.read<TestingRouteModel>().getAnswer((index + 1).toString());
    if (initialValues != null && initialValues is! List<dynamic>) {
      return Container();
    }

    List<String> values;
    try {
      values = initialValues != null
          ? List<String>.from(initialValues.map((x) => x as String))
          : List<String>.generate(question.correctList.length, (i) => "");
    } catch (e) {
      return Container();
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
                        List<String> newList = values;
                        newList[i] = value;
                        context
                            .read<TestingRouteModel>()
                            .addAnswer((index + 1).toString(), newList);
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
                rightText: question.correctList.join("  ")),
            TextFieldAnswerShow(
                leftText: 'Ваша відповідь:', rightText: values.join("  "))
          ],
        ),
      );
    }
  }
}
