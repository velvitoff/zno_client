import 'package:client/dto/session_data.dart';
import 'package:client/dto/testing_route_data.dart';
import 'package:client/models/session_route_model.dart';
import 'package:client/routes.dart';
import 'package:client/routes/session_route/prev_sessions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../widgets/zno_list_item.dart';
import '../../widgets/zno_radio_box.dart';

class SessionDisplay extends StatelessWidget {

  const SessionDisplay({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SessionData dto = context.read<SessionRouteModel>().sessionData;

    return Container(
      width: 340.w,
      height: 460.h,
      margin: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 20.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(153, 215, 132, 0.02),
            Color.fromRGBO(118, 174, 98, 0.08),
          ],
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(
            width: 1.5,
            color: const Color(0x4C787878)
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 8.h, 0, 0),
            child: Text(
              dto.sessionName,
              style: TextStyle(
                  color: const Color(0xFF444444),
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w400
              ),
            ),
          ),
          PrevSessionsList(
            subjectName: dto.folderName,
            sessionName: dto.fileName.replaceAll('.json', '')
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(4.w, 0, 4.w, 0),
                      child: const ZnoRadioBox(isActive: false),
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
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  )
                ],
              ),
              ZnoListItem(
                text: 'Почати спробу',
                colorType: ZnoListColorType.button,
                onTap: () => context.go(
                  Routes.testingRoute,
                  extra: TestingRouteData(
                    sessionData: dto,
                    prevSessionData: null
                  )
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
