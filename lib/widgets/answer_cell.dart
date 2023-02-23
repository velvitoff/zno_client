import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'icons/zno_correct_cross.dart';

class AnswerCell extends StatelessWidget {
  final bool marked;
  final void Function() onTap;

  const AnswerCell({
    Key? key,
    required this.onTap,
    this.marked = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: marked
      ?
      CustomPaint(
        size: Size(46.5.r, 46.5.r),
        painter: const ZnoCorrectCross(),
      )
      :
      Container(
        height: 46.5.r,
        width: 46.5.r,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            border: Border.all(
                color: const Color(0xFF545454),
                width: 3
            )
        ),
      ),
    );
  }
}
