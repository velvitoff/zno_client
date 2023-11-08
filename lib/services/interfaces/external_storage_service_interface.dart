import 'dart:typed_data';

abstract class ExternalStorageServiceInterface {
  Future<List<String>> listSessions(String folderName);
  Future<Uint8List> getSession(String folderName, String fileName);
  Future<Uint8List> getFileBytes(
      String folderName, String sessionName, String fileName);
  Future<Map<String, Uint8List>> downloadAllImages(
      String subjectName, String sessionName);
}
