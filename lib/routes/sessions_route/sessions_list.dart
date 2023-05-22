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

  static Map<String, String> keywordMap = {
    'zno': 'ЗНО',
    'nmt': 'НМТ',
    'dodatkova': 'Додаткова сесія',
    'testova': 'Тестова сесія',
    'osnovna': 'Основна сесія',
    'probna': 'Пробна сесія',
    'demo': 'Демоваріант',
  };

  String fileNameToSessionName(String name) {
    name = name.replaceFirst('.json', '');
    List<String> split = name.split('_');

    for (int i = 0; i < split.length; ++i) {
      split[i] = keywordMap[split[i]] ?? split[i];
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

