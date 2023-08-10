import 'package:flutter/material.dart';

class ZnoButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final double fontSize;
  final void Function() onTap;
  final EdgeInsets margin;
  final EdgeInsets padding;

  const ZnoButton({
    Key? key,
    required this.width,
    required this.height,
    required this.text,
    required this.onTap,
    required this.fontSize,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        color: const Color(0xFF428449),
        child: Center(
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
    );
  }
}
