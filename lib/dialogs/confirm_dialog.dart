import 'package:client/widgets/zno_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmDialog extends StatelessWidget {
  final String text;

  const ConfirmDialog({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 260.w,
        height: 235.h,
        padding: EdgeInsets.fromLTRB(6.w, 14.h, 6.w, 14.h),
        decoration: const BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 24.sp),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ZnoButton(
                  onTap: () => Navigator.pop(context, false),
                  width: 100.w,
                  height: 50.h,
                  text: 'Ні',
                  fontSize: 20.sp,
                ),
                SizedBox(
                  width: 30.w,
                ),
                ZnoButton(
                  onTap: () => Navigator.pop(context, true),
                  width: 100.w,
                  height: 50.h,
                  text: 'Так',
                  fontSize: 20.sp,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
