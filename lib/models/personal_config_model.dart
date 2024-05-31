import 'package:client/all_subjects/zno_subject.dart';
import 'package:client/all_subjects/zno_subject_group.dart';
import 'package:client/all_subjects/zno_subject_interface.dart';

import '../all_subjects/all_subjects.dart';

class PersonalConfigModel {
  final bool isFirstTimeUser;
  final List<String> selectedSubjects;

  static String getSubjectFullName(String subject) {
    final res = searchAllSubjects(subject);
    if (res == null) {
      return '';
    }

    return res.getName;
  }

  static const List<String> defaultSubjectsList = [
    'ukrainian_lang_and_lit',
    'ukrainian_lang',
    'math',
    'nmt',
    'ukraine_history',
    'english_lang'
  ];

  const PersonalConfigModel(
      {required this.isFirstTimeUser, required this.selectedSubjects});

  factory PersonalConfigModel.fromJSON(Map<String, dynamic> map) =>
      PersonalConfigModel(
          isFirstTimeUser: map['is_first_time_user'] as bool,
          selectedSubjects: List<String>.from(
              map['selected_subjects'].map((x) => x as String)));

  // ignore: prefer_const_constructors
  factory PersonalConfigModel.getDefault() => PersonalConfigModel(
      isFirstTimeUser: true, selectedSubjects: defaultSubjectsList);

  PersonalConfigModel copyWith(
      {bool? isFirstTimeUser, List<String>? selectedSubjects}) {
    return PersonalConfigModel(
        isFirstTimeUser: isFirstTimeUser ?? this.isFirstTimeUser,
        selectedSubjects: selectedSubjects ?? this.selectedSubjects);
  }

  Map<String, dynamic> toJSON() {
    return {
      'is_first_time_user': isFirstTimeUser,
      'selected_subjects': selectedSubjects
    };
  }

  List<ZnoSubjectInterface> get selectedSubjectsAsZnoInterfaces {
    var res = <ZnoSubjectInterface>[];
    for (final subject in allSubjects) {
      if (subject is ZnoSubject) {
        if (selectedSubjects.contains(subject.subjectId)) {
          res.add(subject);
        }
      } else if (subject is ZnoSubjectGroup) {
        for (final childSubject in subject.children) {
          if (selectedSubjects.contains(childSubject.subjectId) &&
              !res.contains(subject)) {
            res.add(subject);
          }
        }
      }
    }

    return res;
  }
}
