import 'package:client/models/testing_route_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../widgets/zno_button.dart';

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
      childList.add(ZnoButton(
        onTap: onBack,
        width: 145.w,
        height: 50.h,
        margin: EdgeInsets.fromLTRB(7.5.w, 0, 7.5.w, 0),
        padding: EdgeInsets.all(5.r),
        text: 'Назад',
        fontSize: 20.sp,
      ));
    }

    if (!isLastPage) {
      childList.add(ZnoButton(
        onTap: onForward,
        width: isFirstPage ? 290.w : 145.w,
        height: 50.h,
        margin: EdgeInsets.fromLTRB(7.5.w, 0, 7.5.w, 0),
        padding: EdgeInsets.all(5.r),
        text: 'Далі',
        fontSize: 20.sp,
      ));
    }
    //isLastPage
    else {
      if (context.read<TestingRouteModel>().isViewMode) {
        childList.add(ZnoButton(
            onTap: onForward,
            width: 145.w,
            height: 50.h,
            margin: EdgeInsets.fromLTRB(7.5.w, 0, 7.5.w, 0),
            padding: EdgeInsets.all(5.r),
            text: 'Завершити перегляд',
            fontSize: 17.sp));
      } else {
        childList.add(ZnoButton(
            onTap: onForward,
            width: 145.w,
            height: 50.h,
            margin: EdgeInsets.fromLTRB(7.5.w, 0, 7.5.w, 0),
            padding: EdgeInsets.all(5.r),
            text: 'Завершити спробу',
            fontSize: 18.sp));
      }
    }

    return Container(
      height: 50.h,
      margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: childList,
      ),
    );
  }
}
