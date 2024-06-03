import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ZnoTopHeaderText extends StatelessWidget {
  final String text;
  final Widget? topRightWidget;
  final Widget? topLeftWidget;
  final double? fontSize;

  const ZnoTopHeaderText({
    Key? key,
    required this.text,
    this.topRightWidget,
    this.topLeftWidget,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];
    stackChildren.add(Center(
      child: Container(
        margin: EdgeInsets.only(left: 5.w),
        width: 330.w,
        child: Text(
          text,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFFEFEFEF),
            fontSize: fontSize ?? 25.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ));

    if (topLeftWidget != null) {
      stackChildren
          .add(Align(alignment: Alignment.topLeft, child: topLeftWidget));
    }
    if (topRightWidget != null) {
      stackChildren
          .add(Align(alignment: Alignment.topRight, child: topRightWidget));
    }

    final double topPadding = MediaQuery.of(context).padding.top;
    return Container(
      height: 150.h,
      width: 360.w,
      padding: EdgeInsets.fromLTRB(6.w, 0, 6.w, 0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [Color(0xFF38543B), Color(0xFF418C4A)]),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: Stack(
          children: stackChildren,
        ),
      ),
    );
  }
}
