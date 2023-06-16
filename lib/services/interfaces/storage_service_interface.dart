import 'dart:typed_data';
import '../../dto/previous_session_data.dart';
import '../../dto/storage_route_item_data.dart';
import '../../models/testing_route_model.dart';

abstract class StorageServiceInterface {
  Future<List<String>> listSessions(String folderName);
  Future<String> getSession(String folderName, String fileName);
  Future<Uint8List> getImage(
      String folderName, String sessionName, String fileName);
  Future<void> saveSessionEnd(TestingRouteModel data, bool completed);
  Future<List<PreviousSessionData>> getPreviousSessionsList(
      String subjectName, String sessionName);
  Future<List<PreviousSessionData>> getPreviousSessionsListGlobal();
  Future<List<StorageRouteItemData>> getStorageData();
}
