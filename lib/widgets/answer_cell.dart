import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'icons/zno_cross.dart';

enum AnswerCellColor { green, red, none }

class AnswerCell extends StatelessWidget {
  final AnswerCellColor answerColor;
  final void Function()? onTap;

  const AnswerCell(
      {Key? key, this.onTap, this.answerColor = AnswerCellColor.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (answerColor) {
      case AnswerCellColor.green:
        return GestureDetector(
          onTap: onTap,
          child: CustomPaint(
            size: Size(46.5.r, 46.5.r),
            painter: const ZnoCross(color: Color(0xff32882A)),
          ),
        );
      case AnswerCellColor.red:
        return GestureDetector(
          onTap: onTap,
          child: CustomPaint(
            size: Size(46.5.r, 46.5.r),
            painter: const ZnoCross(color: Color(0xffBE252F)),
          ),
        );
      case AnswerCellColor.none:
        return GestureDetector(
          onTap: onTap,
          child: Container(
            height: 46.5.r,
            width: 46.5.r,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                border: Border.all(color: const Color(0xFF545454), width: 3.r)),
          ),
        );
    }
  }
}
