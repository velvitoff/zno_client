import 'package:client/routes/testing_route/testing_route_data.dart';
import 'package:client/locator.dart';
import 'package:client/state_models/session_route_state_model.dart';
import 'package:client/routes.dart';
import 'package:client/routes/session_route/widgets/prev_attempts_list.dart';
import 'package:client/routes/session_route/widgets/timer_button.dart';
import 'package:client/services/dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../widgets/zno_list_item.dart';

class SessionDisplay extends StatelessWidget {
  const SessionDisplay({Key? key}) : super(key: key);

  Future<void> _onSessionStart(
    BuildContext context,
    SessionRouteStateModel model,
  ) async {
    int? timeValue;
    if (model.isTimerSelected) {
      timeValue =
          await locator.get<DialogService>().showTimeChoiceDialog(context);
    }

    if (!context.mounted) return;
    context.go(Routes.testingRoute,
        extra: TestingRouteData(
            examFileAddress: model.sessionData,
            prevAttemptModel: null,
            isTimerActivated: false,
            timerSecondsInTotal: timeValue ?? 7200));
  }

  @override
  Widget build(BuildContext context) {
    SessionRouteStateModel model = context.read<SessionRouteStateModel>();
    return Container(
      width: 340.w,
      margin: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10.h),
            child: _SessionNameHeader(text: model.sessionData.sessionName),
          ),
          Expanded(
            child: PrevAttemptsList(
                subjectName: model.sessionData.folderName,
                sessionName: model.sessionData.fileNameNoExtension),
          ),
          SizedBox(height: 10.h),
          const TimerButton(),
          SizedBox(height: 15.h),
          ZnoListItem(
            text: 'Почати спробу',
            colorType: ZnoListColorType.button,
            onTap: () => _onSessionStart(context, model),
          )
        ],
      ),
    );
  }
}

class _SessionNameHeader extends StatelessWidget {
  final String text;
  const _SessionNameHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: const Color(0xFF444444),
          fontSize: 26.sp,
          fontWeight: FontWeight.w400),
    );
  }
}
