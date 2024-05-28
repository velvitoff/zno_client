import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ZnoButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final double fontSize;
  final void Function() onTap;
  final EdgeInsets margin;

  const ZnoButton({
    Key? key,
    required this.width,
    required this.height,
    required this.text,
    required this.onTap,
    required this.fontSize,
    this.margin = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: EdgeInsets.all(5.r),
        decoration: BoxDecoration(
          color: const Color(0xFF428449),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFFFFFFF)),
            ),
          ),
        ),
      ),
    );
  }
}
