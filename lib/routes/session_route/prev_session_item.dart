import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrevSessionItem extends StatelessWidget {
  final DateTime date;
  final String? score;
  final bool completed;

  const PrevSessionItem({
    Key? key,
    required this.date,
    required this.score,
    required this.completed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290.w,
      height: 60.h,
      margin: EdgeInsets.fromLTRB(15.w, 7.5.h, 15.w, 7.5.h),
      decoration: BoxDecoration(
        gradient: completed
        ?
        const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(153, 215, 132, 0.7),
            Color.fromRGBO(118, 174, 98, 0.73)
          ]
        )
        :
        const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(238, 134, 59, 0.5),
            Color.fromRGBO(205, 133, 47, 0.62)
          ]
        ),
        border: Border.all(
          color: const Color.fromRGBO(54, 54, 54, 0.04),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(14.w, 0, 0, 0),
            child: Text(
                date.toString().split(' ').first,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18.sp,
                    color: const Color(0xFF444444)
                )
            ),
          ),
          const Spacer(),
          Container(
            margin: completed ? EdgeInsets.fromLTRB(0, 0, 56.w, 0) : EdgeInsets.fromLTRB(0, 0, 14.w, 0),
            child: Text(
              completed ? score! : 'Спробу не завершено',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18.sp,
                  color: const Color(0xFF444444)
              ),
            ),
          )
        ],
      )
    );
  }
}
