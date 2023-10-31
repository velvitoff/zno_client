import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../dialogs/info_dialog.dart';
import '../../locator.dart';
import '../../models/subject_choice_route_model.dart';
import '../../routes.dart';
import '../../services/interfaces/storage_service_interface.dart';
import '../../widgets/zno_icon_button.dart';
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

  Future<void> onClose(BuildContext context) async {
    //save user's changes
    final List<String> newPreferenceList = context
        .read<SubjectChoiceRouteModel>()
        .subjects
        .entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

    final storageService = locator.get<StorageServiceInterface>();

    await storageService.getPersonalConfigData().then((config) {
      storageService.savePersonalConfigData(
          config.copyWith(selectedSubjects: newPreferenceList));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZnoTopHeaderSmall(
      backgroundColor: const Color(0xFFF5F5F5),
      child: Container(
        margin: EdgeInsets.only(right: 12.w, left: 6.w),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ZnoIconButton(
                icon: Icons.arrow_back,
                onTap: () {
                  onClose(context)
                      .then((_) => context.go(Routes.settingsRoute));
                },
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text('Вибір предметів',
                  style: TextStyle(
                      color: const Color(0xFFEFEFEF), fontSize: 24.sp)),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ZnoIconButton(
                icon: Icons.help_outline,
                onTap: () => showInfo(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
