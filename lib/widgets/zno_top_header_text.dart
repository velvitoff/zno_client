import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ZnoTopHeaderText extends StatelessWidget {
  final  String text;

  const ZnoTopHeaderText({
    Key? key,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      width: 360.w,
      padding: EdgeInsets.fromLTRB(6.w, 0, 6.w, 0),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                Color(0xFF38543B),
                Color(0xFF418C4A)
              ]
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
          )
      ),
      child: Center(
        child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: const Color(0xFFEFEFEF),
                fontSize: 27.sp,
                fontWeight: FontWeight.w500
            )
        ),
      ),
    );
  }
}
