class ExamFileAdressModel {
  final String subjectName;
  final String sessionName;
  final String folderName;
  final String fileName;
  final String fileNameNoExtension;

  const ExamFileAdressModel(
      {required this.subjectName,
      required this.sessionName,
      required this.folderName,
      required this.fileName,
      required this.fileNameNoExtension});
}
