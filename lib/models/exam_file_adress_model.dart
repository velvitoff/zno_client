class ExamFileAddressModel {
  final String subjectName;
  final String sessionName;
  final String folderName;
  final String fileName;
  final String fileNameNoExtension;

  const ExamFileAddressModel(
      {required this.subjectName,
      required this.sessionName,
      required this.folderName,
      required this.fileName,
      required this.fileNameNoExtension});

  factory ExamFileAddressModel.fromIncomplete({
    required String folderName,
    required String subjectName,
    required String fileName,
  }) {
    final fileNameNoExtension =
        fileName.replaceAll('.json', '').replaceAll('.bin', '');
    final sessionName = fileNameNoExtensionToSessionName(fileNameNoExtension);
    return ExamFileAddressModel(
      subjectName: subjectName,
      sessionName: sessionName,
      folderName: folderName,
      fileName: fileName,
      fileNameNoExtension: fileNameNoExtension,
    );
  }

  static String fileNameNoExtensionToSessionName(String fileName) {
    fileName = fileName.replaceFirst('.json', '');
    fileName = fileName.replaceFirst('.bin', '');
    List<String> split = fileName.split('_');

    for (int i = 0; i < split.length; ++i) {
      split[i] = _keywordMap[split[i]] ?? split[i];
    }
    return split.join(' ');
  }

  static const Map<String, String> _keywordMap = {
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
}
