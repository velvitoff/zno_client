import 'package:client/widgets/zno_icon_button.dart';
import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:client/routes/premium_route/widgets/user_avatar.dart';

class PremiumRouteHeader extends StatelessWidget {
  const PremiumRouteHeader({super.key});

  void _goBack(BuildContext context) {
    if (!context.canPop()) return;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return ZnoTopHeaderSmall(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: ZnoIconButton(
                icon: Icons.arrow_back,
                onTap: () => _goBack(context),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 6.w, top: 8.h, bottom: 8.h),
              child: SizedBox(
                width: 70.h,
                child: const UserAvatar(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
