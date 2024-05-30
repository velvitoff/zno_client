import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../widgets/zno_top_header_small.dart';

class ImageViewRouteHeader extends StatelessWidget {
  const ImageViewRouteHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ZnoTopHeaderSmall(
      backgroundColor: const Color(0xFFF5F5F5),
      child: Container(
        margin: EdgeInsets.only(left: 7.w),
        child: Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () => context.pop(),
            child: Icon(
              Icons.arrow_back,
              size: 45.sp,
              color: const Color(0xFFF5F5F5),
            ),
          ),
        ),
      ),
    );
  }
}
