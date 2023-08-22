import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeChoiceDialog extends StatelessWidget {
  const TimeChoiceDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<(String, int)> items = [
      ('Одна година', 3600),
      ('Дві години', 7200),
      ('Три години', 10800)
    ];

    return Dialog(
      child: Container(
        width: 260.w,
        height: 290.h,
        padding: EdgeInsets.fromLTRB(6.w, 14.h, 6.w, 14.h),
        decoration: const BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Оберіть час таймера', style: TextStyle(fontSize: 24.sp)),
            SizedBox(
              height: 7.h,
            ),
            ...items
                .map((x) => GestureDetector(
                      onTap: () => Navigator.pop(context, x.$2),
                      child: Container(
                        height: 60.h,
                        padding: EdgeInsets.all(4.r),
                        margin: EdgeInsets.all(5.r),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 2,
                                color: const Color.fromARGB(195, 52, 151, 64))),
                        child: Center(
                          child: Text(
                            x.$1,
                            style: TextStyle(fontSize: 24.sp),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
