import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ZnoDivider extends StatelessWidget {
  final String text;

  const ZnoDivider({
    Key? key,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 2.h,
            color: const Color(0xFFCECECE),
          ),
          Container(
            width: 25.w,
            padding: EdgeInsets.all(3.r),
            color: const Color(0xFFFFFFFF),
            //TODO: Fix color, themes
            child: FittedBox(
              fit: BoxFit.contain,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: const Color(0xFF787878),
                      fontWeight: FontWeight.w400
                  ),
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}
