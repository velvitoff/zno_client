import 'package:client/dto/session_data.dart';
import 'package:client/routes.dart';
import 'package:client/services/interfaces/utils_service_interface.dart';
import 'package:client/widgets/zno_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuple/tuple.dart';

import '../../locator.dart';

class SessionsList extends StatelessWidget {
  final String folderName;
  final String subjectName;
  final List<String> data;

  const SessionsList(
      {Key? key,
      required this.folderName,
      required this.subjectName,
      required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZnoList(
      list: data.map((data) {
        String sessionName =
            locator.get<UtilsServiceInterface>().fileNameToSessionName(data);
        return Tuple2(
            sessionName,
            () => context.go(Routes.sessionRoute,
                extra: SessionData(
                    subjectName: subjectName,
                    sessionName: sessionName,
                    folderName: folderName,
                    fileName: data,
                    fileNameNoExtension: data.replaceFirst('.json', ''))));
      }).toList(),
    );
  }
}
