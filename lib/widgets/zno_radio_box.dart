import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ZnoRadioBox extends StatelessWidget {
  final bool isActive;
  final bool isBorderDarker;

  const ZnoRadioBox({
    Key? key,
    required this.isActive,
    this.isBorderDarker = false
  }) : super(key: key);

  Color getBorderColor() {
    if (!isActive) {
      return const Color.fromRGBO(54, 54, 54, 0.1);
    }
    else if (isBorderDarker) {
      return const Color.fromRGBO(54, 54, 54, 0.3);
    }
    else {
      return const Color.fromRGBO(65, 140, 74, 0.8);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.r,
      width: 30.r,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(118, 174, 98, 0.04),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          width: 2,
          color: getBorderColor()
        )
      ),
      child: Center(
        child: !isActive
          ? Container()
          : Container(
            height: 20.r,
            width: 20.r,
            decoration: const BoxDecoration(
              color: Color(0xFF50B45C),
              borderRadius: BorderRadius.all(Radius.circular(6))
            ),
          )
      ),
    );
  }
}
