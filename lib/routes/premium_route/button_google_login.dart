import 'package:client/widgets/icons/zno_google_icon.dart';
import 'package:flutter/material.dart';
import 'package:client/locator.dart';
import 'package:client/services/implementations/auth_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonGoogleLogin extends StatelessWidget {
  const ButtonGoogleLogin({super.key});

  //TO DO: Error handling
  void onClick() {
    final authService = locator.get<AuthService>();
    authService.setAuthProviderGoogle();
    authService.signIn();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 65.h,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 0.75))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 5.h),
                child: CustomPaint(
                  isComplex: true,
                  painter: ZnoGoogleIcon(),
                  child: SizedBox(
                    height: 48.r,
                    width: 48.r,
                  ),
                )),
            SizedBox(width: 30.w),
            Text(
              'Увійти через Google',
              style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 16, 16, 16)),
            )
          ],
        ),
      ),
    );
  }
}
