import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../state_models/session_route_state_model.dart';
import '../../widgets/zno_radio_box.dart';

class TimerButton extends StatelessWidget {
  const TimerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<SessionRouteStateModel>().invertTimerSelected(),
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
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
