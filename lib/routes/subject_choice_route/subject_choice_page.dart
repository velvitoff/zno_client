import 'package:client/routes/subject_choice_route/widgets/subject_choice_header.dart';
import 'package:client/routes/subject_choice_route/widgets/subject_choice_list.dart';
import 'package:flutter/material.dart';

class SubjectChoicePage extends StatelessWidget {
  const SubjectChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SubjectChoiceHeader(),
        Expanded(
          child: SubjectChoiceList(),
        ),
      ],
    );
  }
}
