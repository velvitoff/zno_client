import 'package:client/models/exam_file_adress_model.dart';
import 'package:client/routes/session_route/session_page.dart';
import 'package:client/routes/session_route/state/session_route_state_model.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionRoute extends StatelessWidget {
  final ExamFileAddressModel dto;

  const SessionRoute({Key? key, required this.dto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SessionRouteStateModel(
        inputSessionData: dto,
      ),
      child: const Scaffold(
        body: SessionPage(),
        bottomNavigationBar: ZnoBottomNavigationBar(
          activeRoute: ZnoBottomNavigationEnum.subjects,
        ),
      ),
    );
  }
}
