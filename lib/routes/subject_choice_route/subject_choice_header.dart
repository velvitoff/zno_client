import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../dialogs/info_dialog.dart';
import '../../models/subject_choice_route_model.dart';
import '../../widgets/zno_top_header_small.dart';
import 'package:client/locator.dart';
import 'package:client/routes.dart';
import 'package:client/services/interfaces/storage_service_interface.dart';

class SubjectChoiceHeader extends StatelessWidget {
  const SubjectChoiceHeader({super.key});

  void onBackTap(BuildContext context) {
    //save user's changes
    final List<String> newPreferenceList = context
        .read<SubjectChoiceRouteModel>()
        .subjects
        .entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

    final storageService = locator.get<StorageServiceInterface>();

    storageService.getPersonalConfigData().then((config) {
      storageService
          .savePersonalConfigData(
              config.copyWith(selectedSubjects: newPreferenceList))
          .then((_) {
        context.go(Routes.subjectsRoute);
      });
    });
  }

  void showInfo(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => InfoDialog(
            height: 230.h,
            text:
                'Дана сторінка дозволяє обрати предмети, які відображатимуться на головній сторінці'));
  }

  @override
  Widget build(BuildContext context) {
    return ZnoTopHeaderSmall(
      backgroundColor: const Color(0xFFF5F5F5),
      child: Container(
        margin: EdgeInsets.fromLTRB(7.w, 0, 7.w, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => onBackTap(context),
              child: Icon(
                Icons.arrow_back,
                size: 45.sp,
                color: const Color(0xFFF5F5F5),
              ),
            ),
            GestureDetector(
              onTap: () => showInfo(context),
              child: Icon(
                Icons.help_outline,
                size: 43.sp,
                color: const Color(0xFFF1F1F1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
