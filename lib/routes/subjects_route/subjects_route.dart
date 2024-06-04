import 'package:client/routes/subjects_route/state/subjects_route_input_data.dart';
import 'package:client/routes/subjects_route/state/subjects_route_state_model.dart';
import 'package:client/routes/subjects_route/subjects_page.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectsRoute extends StatelessWidget {
  // Is null on the main page
  // Is not null if someone opened a group of subjects
  final SubjectsRouteInputData? dto;

  const SubjectsRoute({
    super.key,
    this.dto,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SubjectsRouteStateModel(
        input: dto,
      ),
      child: const Scaffold(
        body: SubjectsPage(),
        bottomNavigationBar: ZnoBottomNavigationBar(
          activeRoute: ZnoBottomNavigationEnum.subjects,
        ),
      ),
    );
  }
}
