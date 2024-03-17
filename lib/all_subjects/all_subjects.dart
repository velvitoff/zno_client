import 'package:client/all_subjects/zno_subject.dart';
import 'package:client/all_subjects/zno_subject_group.dart';
import 'package:client/all_subjects/zno_subject_interface.dart';

//List of all subjects
const List<ZnoSubjectInterface> allSubjects = [
  ZnoSubject('ukrainian_lang_and_lit', 'Українська мова і література'),
  ZnoSubject('ukrainian_lang', 'Українська мова'),
  ZnoSubject('ukrainian_lit', 'Українська література'),
  ZnoSubject('math', 'Математика'),
  ZnoSubject('nmt', 'НМТ'),
  ZnoSubject('ukraine_history', 'Історія України'),
  ZnoSubject('physics', 'Фізика'),
  ZnoSubject('chemistry', 'Хімія'),
  ZnoSubject('geography', 'Географія'),
  ZnoSubject('biology', 'Біологія'),
  ZnoSubject('english_lang', 'Англійська мова'),
  ZnoSubject('german_lang', 'Німецька мова'),
  ZnoSubject('french_lang', 'Французька мова'),
  ZnoSubject('spanish_lang', 'Іспанська мова'),
  ZnoSubject('zno_teachers', 'ЗНО для вчителів'),
  ZnoSubjectGroup('master', 'ЗНО в магістратуру', children: [
    ZnoSubject('master_tznk', 'ТЗНК'),
    ZnoSubject('master_english_lang', 'Англійська мова в магістратуру'),
    ZnoSubject('master_german_lang', 'Німецька мова в магістратуру'),
    ZnoSubject('master_french_lang', 'Французька мова в магістратуру'),
    ZnoSubject('master_spanish_lang', 'Іспанська мова в магістратуру'),
    ZnoSubject('master_pravo', 'Право в магістратуру'),
    ZnoSubject('master_admin', 'Управління та адміністрування в магістратуру'),
    ZnoSubject('master_finance', 'Облік та фінанси в магістратуру'),
    ZnoSubject('master_psychology', 'Психологія та соціологія в магістратуру'),
    ZnoSubject(
        'master_economics', 'Економіка та міжнародна економіка в магістратуру'),
    ZnoSubject(
        'master_politics', 'Політологія та міжнародні відносини в магістратуру')
  ])
];

ZnoSubjectInterface? searchAllSubjects(String id) {
  final res = allSubjects.where((e) => e is ZnoSubject && e.subjectId == id);
  if (res.isNotEmpty) {
    return res.first;
  }

  final groups = allSubjects.whereType<ZnoSubjectGroup>();
  for (var group in groups) {
    final res = group.children.where((e) => e.subjectId == id);
    if (res.isNotEmpty) {
      return res.first;
    }
  }
  return null;
}
