import 'package:client/routes/subject_choice_route/state/subject_choice_route_state_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectChoiceRouteProvider extends StatelessWidget {
  final Widget child;
  final SubjectChoiceRouteStateModel data;

  const SubjectChoiceRouteProvider(
      {super.key, required this.child, required this.data});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => data,
      child: child,
    );
  }
}
