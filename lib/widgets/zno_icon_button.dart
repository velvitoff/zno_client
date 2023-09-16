import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ZnoIconButton extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;
  const ZnoIconButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Icon(
          icon,
          size: 45.sp,
          color: const Color.fromARGB(240, 250, 250, 250),
        ));
  }
}
