import 'package:client/widgets/golden_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsItem extends StatelessWidget {
  final Widget icon;
  final String text;
  final void Function() onTap;
  final bool goldenBorder;

  const SettingsItem(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onTap,
      this.goldenBorder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 320.w,
            height: 60.h,
            margin: EdgeInsets.only(bottom: 5.h, top: 5.h),
            decoration: BoxDecoration(
                border: goldenBorder
                    ? null
                    : Border.all(width: 2, color: const Color(0x0A363636)),
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(colors: [
                  Color.fromRGBO(118, 174, 98, 0.02),
                  Color.fromRGBO(118, 174, 98, 0.04)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ),
          goldenBorder
              ? CustomPaint(
                  painter: GoldenBorder(sWidth: 3.0),
                  child: SizedBox(height: 60.h, width: 320.w),
                )
              : Container(),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: icon,
              ),
              Text(
                text,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w400),
              )
            ],
          )
        ],
      ),
    );
  }
}
