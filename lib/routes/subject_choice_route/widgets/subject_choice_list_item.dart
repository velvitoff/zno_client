import 'package:auto_size_text/auto_size_text.dart';
import 'package:client/routes/subject_choice_route/state/subject_choice_route_state_model.dart';
import 'package:client/widgets/zno_radio_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SubjectChoiceListItem extends StatelessWidget {
  final String subjectKey;
  final String subjectName;

  const SubjectChoiceListItem(
      {super.key, required this.subjectKey, required this.subjectName});

  void _onMarkSubject(BuildContext context) {
    context.read<SubjectChoiceRouteStateModel>().setIsMarked(subjectKey);
  }

  @override
  Widget build(BuildContext context) {
    final isMarked =
        context.watch<SubjectChoiceRouteStateModel>().getIsMarked(subjectKey);

    BoxDecoration decoration = BoxDecoration(
        border: Border.all(width: 2, color: const Color(0x0A363636)),
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(118, 174, 98, 0.02),
          Color.fromRGBO(118, 174, 98, 0.04)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight));

    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _onMarkSubject(context),
            child: Container(
              width: 70.r,
              height: 70.r,
              decoration: decoration,
              child: Center(
                child: ZnoRadioBox(
                  isActive: isMarked,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15.r,
          ),
          GestureDetector(
            onTap: () => _onMarkSubject(context),
            child: Container(
              width: 245.w,
              height: 70.r,
              padding: EdgeInsets.all(4.r),
              decoration: decoration,
              child: Center(
                child: AutoSizeText(
                  subjectName,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
