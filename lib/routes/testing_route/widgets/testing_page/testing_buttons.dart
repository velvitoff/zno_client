import 'package:client/routes/testing_route/state/testing_route_state_model.dart';
import 'package:client/widgets/zno_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TestingButtons extends StatelessWidget {
  final void Function() onBack;
  final void Function() onForward;
  final bool isFirstPage;
  final bool isLastPage;

  const TestingButtons(
      {Key? key,
      required this.onBack,
      required this.onForward,
      required this.isFirstPage,
      required this.isLastPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> childList = [];
    if (!isFirstPage) {
      childList.add(
        ZnoButton(
          onTap: onBack,
          width: 145.w,
          height: 50.h,
          margin: EdgeInsets.fromLTRB(7.5.w, 0, 7.5.w, 0),
          text: 'Назад',
          fontSize: 20.sp,
        ),
      );
    }

    if (!isLastPage) {
      childList.add(
        ZnoButton(
          onTap: onForward,
          width: isFirstPage ? 290.w : 145.w,
          height: 50.h,
          margin: EdgeInsets.fromLTRB(7.5.w, 0, 7.5.w, 0),
          text: 'Далі',
          fontSize: 20.sp,
        ),
      );
    }
    //isLastPage
    else {
      if (context.read<TestingRouteStateModel>().isViewMode) {
        childList.add(
          ZnoButton(
            onTap: onForward,
            width: 145.w,
            height: 50.h,
            margin: EdgeInsets.fromLTRB(7.5.w, 0, 7.5.w, 0),
            text: 'Завершити перегляд',
            fontSize: 17.sp,
          ),
        );
      } else {
        childList.add(ZnoButton(
            onTap: onForward,
            width: 145.w,
            height: 50.h,
            margin: EdgeInsets.fromLTRB(7.5.w, 0, 7.5.w, 0),
            text: 'Завершити спробу',
            fontSize: 17.sp));
      }
    }

    return Container(
      height: 50.h,
      margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
      child: childList.length == 1
          ? childList[0]
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: childList,
            ),
    );
  }
}
