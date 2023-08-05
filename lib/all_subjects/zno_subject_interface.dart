import 'package:client/all_subjects/zno_subject.dart';

abstract class ZnoSubjectInterface {
  final String subjectId;
  final String subjectName;

  const ZnoSubjectInterface(
      {required this.subjectId, required this.subjectName});

  String get getId => subjectId;
  String get getName => subjectName;
  List<ZnoSubject> getChildren();
}
