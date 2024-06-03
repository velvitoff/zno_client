import 'package:client/locator.dart';
import 'package:client/models/exam_file_adress_model.dart';
import 'package:client/routes/sessions_route/sessions_page.dart';
import 'package:client/routes/sessions_route/state/sessions_route_input_data.dart';
import 'package:client/routes/sessions_route/state/sessions_route_state_model.dart';
import 'package:client/services/storage_service.dart';
import 'package:client/auth/state/auth_state_model.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionsRoute extends StatefulWidget {
  final SessionsRouteInputData dto;

  const SessionsRoute({Key? key, required this.dto}) : super(key: key);

  @override
  SessionsRouteState createState() => SessionsRouteState();
}

class SessionsRouteState extends State<SessionsRoute> {
  late final Future<List<MapEntry<String, List<ExamFileAddressModel>>>>
      futureList;

  Future<List<MapEntry<String, List<ExamFileAddressModel>>>>
      _getFutureList() async {
    final isPremium = context.read<AuthStateModel>().isPremium;
    final list = await locator.get<StorageService>().listExamFiles(
        widget.dto.folderName, widget.dto.subjectName, isPremium);
    final listGrouped = list
        .groupListsBy((element) => element.fileNameNoExtension.split('_').last)
        .entries
        .sorted((a, b) => b.key.compareTo(a.key));
    return listGrouped;
  }

  @override
  void initState() {
    super.initState();
    futureList = _getFutureList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SessionsRouteStateModel(
        inputData: widget.dto,
        futureList: futureList,
      ),
      child: const Scaffold(
        body: SessionsPage(),
        bottomNavigationBar: ZnoBottomNavigationBar(
          activeRoute: ZnoBottomNavigationEnum.subjects,
        ),
      ),
    );
  }
}
