import 'package:client/locator.dart';
import 'package:client/routes.dart';
import 'package:client/routes/premium_route/button_google_login.dart';
import 'package:client/routes/premium_route/button_google_pay.dart';
import 'package:client/services/implementations/auth_service.dart';
import 'package:client/widgets/icons/zno_star_large_icon.dart';
import 'package:client/widgets/zno_icon_button.dart';
import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PremiumRoute extends StatefulWidget {
  const PremiumRoute({super.key});

  @override
  State<PremiumRoute> createState() => _PremiumRouteState();
}

class _PremiumRouteState extends State<PremiumRoute> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        ZnoTopHeaderSmall(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 6.w),
                  child: ZnoIconButton(
                      icon: Icons.arrow_back,
                      onTap: () => context.go(Routes.settingsRoute)),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 20.h),
            child: DefaultTextStyle(
              style: TextStyle(fontSize: 24.sp),
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
                    style:
                        TextStyle(fontSize: 36.sp, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                      'Придбання преміуму надає доступ до тестів ЗНО усіх попередніх років.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24.sp)),
                  SizedBox(height: 50.h),
                  const Text(
                    'З таких предметів як Математика, Хімія і Фізика  доступні лише тести до 2019 року включно.',
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    '(станом на 20.09.2023)',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  const Text(
                    'Наступні тести з цих предметів поступово додаватимуться з часом.',
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 40.h),
                    child: locator.get<AuthService>().isLoggedIn
                        ? const ButtonGooglePay()
                        : const ButtonGoogleLogin(),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
