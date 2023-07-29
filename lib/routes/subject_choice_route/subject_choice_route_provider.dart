import 'package:client/models/subject_choice_route_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectChoiceRouteProvider extends StatelessWidget {
  final Widget child;
  final SubjectChoiceRouteModel data;

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
