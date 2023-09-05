import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SessionNameHeader extends StatelessWidget {
  final String text;
  const SessionNameHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: const Color(0xFF444444),
          fontSize: 26.sp,
          fontWeight: FontWeight.w400),
    );
  }
}
