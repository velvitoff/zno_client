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
}
