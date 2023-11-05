import 'package:client/services/interfaces/utils_service_interface.dart';

class UtilsService implements UtilsServiceInterface {
  static Map<String, String> keywordMap = {
    'zno': 'ЗНО',
    'nmt': 'НМТ',
    'dodatkova': 'Додаткова сесія',
    'testova': 'Тестова сесія',
    'osnovna': 'Основна сесія',
    'probna': 'Пробна сесія',
    'demo': 'Демоваріант',
    'spec': 'Спец сесія',
    'zrazok': 'Зразок завдань'
  };

  @override
  String fileNameToSessionName(String fileName) {
    fileName = fileName.replaceFirst('.json', '');
    fileName = fileName.replaceFirst('.bin', '');
    List<String> split = fileName.split('_');

    for (int i = 0; i < split.length; ++i) {
      split[i] = keywordMap[split[i]] ?? split[i];
    }
    return split.join(' ');
  }
}
