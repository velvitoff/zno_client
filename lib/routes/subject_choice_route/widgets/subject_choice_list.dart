import 'package:client/all_subjects/all_subjects.dart';
import 'package:client/all_subjects/zno_subject.dart';
import 'package:client/all_subjects/zno_subject_group.dart';
import 'package:flutter/material.dart';
import 'subject_choice_list_item.dart';

class SubjectChoiceList extends StatelessWidget {
  const SubjectChoiceList({super.key});

  @override
  Widget build(BuildContext context) {
    List<SubjectChoiceListItem> children = [];

    for (final subject in allSubjects) {
      if (subject is ZnoSubject) {
        children.add(SubjectChoiceListItem(
          subjectKey: subject.getId,
          subjectName: subject.getName,
        ));
      } else if (subject is ZnoSubjectGroup) {
        for (final innerSubject in subject.children) {
          children.add(SubjectChoiceListItem(
            subjectKey: innerSubject.getId,
            subjectName: innerSubject.getName,
          ));
        }
      }
    }

    return ListView(
      padding: EdgeInsets.zero,
      children: children,
    );
  }
}
