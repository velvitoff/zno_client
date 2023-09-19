import 'package:client/routes.dart';
import 'package:client/routes/premium_route/button_google_pay.dart';
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
          child: Align(
            alignment: Alignment.centerLeft,
            child: ZnoIconButton(
                icon: Icons.arrow_back,
                onTap: () => context.go(Routes.settingsRoute)),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 20.w, left: 20.w),
            child: Column(
              children: [Text(''), ButtonGooglePay()],
            ),
          ),
        )
      ],
    ));
  }
}
