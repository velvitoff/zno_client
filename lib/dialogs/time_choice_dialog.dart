import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeChoiceDialog extends StatelessWidget {
  const TimeChoiceDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 260.w,
        height: 220.h,
        padding: EdgeInsets.fromLTRB(6.w, 14.h, 6.w, 14.h),
        decoration: const BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.all(Radius.circular(2))),
        child: Column(
          children: [
            MaterialButton(
              child: const Text('1h'),
              onPressed: () => Navigator.pop(context, 3600),
            ),
            MaterialButton(
              child: const Text('2h'),
              onPressed: () => Navigator.pop(context, 7200),
            ),
            MaterialButton(
              child: const Text('3h'),
              onPressed: () => Navigator.pop(context, 10800),
            ),
          ],
        ),
      ),
    );
  }
}
