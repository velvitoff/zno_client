import 'package:client/dialogs/time_choice_dialog.dart';
import 'package:client/dto/testing_route_data.dart';
import 'package:client/models/session_route_model.dart';
import 'package:client/routes.dart';
import 'package:client/routes/session_route/prev_sessions_list.dart';
import 'package:client/routes/session_route/session_name_header.dart';
import 'package:client/routes/session_route/timer_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../widgets/zno_list_item.dart';

class SessionDisplay extends StatelessWidget {
  const SessionDisplay({Key? key}) : super(key: key);

  void onSessionStart(BuildContext context, SessionRouteModel model) {
    if (!model.isTimerSelected) {
      context.go(Routes.testingRoute,
          extra: TestingRouteData(
              sessionData: model.sessionData,
              prevSessionData: null,
              isTimerActivated: false,
              timerSecondsInTotal: 7200));
    } else {
      showDialog<int?>(
          context: context,
          builder: (context) => const TimeChoiceDialog()).then((int? value) {
        if (value != null) {
          context.go(Routes.testingRoute,
              extra: TestingRouteData(
                  sessionData: model.sessionData,
                  prevSessionData: null,
                  isTimerActivated: true,
                  timerSecondsInTotal: value));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SessionRouteModel model = context.read<SessionRouteModel>();
    return Container(
      width: 340.w,
      margin: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10.h),
            child: SessionNameHeader(text: model.sessionData.sessionName),
          ),
          Expanded(
            child: PrevSessionsList(
                subjectName: model.sessionData.folderName,
                sessionName: model.sessionData.fileNameNoExtension),
          ),
          SizedBox(height: 10.h),
          const TimerButton(),
          SizedBox(height: 15.h),
          ZnoListItem(
            text: 'Почати спробу',
            colorType: ZnoListColorType.button,
            onTap: () => onSessionStart(context, model),
          )
        ],
      ),
    );
  }
}
