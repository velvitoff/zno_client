import 'package:client/widgets/zno_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ZnoError extends StatelessWidget {
  final String text;
  final String? buttonText;
  final void Function()? onTap;
  final double? textFontSize;
  final Color? textColor;
  final double? buttonFontSize;
  const ZnoError({
    super.key,
    required this.text,
    this.buttonText,
    this.onTap,
    this.textFontSize,
    this.textColor,
    this.buttonFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicHeight(
        child: Column(
          children: [
            Text(
              text,
              style:
                  TextStyle(fontSize: textFontSize ?? 27.sp, color: textColor),
              textAlign: TextAlign.center,
            ),
            onTap != null
                ? Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: ZnoButton(
                        width: 200.w,
                        height: 70.h,
                        text: buttonText ?? '',
                        onTap: onTap ?? () {},
                        fontSize: buttonFontSize ?? 27.sp),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
