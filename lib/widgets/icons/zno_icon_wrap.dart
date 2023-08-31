import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ZnoIconWrap extends StatelessWidget {
  final String text;
  final Widget childIcon;
  final bool isActive;

  const ZnoIconWrap(
      {Key? key,
      required this.text,
      required this.childIcon,
      required this.isActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 85.w,
        height: 62.h,
        decoration: BoxDecoration(
            color: isActive ? const Color(0xFF408A48) : const Color(0x00FFFFFF),
            borderRadius: const BorderRadius.all(Radius.circular(7))),
        child: Column(
          children: [
            childIcon,
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 17.sp,
                  color: const Color(0xFFF4F4F4),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Ubuntu'),
            )
          ],
        ));
  }
}
