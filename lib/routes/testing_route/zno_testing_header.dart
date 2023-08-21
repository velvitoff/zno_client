import 'package:client/routes/testing_route/zno_more_dropdown.dart';
import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ZnoTestingHeader extends StatelessWidget {
  final String text;

  const ZnoTestingHeader({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZnoTopHeaderSmall(
      child: Container(
        child: Stack(fit: StackFit.expand, children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: text.length > 20 ? 20.sp : 24.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFF3F3F3)),
            ),
          ),
          const Align(alignment: Alignment(0.98, 0.0), child: ZnoMoreDropdown())
        ]),
      ),
    );
  }
}
