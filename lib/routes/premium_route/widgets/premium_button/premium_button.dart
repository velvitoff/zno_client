import 'package:flutter/material.dart';
import 'package:client/routes/premium_route/widgets/premium_button/button_google_login.dart';
import 'package:client/routes/premium_route/widgets/premium_button/button_google_pay.dart';
import 'package:client/widgets/golden_border.dart';
import 'package:client/auth/state/auth_state_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PremiumButton extends StatelessWidget {
  const PremiumButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthStateModel model = context.watch<AuthStateModel>();

    if (model.currentUser == null) return const ButtonGoogleLogin();
    if (!model.isPremium) return const ButtonGooglePay();

    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          painter: GoldenBorder(sWidth: 3.0),
          child: SizedBox(height: 60.h, width: 320.w),
        ),
        const Text(
          'Ви вже придбали преміум',
          style: TextStyle(fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
