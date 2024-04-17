class SessionAddressData {
  final String fileName;
  final String folderName;
  final String bucketName;
  final String fileNameNoExtension;

  SessionAddressData(
      {required this.fileName,
      required this.folderName,
      required this.bucketName})
      : fileNameNoExtension =
            fileName.replaceAll('.json', '').replaceAll('.bin', '');
}
