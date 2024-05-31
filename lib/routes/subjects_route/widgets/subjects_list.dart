import 'package:client/all_subjects/zno_subject_interface.dart';
import 'package:client/locator.dart';
import 'package:client/routes/subjects_route/state/subjects_route_input_data.dart';
import 'package:client/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:client/routes.dart';
import 'package:client/routes/sessions_route/widgets/sessions_route_input_data.dart';
import 'package:client/widgets/zno_button.dart';
import 'package:client/widgets/zno_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SubjectsList extends StatelessWidget {
  final List<ZnoSubjectInterface> list;
  const SubjectsList({super.key, required this.list});

  void _onTapNoSubjects(BuildContext context) {
    context.go(Routes.subjectChoiceRoute);
  }

  Future<void> _onTapSingleSubject(
    BuildContext context,
    ZnoSubjectInterface subject,
  ) async {
    if (subject.getChildren().isEmpty) {
      context.go(
        Routes.sessionsRoute,
        extra: SessionsRouteInputData(
          subjectName: subject.getName,
          folderName: subject.getId,
        ),
      );
    } else {
      final config =
          await locator.get<StorageService>().getPersonalConfigModel();
      if (!context.mounted) return;

      context.go(Routes.subjectsRoute,
          extra: SubjectsRouteInputData(
              subjectsList: subject
                  .getChildren()
                  .where((e) => config.selectedSubjects.contains(e.getId))
                  .toList()));
    }
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
