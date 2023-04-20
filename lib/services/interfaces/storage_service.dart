import 'dart:typed_data';
import '../../models/testing_route_model.dart';

abstract class StorageService {
  Future<List<String>> listSessions(String folderName);
  Future<String> getSession(String folderName, String fileName);
  Future<Uint8List> getImage(String folderName, String sessionName, String fileName);
  Future<void> saveSessionEnd(TestingRouteModel data, bool completed);
}