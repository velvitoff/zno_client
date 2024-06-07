import 'package:client/routes/testing_route/ui_creator/creators/text_creator.dart';
import 'package:client/routes/testing_route/ui_creator/ui_creator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnswerVariantsTable extends StatelessWidget {
  final String? title;
  final Map<String, List<String>> answers;

  const AnswerVariantsTable({
    Key? key,
    required this.answers,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20.h, 0, 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title == null ? Container() : TextCreator(text: title!).create(),
          ...answers.entries
              .map((entry) => Container(
                    margin: EdgeInsets.fromLTRB(0, 5.h, 0, 5.h),
                    child: _AnswerVariantsRow(entry: entry),
                  ))
              .toList()
        ],
      ),
    );
  }
}

class _AnswerVariantsRow extends StatelessWidget {
  final MapEntry<String, List<String>> entry;
  const _AnswerVariantsRow({
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 35.r,
          height: 35.r,
          margin: EdgeInsets.fromLTRB(0, 0.h, 10.w, 0.h),
          decoration: const BoxDecoration(
            color: Color(0xFF60B558),
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
          ),
          child: Center(
            child: Text(
              entry.key,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        LimitedBox(
          maxWidth: 270.w,
          child: UiCreator(
            data: entry.value,
            textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }
}
