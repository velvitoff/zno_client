import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ZnoTopHeaderSmall extends StatelessWidget {
  final Widget? child;
  final Color? backgroundColor;

  const ZnoTopHeaderSmall({Key? key, this.child, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Container(
      color: backgroundColor,
      child: Container(
        padding: EdgeInsets.only(top: topPadding),
        margin: EdgeInsets.zero,
        height: 70.h + topPadding,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF418C4A), Color(0xFF38543B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: child,
      ),
    );
  }
}
