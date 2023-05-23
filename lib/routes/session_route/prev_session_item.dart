import 'package:client/dto/previous_session_data.dart';
import 'package:client/dto/testing_route_data.dart';
import 'package:client/models/session_route_model.dart';
import 'package:client/routes.dart';
import 'package:client/dialogs/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PrevSessionItem extends StatelessWidget {
  final PreviousSessionData data;

  const PrevSessionItem({
    Key? key,
    required this.data
  }) : super(key: key);

  void onRestoreSession(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(
        text: data.completed ? 'Переглянути спробу?' : 'Продовжити спробу?'
      )
    )
    .then((bool? value) {
      if (value != null && value == true) {
        context.go(
            Routes.testingRoute,
            extra: TestingRouteData(
                sessionData: context.read<SessionRouteModel>().sessionData,
                prevSessionData: data
            )
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onRestoreSession(context),
      child: Container(
          width: 290.w,
          height: 60.h,
          margin: EdgeInsets.fromLTRB(15.w, 7.5.h, 15.w, 7.5.h),
          decoration: BoxDecoration(
              gradient: data.completed
                  ?
              const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(153, 215, 132, 0.7),
                    Color.fromRGBO(118, 174, 98, 0.73)
                  ]
              )
                  :
              const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(238, 134, 59, 0.5),
                    Color.fromRGBO(205, 133, 47, 0.62)
                  ]
              ),
              border: Border.all(
                color: const Color.fromRGBO(54, 54, 54, 0.04),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(14.w, 0, 0, 0),
                child: Text(
                    data.date.toString().split(' ').first,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: const Color(0xFF444444)
                    )
                ),
              ),
              const Spacer(),
              Container(
                margin: data.completed ? EdgeInsets.fromLTRB(0, 0, 56.w, 0) : EdgeInsets.fromLTRB(0, 0, 14.w, 0),
                child: Text(
                  data.completed ? data.score! : 'Спробу не завершено',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: const Color(0xFF444444)
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
