import 'package:flutter/material.dart';
import 'package:client/routes/subject_choice_route/subject_choice_header.dart';
import 'package:client/routes/subject_choice_route/subject_choice_list.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:client/locator.dart';
import 'package:client/services/interfaces/storage_service_interface.dart';
import 'package:provider/provider.dart';
import '../../models/subject_choice_route_model.dart';

class SubjectChoiceLayout extends StatelessWidget {
  const SubjectChoiceLayout({super.key});

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
    return Column(
      children: [
        const SubjectChoiceHeader(),
        const Expanded(child: SubjectChoiceList()),
        ZnoBottomNavigationBar(
          activeIndex: 1,
          onSwitchAsync: () async => onClose(context),
        )
      ],
    );
  }
}
