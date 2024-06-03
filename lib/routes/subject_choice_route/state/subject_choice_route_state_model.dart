import 'package:client/all_subjects/all_subjects.dart';
import 'package:client/all_subjects/zno_subject.dart';
import 'package:client/all_subjects/zno_subject_group.dart';
import 'package:client/locator.dart';
import 'package:client/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubjectChoiceRouteStateModel extends ChangeNotifier {
  Map<String, bool> subjects;

  SubjectChoiceRouteStateModel({required this.subjects});

  // Returns a list of subjects user has selected to be shown on the subjects_route
  static Future<Map<String, bool>> pullSubjectsFromConfig() async {
    Map<String, bool> result = {};
    final List<String> selectedSubjects =
        (await locator.get<StorageService>().getPersonalConfigModel())
            .selectedSubjects;

    for (var sub in allSubjects) {
      if (sub is ZnoSubject) {
        result[sub.getId] = selectedSubjects.contains(sub.getId);
      } else if (sub is ZnoSubjectGroup) {
        for (var innerSub in sub.getChildren()) {
          result[innerSub.getId] = selectedSubjects.contains(innerSub.getId);
        }
      }
    }
    return result;
  }

  void setIsMarked(String subject) {
    for (var key in subjects.keys) {
      if (subject == key) {
        subjects[subject] = !subjects[subject]!;
        notifyListeners();
        break;
      }
    }
  }

  bool getIsMarked(String subject) {
    return subjects[subject] == true;
  }

  Future<void> savePersonalConfigChanges() async {
    final data = await locator.get<StorageService>().getPersonalConfigModel();
    final newData = data.copyWith(
        selectedSubjects: subjects.entries
            .where((element) => element.value == true)
            .map((element) => element.key)
            .toList());
    await locator.get<StorageService>().savePersonalConfigData(newData);
  }

  Future<void> onBack(BuildContext context) async {
    //save user's changes
    final List<String> newPreferenceList = subjects.entries
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
}
