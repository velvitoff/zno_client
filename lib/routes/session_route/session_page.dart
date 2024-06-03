import 'package:client/routes/session_route/state/session_route_state_model.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/zno_icon_button.dart';
import 'package:client/widgets/zno_top_header_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:client/routes/session_route/widgets/session_display.dart';
import 'package:provider/provider.dart';

class SessionPage extends StatelessWidget {
  const SessionPage({super.key});

  void _onBack(BuildContext context) {
    context.read<SessionRouteStateModel>().onBack(context);
  }

  @override
  Widget build(BuildContext context) {
    final sessionData = context.read<SessionRouteStateModel>().inputSessionData;

    return Column(
      children: [
        ZnoTopHeaderText(
          text: sessionData.subjectName,
          fontSize: sessionData.subjectName.length > 24 ? 21.5.sp : 25.sp,
          topLeftWidget: Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: ZnoIconButton(
              icon: Icons.arrow_back,
              onTap: () => _onBack(context),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: SessionDisplay(
              sessionData: sessionData,
            ),
          ),
        ),
      ],
    );
  }
}
