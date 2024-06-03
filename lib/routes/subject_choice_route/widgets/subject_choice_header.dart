import 'package:client/locator.dart';
import 'package:client/routes/subject_choice_route/state/subject_choice_route_state_model.dart';
import 'package:client/services/dialog_service.dart';
import 'package:client/services/storage_service.dart';
import 'package:client/widgets/zno_icon_button.dart';
import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SubjectChoiceHeader extends StatefulWidget {
  const SubjectChoiceHeader({super.key});

  @override
  State<SubjectChoiceHeader> createState() => _SubjectChoiceHeaderState();
}

class _SubjectChoiceHeaderState extends State<SubjectChoiceHeader> {
  void _showInfo(BuildContext context) {
    locator.get<DialogService>().showInfoDialog(
        context,
        'Ця сторінка дозволяє обрати предмети, які відображатимуться на головній сторінці',
        230.h);
  }

  Future<void> _onClose(BuildContext context) async {
    //save user's changes
    final List<String> newPreferenceList = context
        .read<SubjectChoiceRouteStateModel>()
        .subjects
        .entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

    final storageService = locator.get<StorageService>();
    final config = await storageService.getPersonalConfigModel();
    storageService.savePersonalConfigData(
        config.copyWith(selectedSubjects: newPreferenceList));

    if (!context.mounted) return;
    if (!context.canPop()) return;
    context.pop();
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
                onTap: () => _onClose(context),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text('Вибір предметів',
                  style: TextStyle(
                    color: const Color(0xFFEFEFEF),
                    fontSize: 24.sp,
                  )),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ZnoIconButton(
                icon: Icons.help_outline,
                onTap: () => _showInfo(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
