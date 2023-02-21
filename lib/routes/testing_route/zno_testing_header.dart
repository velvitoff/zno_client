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
        margin: EdgeInsets.fromLTRB(0, 35.h, 0, 0),
        child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: text.length > 20 ? 20.sp : 24.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFF3F3F3)
              ),
            )
        ),
      ),
    );
  }
}
