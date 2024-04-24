import 'package:client/all_subjects/zno_subject.dart';
import 'package:client/all_subjects/zno_subject_group.dart';
import 'package:client/locator.dart';
import 'package:client/services/storage_service.dart';
import 'package:flutter/material.dart';

import '../all_subjects/all_subjects.dart';

class SubjectChoiceRouteStateModel extends ChangeNotifier {
  Map<String, bool> subjects;

  SubjectChoiceRouteStateModel({required this.subjects});

  static Future<SubjectChoiceRouteStateModel> pullSubjectsFromConfig() async {
    final List<String> selectedSubjects =
        (await locator.get<StorageService>().getPersonalConfigData())
            .selectedSubjects;
    Map<String, bool> result = {};

    for (var sub in allSubjects) {
      if (sub is ZnoSubject) {
        result[sub.getId] = selectedSubjects.contains(sub.getId);
      } else if (sub is ZnoSubjectGroup) {
        for (var innerSub in sub.getChildren()) {
          result[innerSub.getId] = selectedSubjects.contains(innerSub.getId);
        }
      }
    }
    return SubjectChoiceRouteStateModel(subjects: result);
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
    final data = await locator.get<StorageService>().getPersonalConfigData();
    final newData = data.copyWith(
        selectedSubjects: subjects.entries
            .where((element) => element.value == true)
            .map((element) => element.key)
            .toList());
    await locator.get<StorageService>().savePersonalConfigData(newData);
  }
}
