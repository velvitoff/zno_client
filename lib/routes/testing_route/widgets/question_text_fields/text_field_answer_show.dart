import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldAnswerShow extends StatelessWidget {
  final String leftText;
  final String rightText;

  const TextFieldAnswerShow(
      {super.key, required this.leftText, required this.rightText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5.h, 0, 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(leftText, style: TextStyle(fontSize: 23.sp)),
          Text(
            rightText,
            style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
