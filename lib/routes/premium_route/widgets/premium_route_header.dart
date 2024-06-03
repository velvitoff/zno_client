import 'package:client/routes/premium_route/state/premium_route_state_model.dart';
import 'package:client/widgets/zno_icon_button.dart';
import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:client/routes/premium_route/widgets/user_avatar.dart';
import 'package:provider/provider.dart';

class PremiumRouteHeader extends StatelessWidget {
  const PremiumRouteHeader({super.key});

  void _onBack(BuildContext context) {
    context.read<PremiumRouteStateModel>().onBack(context);
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
                onTap: () => _onBack(context),
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
