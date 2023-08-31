import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ZnoListColorType { normal, green, orange, button }

class ZnoListItem extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final ZnoListColorType colorType;

  const ZnoListItem(
      {Key? key,
      required this.text,
      required this.onTap,
      required this.colorType})
      : super(key: key);

  LinearGradient getGradient(ZnoListColorType type) {
    switch (type) {
      case ZnoListColorType.normal:
        return const LinearGradient(colors: [
          Color.fromRGBO(153, 215, 132, 0.03),
          Color.fromRGBO(118, 174, 98, 0.16)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight);
      case ZnoListColorType.green:
        return const LinearGradient(colors: [
          Color.fromRGBO(153, 215, 132, 0.7),
          Color.fromRGBO(118, 174, 98, 0.73)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight);
      case ZnoListColorType.orange:
        return const LinearGradient(colors: [
          Color.fromRGBO(238, 134, 59, 0.5),
          Color.fromRGBO(255, 133, 47, 0.62)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight);
      case ZnoListColorType.button:
        return const LinearGradient(colors: [
          Color.fromRGBO(153, 215, 132, 0.82),
          Color.fromRGBO(118, 174, 98, 0.82)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 15.h, 0, 15.h),
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: const Color(0x0A363636)),
            borderRadius: BorderRadius.circular(10),
            gradient: getGradient(colorType)),
        width: 320.w,
        height: 60.h,
        child: Center(
          child: Text(
            text,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: text.length < 19 ? 25.sp : 23.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
