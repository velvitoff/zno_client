import 'package:client/dto/personal_config_data.dart';
import 'package:client/locator.dart';
import 'package:client/services/interfaces/storage_service_interface.dart';
import 'package:flutter/material.dart';

import '../all_subjects.dart';

class SubjectChoiceRouteModel extends ChangeNotifier {
  Map<String, bool> subjects;

  SubjectChoiceRouteModel({required this.subjects});

  static Future<SubjectChoiceRouteModel> pullSubjectsFromConfig() async {
    final List<String> selectedSubjects =
        (await locator.get<StorageServiceInterface>().getPersonalConfigData())
            .selectedSubjects;
    Map<String, bool> result = {};

    for (var entry in allSubjects.entries) {
      if (entry.value is Map) {
        final value = entry.value as Map<String, String>;
        for (var key in value.keys) {
          if (selectedSubjects.contains(key)) {
            result[key] = true;
          }
        }
      } else if (selectedSubjects.contains(entry.key)) {
        result[entry.key] = true;
      } else {
        result[entry.key] = false;
      }
    }
    return SubjectChoiceRouteModel(subjects: result);
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
    final data =
        await locator.get<StorageServiceInterface>().getPersonalConfigData();
    final newData = data.copyWith(
        selectedSubjects: subjects.entries
            .where((element) => element.value == true)
            .map((element) => element.key)
            .toList());
    await locator
        .get<StorageServiceInterface>()
        .savePersonalConfigData(newData);
  }
}
