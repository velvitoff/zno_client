import '../all_subjects/all_subjects.dart';

class PersonalConfigData {
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

  const PersonalConfigData(
      {required this.isFirstTimeUser, required this.selectedSubjects});

  factory PersonalConfigData.fromJSON(Map<String, dynamic> map) =>
      PersonalConfigData(
          isFirstTimeUser: map['is_first_time_user'] as bool,
          selectedSubjects: List<String>.from(
              map['selected_subjects'].map((x) => x as String)));

  // ignore: prefer_const_constructors
  factory PersonalConfigData.getDefault() => PersonalConfigData(
      isFirstTimeUser: true, selectedSubjects: defaultSubjectsList);

  PersonalConfigData copyWith(
      {bool? isFirstTimeUser, List<String>? selectedSubjects}) {
    return PersonalConfigData(
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
