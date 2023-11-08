import 'package:flutter/material.dart';
import 'package:client/routes/subject_choice_route/subject_choice_header.dart';
import 'package:client/routes/subject_choice_route/subject_choice_list.dart';

class SubjectChoiceLayout extends StatelessWidget {
  const SubjectChoiceLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SubjectChoiceHeader(),
        Expanded(child: SubjectChoiceList()),
      ],
    );
  }
}
