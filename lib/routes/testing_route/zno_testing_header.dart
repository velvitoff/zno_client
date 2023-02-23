import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ZnoTestingHeader extends StatelessWidget {
  final String text;

  const ZnoTestingHeader({
    Key? key,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZnoTopHeaderSmall(
      child: Container(
        margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top, 0, 0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: text.length > 20 ? 20.sp : 24.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFF3F3F3)
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.98, 0.0),
              child: Icon(
                Icons.more_vert,
                size: 36.sp,
                color: Colors.white,
              )
            )
          ]
        ),
      ),
    );
  }
}
