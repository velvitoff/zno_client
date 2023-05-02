import 'package:client/dto/session_data.dart';
import 'package:client/routes.dart';
import 'package:client/widgets/zno_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuple/tuple.dart';

class SessionsList extends StatelessWidget {
  final String folderName;
  final String subjectName;
  final List<String> data;

  const SessionsList({
    Key? key,
    required this.folderName,
    required this.subjectName,
    required this.data
  }) : super(key: key);

  String fileNameToSessionName(String name) {
    name = name.replaceFirst('.json', '');
    List<String> split = name.split('_');

    for (int i = 0; i < split.length; ++i) {
      if (split[i] == 'zno') {split[i] = 'ЗНО';}
      else if (split[i] == 'nmt') {split[i] = 'НМТ';}
      else if (split[i] == 'dodatkova') {split[i] = 'Додаткова сесія';}
      else if (split[i] == 'testova') {split[i] = 'Тестова сесія';}
      else if (split[i] == 'osnovna') {split[i] = 'Основна сесія';}
    }

    return split.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return ZnoList(
      list: data.map((data) {
        String sessionName = fileNameToSessionName(data);
        return Tuple2(sessionName, () => context.go(
            Routes.sessionRoute,
            extra: SessionData(
                subjectName: subjectName,
                sessionName: sessionName,
                folderName: folderName,
                fileName: data,
                fileNameNoExtension: data.replaceFirst('.json', '')
            )
        ));
      }).toList(),
    );
  }
}

