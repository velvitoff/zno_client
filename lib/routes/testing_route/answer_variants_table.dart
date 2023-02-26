import 'package:client/routes/testing_route/ui_generator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnswerVariantsTable extends StatelessWidget {
  final String? title;
  final Map<String, List<String>> answers;

  const AnswerVariantsTable({
    Key? key,
    required this.answers,
    this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 15.h, 0, 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title == null
              ?
          Container()
              :
          UiGenerator.textToWidget(title!),
          ...answers.entries.map((entry) =>
              Row(
                children: [
                  Container(
                    width: 35.r,
                    height: 35.r,
                    margin: EdgeInsets.fromLTRB(0, 5.h, 10.w, 5.h),
                    decoration: const BoxDecoration(
                        color: Color(0xFF60B558),
                        borderRadius: BorderRadius.all(Radius.circular(3))
                    ),
                    child: Center(
                      child: Text(entry.key, style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  SizedBox(
                    width: 270.w,
                    child: entry.value[0] == 'p' ? UiGenerator.textToWidget(entry.value[1], style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400)) : Container(),
                  )
                ],
              )).toList()
        ],
      ),
    );
  }
}
