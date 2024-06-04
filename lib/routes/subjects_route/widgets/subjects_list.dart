import 'package:client/all_subjects/zno_subject_interface.dart';
import 'package:client/routes/subjects_route/state/subjects_route_state_model.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/zno_button.dart';
import 'package:client/widgets/zno_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SubjectsList extends StatelessWidget {
  final List<ZnoSubjectInterface> list;
  const SubjectsList({super.key, required this.list});

  void _onTapNoSubjects(BuildContext context) {
    context.read<SubjectsRouteStateModel>().onTapSelectNewSubjects(context);
  }

  Future<void> _onTapSingleSubject(
    BuildContext context,
    ZnoSubjectInterface subject,
  ) async {
    context
        .read<SubjectsRouteStateModel>()
        .onTapOpenSingleSubject(context, subject);
  }

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return SliverToBoxAdapter(
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Text(
              'Наразі у списку немає предметів',
              style: TextStyle(fontSize: 22.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h),
            ZnoButton(
              width: 260.w,
              height: 60.h,
              text: 'Обрати предмети',
              onTap: () => _onTapNoSubjects(context),
              fontSize: 22.sp,
            )
          ],
        ),
      );
    }

    return ZnoList(
      list: list.map((subject) {
        return (subject.getName, () => _onTapSingleSubject(context, subject));
      }).toList(),
    );
  }
}
