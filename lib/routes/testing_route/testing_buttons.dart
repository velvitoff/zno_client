import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestingButtons extends StatelessWidget {
  final void Function() onBack;
  final void Function() onForward;

  const TestingButtons({
    Key? key,
    required this.onBack,
    required this.onForward
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      height: 50.w,
      margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 145.w,
            height: 50.w,
            color: const Color(0xFF428449),
            child: GestureDetector(
              onTap: onBack,
              child: Center(
                child: Text(
                  'Назад',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFFFFFFF)
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 145.w,
            height: 50.w,
            color: const Color(0xFF428449),
            child: GestureDetector(
              onTap: onForward,
              child: Center(
                child: Text(
                  'Далі',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFFFFFFF)
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
