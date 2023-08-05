import 'package:client/all_subjects/zno_subject.dart';
import 'package:client/all_subjects/zno_subject_interface.dart';

class ZnoSubjectGroup extends ZnoSubjectInterface {
  final List<ZnoSubject> children;

  const ZnoSubjectGroup(String subjectId, String subjectName,
      {required this.children})
      : super(subjectId: subjectId, subjectName: subjectName);

  @override
  List<ZnoSubject> getChildren() => children;
}
