import 'package:client/models/exam_file_adress_model.dart';
import 'package:client/routes/session_route/state/session_route_state_model.dart';
import 'package:client/routes/session_route/widgets/prev_attempts_list.dart';
import 'package:client/routes/session_route/widgets/timer_button.dart';
import 'package:client/widgets/zno_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SessionDisplay extends StatelessWidget {
  final ExamFileAddressModel sessionData;

  const SessionDisplay({
    super.key,
    required this.sessionData,
  });

  void _onStartAttempt(BuildContext context) {
    context.read<SessionRouteStateModel>().onStartAttempt(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340.w,
      margin: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10.h),
            child: _SessionNameHeader(text: sessionData.sessionName),
          ),
          const Expanded(
            child: PrevAttemptsList(),
          ),
          SizedBox(height: 10.h),
          const TimerButton(),
          SizedBox(height: 15.h),
          ZnoListItem(
            text: 'Почати спробу',
            colorType: ZnoListColorType.button,
            onTap: () => _onStartAttempt(context),
          )
        ],
      ),
    );
  }
}

class _SessionNameHeader extends StatelessWidget {
  final String text;
  const _SessionNameHeader({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: const Color(0xFF444444),
        fontSize: 26.sp,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
