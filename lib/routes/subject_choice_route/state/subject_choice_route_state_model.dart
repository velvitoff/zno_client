import 'package:client/all_subjects/all_subjects.dart';
import 'package:client/all_subjects/zno_subject.dart';
import 'package:client/all_subjects/zno_subject_group.dart';
import 'package:client/locator.dart';
import 'package:client/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubjectChoiceRouteStateModel extends ChangeNotifier {
  Future<Map<String, bool>> subjectsFuture;

  SubjectChoiceRouteStateModel({required this.subjectsFuture});

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

  Future<void> setIsMarked(String subject) async {
    final subjects = await subjectsFuture;

    for (var key in subjects.keys) {
      if (subject == key) {
        subjects[subject] = !subjects[subject]!;
        notifyListeners();
        break;
      }
    }
  }

  Future<bool> getIsMarked(String subject) async {
    final subjects = await subjectsFuture;

    return subjects[subject] == true;
  }

  Future<void> savePersonalConfigChanges() async {
    final subjects = await subjectsFuture;
    final data = await locator.get<StorageService>().getPersonalConfigModel();
    final newData = data.copyWith(
        selectedSubjects: subjects.entries
            .where((element) => element.value == true)
            .map((element) => element.key)
            .toList());
    await locator.get<StorageService>().savePersonalConfigData(newData);
  }

  void onBack(BuildContext context) {
    if (!context.canPop()) return;
    context.pop();
  }

  Future<void> onPop() async {
    savePersonalConfigChanges();
  }
}
