import 'package:client/routes/subject_choice_route/state/subject_choice_route_state_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectChoiceProvider extends StatelessWidget {
  final Future<Map<String, bool>> futureData;
  final Widget child;

  const SubjectChoiceProvider({
    super.key,
    required this.futureData,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          SubjectChoiceRouteStateModel(subjectsFuture: futureData),
      child: child,
    );
  }
}
