import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StorageListRadioButton extends StatelessWidget {
  final bool isMarked;

  const StorageListRadioButton({
    Key? key,
    required this.isMarked
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.r,
      height: 30.r,
      margin: EdgeInsets.fromLTRB(0, 0, 8.w, 0),
      decoration: BoxDecoration(
          color: const Color(0xFF76AE62).withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isMarked
                ? const Color(0xFF418C4A).withOpacity(0.8)
                : const Color(0xFF363636).withOpacity(0.1),
            width: 2,
          )
      ),
      child: isMarked
        ? Center(
          child: Container(
            width: 20.r,
            height: 20.r,
            decoration: BoxDecoration(
              color: const Color(0xFF50B45C),
              borderRadius: BorderRadius.circular(6)
            ),
          ),
        )
        : null
    );
  }
}
