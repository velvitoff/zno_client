import 'dart:typed_data';

abstract class ExternalStorageServiceInterface {
  Future<List<String>> listSessions(String folderName);
  Future<String> getSession(String folderName, String fileName);
  Future<Uint8List> getImage(
      String folderName, String sessionName, String fileName);
  Future<Map<String, Uint8List>> downloadAllImages(
      String subjectName, String sessionName);
}
