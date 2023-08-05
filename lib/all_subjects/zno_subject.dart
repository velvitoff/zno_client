import 'package:client/all_subjects/zno_subject_interface.dart';

class ZnoSubject extends ZnoSubjectInterface {
  const ZnoSubject(String subjectId, String subjectName)
      : super(subjectId: subjectId, subjectName: subjectName);

  @override
  List<ZnoSubject> getChildren() => [];
}
