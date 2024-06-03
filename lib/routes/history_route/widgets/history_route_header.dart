import 'package:client/routes/history_route/state/history_route_state_model.dart';
import 'package:client/widgets/zno_icon_button.dart';
import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HistoryRouteHeader extends StatelessWidget {
  const HistoryRouteHeader({super.key});

  void _onBack(BuildContext context) {
    context.read<HistoryRouteStateModel>().onBack(context);
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
            alignment: Alignment.center,
            child: Text(
              'Історія',
              style: TextStyle(
                color: const Color(0xFFEFEFEF),
                fontSize: 24.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
