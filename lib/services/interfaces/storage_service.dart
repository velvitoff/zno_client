import 'dart:typed_data';

abstract class StorageService {
  Future<List<String>> listSessions(String folderName);
  Future<String> getSession(String folderName, String fileName);
  Future<Uint8List> getImage(String folderName, String sessionName, String fileName);
}