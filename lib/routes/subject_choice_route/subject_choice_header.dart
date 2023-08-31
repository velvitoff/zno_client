import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../dialogs/info_dialog.dart';
import '../../widgets/zno_top_header_small.dart';

class SubjectChoiceHeader extends StatefulWidget {
  const SubjectChoiceHeader({super.key});

  @override
  State<SubjectChoiceHeader> createState() => _SubjectChoiceHeaderState();
}

class _SubjectChoiceHeaderState extends State<SubjectChoiceHeader> {
  void showInfo(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => InfoDialog(
            height: 200.h,
            text:
                'Ця сторінка дозволяє обрати предмети, які відображатимуться на головній сторінці'));
  }

  @override
  Widget build(BuildContext context) {
    return ZnoTopHeaderSmall(
      backgroundColor: const Color(0xFFF5F5F5),
      child: Container(
        margin: EdgeInsets.only(right: 12.w),
        child: Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => showInfo(context),
            child: Icon(
              Icons.help_outline,
              size: 43.sp,
              color: const Color(0xFFF1F1F1),
            ),
          ),
        ),
      ),
    );
  }
}
