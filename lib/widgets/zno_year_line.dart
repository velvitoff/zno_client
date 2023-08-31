import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ZnoYearLine extends StatelessWidget {
  final String text;

  const ZnoYearLine({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
      height: 25.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 1.h,
            color: const Color(0xFFCECECE),
          ),
          Container(
            width: 40.w,
            height: 25.h,
            color: const Color(0xFFFAFAFA),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 18.sp,
                    color: const Color(0xFF787878).withOpacity(0.8)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
