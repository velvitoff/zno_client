import 'package:client/routes/session_route/state/session_route_state_model.dart';
import 'package:client/widgets/zno_radio_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TimerButton extends StatelessWidget {
  const TimerButton({super.key});

  void _onTap(BuildContext context) {
    context.read<SessionRouteStateModel>().invertTimerSelected();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.fromLTRB(4.w, 0, 4.w, 0),
              child: ZnoRadioBox(
                  isActive:
                      context.watch<SessionRouteStateModel>().isTimerSelected),
            ),
          ),
          Flexible(
            flex: 4,
            child: Text(
              'Показувати таймер під час проходження',
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF444444),
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
