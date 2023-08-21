import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ZnoTopHeaderText extends StatelessWidget {
  final String text;
  final Widget? topRightWidget;
  final Widget? topLeftWidget;

  const ZnoTopHeaderText(
      {Key? key, required this.text, this.topRightWidget, this.topLeftWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];
    if (topLeftWidget != null) {
      stackChildren
          .add(Align(alignment: Alignment.topLeft, child: topLeftWidget));
    }
    if (topRightWidget != null) {
      stackChildren
          .add(Align(alignment: Alignment.topRight, child: topRightWidget));
    }

    stackChildren.add(Align(
      alignment: Alignment.center,
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: const Color(0xFFEFEFEF),
              fontSize: 27.sp,
              fontWeight: FontWeight.w500)),
    ));

    final double topPadding = MediaQuery.of(context).padding.top;
    return Container(
      height: 250.h,
      width: 360.w,
      padding: EdgeInsets.fromLTRB(6.w, 0, 6.w, 0),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [Color(0xFF38543B), Color(0xFF418C4A)]),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      child: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: Stack(
          children: stackChildren,
        ),
      ),
    );
  }
}
