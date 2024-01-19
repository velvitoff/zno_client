import 'dart:typed_data';
import 'package:client/locator.dart';
import 'package:client/models/testing_time_model.dart';
import 'package:client/services/storage_service/local_storage_service.dart';
import 'package:client/services/storage_service/supabase_storage_service.dart';

import '../../dto/previous_session_data.dart';
import '../../dto/storage_route_item_data.dart';
import '../../models/testing_route_model.dart';

class MainStorageService {
  MainStorageService();

  SupabaseStorageService get externalStorage =>
      locator.get<SupabaseStorageService>();
  LocalStorageService get localStorage => locator.get<LocalStorageService>();

  Future<List<String>> listSessions(String folderName) async {
    try {
      return await externalStorage.listSessions(folderName);
    } catch (e) {
      //fallback for listing sessions in case of network exception
      return await localStorage.listSessions(folderName);
    }
  }

  Future<Uint8List> getSession(String folderName, String fileName) async {
    //throws
    try {
      //return local file if it's recent enough
      var lastModified =
          await localStorage.getSessionDate(folderName, fileName);
      var now = DateTime.now();
      if (now.difference(lastModified).inDays < 3) {
        if (!await localStorage.imageFolderExists(folderName, fileName)) {
          await downloadImages(folderName, fileName);
        }

        return localStorage.getSession(folderName, fileName);
      } else {
        //if local file is older than three days, move on to a download attempt
        throw Exception();
      }
    } catch (e) {
      try {
        final Uint8List session =
            await externalStorage.getSession(folderName, fileName);
        localStorage.saveSession(folderName, fileName, session); //not awaited
        await downloadImages(folderName, fileName);
        return session;
      } catch (e) {
        //if the download attempt fails, try using local data without a recency restriction
        return localStorage.getSession(folderName, fileName);
      }
    }
  }

  String getImagePath(
      String subjectFolderName, String sessionFolderName, String fileName) {
    return localStorage.getImagePath(
        subjectFolderName, sessionFolderName, fileName);
  }

  Future<Uint8List> getFileBytes(
      String folderName, String sessionName, String fileName) async {
    try {
      return localStorage.getFileBytes(folderName, sessionName, fileName);
    } catch (e) {
      return externalStorage.getFileBytes(folderName, sessionName, fileName);
    }
  }

  Future<void> downloadImages(String subjectName, String sessionName) async {
    sessionName =
        sessionName.replaceFirst('.json', '').replaceFirst('.bin', '');
    var imageMap =
        await externalStorage.downloadAllImages(subjectName, sessionName);
    await localStorage.saveImagesToFolder(subjectName, sessionName, imageMap);
  }

  Future<PreviousSessionData?> saveSessionEnd(TestingRouteModel data,
      TestingTimeModel timerData, bool completed) async {
    return localStorage.saveSessionEnd(data, timerData, completed);
  }

  PreviousSessionData? saveSessionEndSync(
      TestingRouteModel data, TestingTimeModel timerData, bool completed) {
    return localStorage.saveSessionEndSync(data, timerData, completed);
  }

  Future<List<PreviousSessionData>> getPreviousSessionsList(
      String subjectName, String sessionName) {
    return localStorage.getPreviousSessionsList(subjectName, sessionName);
  }

  Future<List<PreviousSessionData>> getPreviousSessionsListGlobal() async {
    return localStorage.getPreviousSessionsListGlobal();
  }

  Future<List<StorageRouteItemData>> getStorageData() async {
    return localStorage.getStorageData();
  }
}
