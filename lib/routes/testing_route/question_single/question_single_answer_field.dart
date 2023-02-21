import 'package:client/widgets/icons/zno_correct_cross.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//TODO: Fix stateful widget

class QuestionSingleAnswerField extends StatefulWidget {
  final List<String> variants;

  const QuestionSingleAnswerField({
    Key? key,
    required this.variants
  }) : super(key: key);

  @override
  State<QuestionSingleAnswerField> createState() => _QuestionSingleAnswerFieldState();
}

class _QuestionSingleAnswerFieldState extends State<QuestionSingleAnswerField> {

  String _selected = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310.w,
      height: 90.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widget.variants.map((variant) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                variant,
                style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w500),
              ),
              variant == _selected
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
                child: GestureDetector(
                  onTap: () => setState(() => _selected = variant)
                ),
              )
            ],
          );
          }
        ).toList()
      )
    );
  }
}
