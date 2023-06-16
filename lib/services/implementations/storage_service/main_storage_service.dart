import 'dart:typed_data';

import 'package:client/services/implementations/storage_service/local_storage_service.dart';
import 'package:client/services/interfaces/external_storage_service_interface.dart';
import 'package:client/services/interfaces/storage_service_interface.dart';

import '../../../dto/previous_session_data.dart';
import '../../../dto/storage_route_item_data.dart';
import '../../../models/testing_route_model.dart';

class MainStorageService with StorageServiceInterface {
  final ExternalStorageServiceInterface
      externalStorage; //Supabase / Firebase storage service
  final LocalStorageService localStorage;

  MainStorageService._create(
      ExternalStorageServiceInterface external, LocalStorageService local)
      : externalStorage = external,
        localStorage = local;

  static Future<MainStorageService> create({
    required ExternalStorageServiceInterface externalStorageService,
  }) async {
    return MainStorageService._create(
        externalStorageService, await LocalStorageService.create());
  }

  @override
  Future<List<String>> listSessions(String folderName) async {
    try {
      return await externalStorage.listSessions(folderName);
    } catch (e) {
      //fallback for listing sessions in case of network exception
      return await localStorage.listSessions(folderName);
    }
  }

  @override
  Future<String> getSession(String folderName, String fileName) async {
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
        final String session =
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

  @override
  Future<Uint8List> getImage(
      String folderName, String sessionName, String fileName) async {
    try {
      return localStorage.getImage(folderName, sessionName, fileName);
    } catch (e) {
      return externalStorage.getImage(folderName, sessionName, fileName);
    }
  }

  Future<void> downloadImages(String subjectName, String sessionName) async {
    sessionName = sessionName.replaceFirst('.json', '');
    var imageMap =
        await externalStorage.downloadAllImages(subjectName, sessionName);
    await localStorage.saveImagesToFolder(subjectName, sessionName, imageMap);
  }

  @override
  Future<void> saveSessionEnd(TestingRouteModel data, bool completed) async {
    localStorage.saveSessionEnd(data, completed);
  }

  @override
  Future<List<PreviousSessionData>> getPreviousSessionsList(
      String subjectName, String sessionName) {
    return localStorage.getPreviousSessionsList(subjectName, sessionName);
  }

  @override
  Future<List<PreviousSessionData>> getPreviousSessionsListGlobal() async {
    return localStorage.getPreviousSessionsListGlobal();
  }

  @override
  Future<List<StorageRouteItemData>> getStorageData() async {
    return localStorage.getStorageData();
  }
}
