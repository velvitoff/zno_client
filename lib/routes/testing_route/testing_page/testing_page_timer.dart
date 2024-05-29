import 'package:client/locator.dart';
import 'package:client/services/dialog_service.dart';
import 'package:client/state_models/testing_time_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TestingPageTimer extends StatelessWidget {
  const TestingPageTimer({super.key});

  formattedTime(int time) {
    int sec = time % 60;
    int min = (time / 60).floor();
    int h = (time / 3600).floor();
    min = min - h * 60;

    return "${h.toString().padLeft(2, '0')} : ${min.toString().padLeft(2, '0')} : ${sec.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final timeData = context.select<TestingTimeStateModel, (int, int)>(
        (value) => (value.secondsSinceStart, value.secondsInTotal));
    if (timeData.$2 - timeData.$1 <= 0) {
      return const Text('Час вичерпано');
    }

    return GestureDetector(
      onTap: () => _onTap(context),
      child: Container(
        margin: EdgeInsets.only(top: 5.h),
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF3C6D42), width: 3),
            borderRadius: BorderRadius.circular(5)),
        child: Text(formattedTime(timeData.$2 - timeData.$1),
            style: TextStyle(fontSize: 22.sp)),
      ),
    );
  }

  void _onTap(BuildContext context) {
    locator
        .get<DialogService>()
        .showTimeChoiceDialog(context)
        .then((int? value) {
      if (value != null) {
        context.read<TestingTimeStateModel>().secondsInTotal = value;
      }
    });
  }
}
