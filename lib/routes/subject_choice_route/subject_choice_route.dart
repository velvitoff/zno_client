import 'package:client/routes/subject_choice_route/state/subjects_choice_provider.dart';
import 'package:client/routes/subject_choice_route/subject_choice_page.dart';
import 'package:flutter/material.dart';
import 'state/subject_choice_route_state_model.dart';

class SubjectChoiceRoute extends StatefulWidget {
  const SubjectChoiceRoute({super.key});

  @override
  State<SubjectChoiceRoute> createState() => _SubjectChoiceRouteState();
}

class _SubjectChoiceRouteState extends State<SubjectChoiceRoute> {
  late final Future<Map<String, bool>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = SubjectChoiceRouteStateModel.pullSubjectsFromConfig();
  }

  @override
  Widget build(BuildContext context) {
    return SubjectChoiceProvider(
      futureData: futureData,
      child: const SubjectChoicePage(),
    );
  }
}
