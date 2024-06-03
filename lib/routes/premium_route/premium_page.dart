import 'package:client/routes/premium_route/widgets/premium_button/premium_button.dart';
import 'package:flutter/material.dart';
import 'package:client/routes/premium_route/widgets/premium_route_header.dart';
import 'package:client/routes/premium_route/widgets/premium_text.dart';
import 'package:client/widgets/icons/zno_star_large_icon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PremiumRouteHeader(),
        Expanded(
          child: SingleChildScrollView(
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 20.h),
                child: DefaultTextStyle(
                  style: TextStyle(
                      fontSize: 24.sp, color: const Color(0xFF222222)),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 137.r,
                        height: 137.r,
                        child: CustomPaint(
                          painter: ZnoStarLargeIcon(),
                        ),
                      ),
                      Text(
                        'Преміум',
                        style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.h),
                      const PremiumText(),
                      Padding(
                        padding: EdgeInsets.only(bottom: 35.h, top: 35.h),
                        child: const PremiumButton(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
