class PersonalConfigData {
  final bool isFirstTimeUser;
  final List<String> selectedSubjects;

  //change to map
  static const Map<String, dynamic> allSubjects = {
    'ukrainian_lang_and_lit': 'Українська мова і література',
    'ukrainian_lang': 'Українська мова',
    'math': 'Математика',
    'nmt': 'НМТ',
    'ukraine_history': 'Історія України',
    'physics': 'Фізика',
    'chemistry': 'Хімія',
    'geography': 'Географія',
    'biology': 'Біологія',
    'english_lang': 'Англійська мова',
    'german_lang': 'Німецька мова',
    'french_lang': 'Французька мова',
    'spanish_lang': 'Іспанська мова',
    'zno_teachers': 'ЗНО для вчителів',
    'master': {
      'tznk': 'ТЗНК',
      'master_english_lang': 'Англійська мова в магістратуру',
      'master_german_lang': 'Німецька мова в магістратуру',
      'master_french_lang': 'Французька мова в магістратуру',
      'master_spanish_lang': 'Іспанська мова в магістратуру',
      'master_pravo': 'Право в магістратуру',
      'master_admin': 'Управління та адміністрування в магістратуру',
      'master_finance': 'Облік та фінанси в магістратуру',
      'master_psychology': 'Психологія та соціологія в магістратуру',
      'master_economics': 'Економіка та міжнародна економіка в магістратуру',
      'master_politics': 'Політологія та міжнародні відносини в магістратуру'
    },
  };

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

  Map<String, dynamic> toJSON() {
    return {
      'is_first_time_user': isFirstTimeUser,
      'selected_subjects': selectedSubjects
    };
  }
}
