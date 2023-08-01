import 'package:client/models/subject_choice_route_model.dart';
import 'package:client/widgets/zno_radio_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SubjectChoiceListItem extends StatelessWidget {
  final String subjectKey;
  final String subjectName;

  const SubjectChoiceListItem(
      {super.key, required this.subjectKey, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration = BoxDecoration(
        border: Border.all(width: 2, color: const Color(0x0A363636)),
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(153, 215, 132, 0.03),
          Color.fromRGBO(118, 174, 98, 0.16)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight));

    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70.r,
            height: 70.r,
            margin: EdgeInsets.fromLTRB(0, 15.h, 0, 15.h),
            decoration: decoration,
            child: Center(
              child: GestureDetector(
                onTap: () => context
                    .read<SubjectChoiceRouteModel>()
                    .setIsMarked(subjectKey),
                child: ZnoRadioBox(
                    isActive: context
                        .watch<SubjectChoiceRouteModel>()
                        .getIsMarked(subjectKey)),
              ),
            ),
          ),
          SizedBox(
            width: 10.r,
          ),
          Container(
            width: 240.w,
            height: 70.r,
            margin: EdgeInsets.fromLTRB(0, 15.h, 0, 15.h),
            padding: EdgeInsets.all(4.r),
            decoration: decoration,
            child: Center(
              child: Text(subjectName,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: subjectName.length < 19 ? 27.sp : 22.sp,
                      fontWeight: FontWeight.w400)),
            ),
          )
        ],
      ),
    );
  }
}
