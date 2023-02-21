abstract class StorageService {
  Future<List<String>> listSessions(String folderName);
  Future<String> getSession(String folderName, String fileName);
}