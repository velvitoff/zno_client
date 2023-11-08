import 'package:client/dto/previous_session_data.dart';
import 'package:client/dto/testing_route_data.dart';
import 'package:client/routes.dart';
import 'package:client/dialogs/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../dto/session_data.dart';
import '../locator.dart';
import '../services/interfaces/utils_service_interface.dart';

class PrevSessionItem extends StatelessWidget {
  final PreviousSessionData data;
  final bool detailed;

  const PrevSessionItem({Key? key, required this.data, this.detailed = false})
      : super(key: key);

  void onRestoreSession(BuildContext context) {
    showDialog<bool>(
        context: context,
        builder: (context) => ConfirmDialog(
            text: data.completed
                ? 'Переглянути спробу?'
                : 'Продовжити спробу?')).then((bool? value) {
      if (value != null && value == true) {
        context.go(Routes.testingRoute,
            extra: TestingRouteData(
              sessionData: SessionData(
                  subjectName: data.subjectName,
                  sessionName: data.sessionName,
                  folderName: data.folderName,
                  fileName: data.fileName,
                  fileNameNoExtension: data.fileName
                      .replaceFirst('.json', '')
                      .replaceFirst('.bin', '')),
              prevSessionData: data,
              isTimerActivated: data.isTimerActivated,
              timerSecondsInTotal: data.timerSecondsInTotal,
            ));
      }
    });
  }

  LinearGradient getGradient() {
    if (detailed) {
      return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(153, 215, 132, 0.04),
            Color.fromRGBO(118, 174, 98, 0.08)
          ]);
    }

    return data.completed
        ? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
                Color.fromRGBO(153, 215, 132, 0.7),
                Color.fromRGBO(118, 174, 98, 0.73)
              ])
        : const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
                Color.fromRGBO(178, 177, 176, 0.147),
                Color.fromRGBO(178, 177, 176, 0.247)
              ]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onRestoreSession(context),
      child: Container(
          height: detailed ? 120.h : 60.h,
          margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 16.h),
          padding: EdgeInsets.fromLTRB(14.w, 3.h, 0, 3.h),
          decoration: BoxDecoration(
              gradient: getGradient(),
              border: Border.all(
                color: const Color.fromRGBO(54, 54, 54, 0.1),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 165.w,
                child: detailed
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.subjectName,
                            style: TextStyle(
                                fontSize: 22.sp,
                                color: const Color(0xFF444444)),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            locator
                                .get<UtilsServiceInterface>()
                                .fileNameToSessionName(data.sessionName),
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: const Color(0xFF444444)),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(data.date.toString().split(' ').first,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color: const Color(0xFF444444))),
                        ],
                      )
                    : Text(data.date.toString().split(' ').first,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18.sp, color: const Color(0xFF444444))),
              ),
              SizedBox(
                width: 100.w,
                child: Text(
                  data.completed ? data.score! : 'Спробу не завершено',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18.sp, color: const Color(0xFF444444)),
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
              )
            ],
          )),
    );
  }
}
