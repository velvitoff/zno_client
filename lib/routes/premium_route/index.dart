import 'package:client/state_models/auth_state_model.dart';
import 'package:client/routes.dart';
import 'package:client/routes/premium_route/button_google_login.dart';
import 'package:client/routes/premium_route/button_google_pay.dart';
import 'package:client/routes/premium_route/premium_route_header.dart';
import 'package:client/routes/premium_route/premium_text.dart';
import 'package:client/widgets/golden_border.dart';
import 'package:client/widgets/icons/zno_star_large_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

class PremiumRoute extends StatelessWidget {
  const PremiumRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthStateModel model = context.watch<AuthStateModel>();

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) => context.go(Routes.settingsRoute),
      child: Scaffold(
          body: Column(
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
                              fontSize: 36.sp, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10.h),
                        const PremiumText(),
                        Padding(
                          padding: EdgeInsets.only(bottom: 35.h, top: 35.h),
                          child: model.currentUser != null
                              ? model.isPremium
                                  ? Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CustomPaint(
                                          painter: GoldenBorder(sWidth: 3.0),
                                          child: SizedBox(
                                              height: 60.h, width: 320.w),
                                        ),
                                        const Text(
                                          'Ви вже придбали преміум',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    )
                                  : const ButtonGooglePay()
                              : const ButtonGoogleLogin(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
