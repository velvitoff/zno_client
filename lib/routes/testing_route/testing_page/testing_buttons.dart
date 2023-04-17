import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestingButtons extends StatelessWidget {
  final void Function() onBack;
  final void Function() onForward;
  final bool isFirstPage;
  final bool isLastPage;

  const TestingButtons({
    Key? key,
    required this.onBack,
    required this.onForward,
    required this.isFirstPage,
    required this.isLastPage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Widget> childList = [];

    if (!isFirstPage) {
      childList.add(
          GestureDetector(
              onTap: onBack,
              child: Container(
                width: 145.w,
                height: 50.h,
                margin: EdgeInsets.fromLTRB(7.5.w, 0, 7.5.w, 0),
                padding: EdgeInsets.all(5.r),
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
          )
      );
    }

    if (!isLastPage) {
      childList.add(
          GestureDetector(
            onTap: onForward,
            child: Container(
              width: isFirstPage? 290.w : 145.w,
              height: 50.h,
              margin: EdgeInsets.fromLTRB(7.5.w, 0, 7.5.w, 0),
              padding: EdgeInsets.all(5.r),
              color: const Color(0xFF428449),
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
      );
    }
    else {
      childList.add(
          GestureDetector(
            onTap: onForward,
            child: Container(
              width: 145.w,
              height: 50.h,
              margin: EdgeInsets.fromLTRB(7.5.w, 0, 7.5.w, 0),
              padding: EdgeInsets.all(5.r),
              color: const Color(0xFF428449),
              child: Center(
                child: Text(
                  'Завершити спробу',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFFFFFFF)
                  ),
                ),
              ),
            ),
          )
      );
    }

    return Container(
      width: 320.w,
      height: 50.h,
      margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: childList,
      ),
    );
  }
}
