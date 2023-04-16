import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EndSessionButtons extends StatelessWidget {
  final void Function() onBack;
  final void Function() onEndSession;

  const EndSessionButtons({
    Key? key,
    required this.onBack,
    required this.onEndSession
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      height: 50.h,
      margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: onBack,
              child: Container(
                width: 145.w,
                height: 50.h,
                color: const Color(0xFF428449),
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
              )
          ),
          GestureDetector(
            onTap: onEndSession,
            child: Container(
              width: 145.w,
              height: 50.h,
              color: const Color(0xFF428449),
              child: Center(
                child: Text(
                  'Закінчити сесію',
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
