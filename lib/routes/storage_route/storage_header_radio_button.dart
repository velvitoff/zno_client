import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StorageHeaderRadioButton extends StatelessWidget {
  final bool isMarked;

  const StorageHeaderRadioButton({
    Key? key,
    required this.isMarked
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 30.r,
        height: 30.r,
        decoration: BoxDecoration(
            color: const Color(0xFF6DA759).withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFDADADA).withOpacity(0.7),
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
