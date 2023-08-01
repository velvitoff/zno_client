import 'package:client/all_subjects.dart';
import 'package:flutter/material.dart';
import 'subject_choice_list_item.dart';

class SubjectChoiceList extends StatelessWidget {
  const SubjectChoiceList({super.key});

  @override
  Widget build(BuildContext context) {
    List<SubjectChoiceListItem> children = [];

    for (var entry in allSubjects.entries) {
      if (entry.value is String) {
        children.add(SubjectChoiceListItem(
            subjectKey: entry.key, subjectName: entry.value));
      } else if (entry.value is Map) {
        final inner = entry.value as Map<String, String>;
        for (var entryInner in inner.entries) {
          children.add(SubjectChoiceListItem(
              subjectKey: entryInner.key, subjectName: entryInner.value));
        }
      }
    }

    return ListView(
      children: children,
    );
  }
}
