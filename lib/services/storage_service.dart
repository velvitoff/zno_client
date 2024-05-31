import 'dart:typed_data';
import 'package:client/models/exam_file_adress_model.dart';
import 'package:client/models/personal_config_model.dart';
import 'package:client/state_models/testing_time_state_model.dart';
import 'package:client/repositories/local_storage_repository.dart';
import 'package:client/repositories/supabase_storage_repository.dart';
import '../models/previous_attempt_model.dart';
import '../models/storage_route_item_model.dart';
import '../state_models/testing_route_state_model.dart';

//TODO: test
class StorageService {
  SupabaseStorageRepository externalStorage;
  LocalStorageRepository localStorage;

  StorageService._({required this.externalStorage, required this.localStorage});
  static Future<StorageService> create() async {
    return StorageService._(
        externalStorage: SupabaseStorageRepository(),
        localStorage: await LocalStorageRepository.create());
  }

  Future<List<ExamFileAddressModel>> listExamFiles(
      String folderName, String subjectName, bool isPremium) async {
    try {
      return await externalStorage.listExamFiles(
          folderName, subjectName, isPremium);
    } catch (e) {
      //fallback for listing sessions in case of network exception
      return await localStorage.listExamFiles(folderName, subjectName);
    }
  }

  Future<Uint8List> getExamFileBytes(
      ExamFileAddressModel examFileAddress, bool isPremium) async {
    //throws
    try {
      //return local file if it's recent enough
      var lastModified = await localStorage.getExamFileDate(examFileAddress);
      var now = DateTime.now();
      if (now.difference(lastModified).inDays < 3) {
        if (!await localStorage.imageFolderExists(examFileAddress)) {
          await downloadAllImages(examFileAddress, isPremium);
        }
        return localStorage.getExamFileData(examFileAddress);
      } else {
        //if local file is older than three days, move on to a download attempt
        throw Exception();
      }
    } catch (e) {
      try {
        final Uint8List session =
            await externalStorage.getExamFileBytes(examFileAddress, isPremium);
        await localStorage.saveExamFile(examFileAddress, session);
        final imageMap = await downloadAllImages(examFileAddress, isPremium);
        await saveImages(examFileAddress, imageMap);
        return session;
      } catch (e) {
        //if the download attempt fails, try using local data without a recency restriction
        return localStorage.getExamFileData(examFileAddress);
      }
    }
  }

  String getImagePath(ExamFileAddressModel examFileAddress, String fileName) {
    return localStorage.getImagePath(examFileAddress, fileName);
  }

  Future<Uint8List> getImageBytes(ExamFileAddressModel examFileAddress,
      String fileName, bool isPremium) async {
    try {
      return localStorage.getImageBytes(examFileAddress, fileName);
    } catch (e) {
      return externalStorage.getImageBytes(
          examFileAddress, fileName, isPremium);
    }
  }

  Future<Map<String, Uint8List>> downloadAllImages(
      ExamFileAddressModel examFileAddress, bool isPremium) async {
    return await externalStorage.downloadAllImages(examFileAddress, isPremium);
  }

  Future<void> saveImages(ExamFileAddressModel examFileAddress,
      Map<String, Uint8List> imageMap) async {
    await localStorage.saveImages(examFileAddress, imageMap);
  }

  Future<PreviousAttemptModel?> saveSessionEnd(TestingRouteStateModel data,
      TestingTimeStateModel timerData, bool completed) async {
    return localStorage.saveSessionEnd(data, timerData, completed);
  }

  PreviousAttemptModel? saveSessionEndSync(TestingRouteStateModel data,
      TestingTimeStateModel timerData, bool completed) {
    return localStorage.saveSessionEndSync(data, timerData, completed);
  }

  Future<List<PreviousAttemptModel>> getPreviousSessionsList(
      String subjectName, String sessionName) {
    return localStorage.getPreviousSessionsList(subjectName, sessionName);
  }

  Future<List<PreviousAttemptModel>> getPreviousSessionsListGlobal() async {
    return localStorage.getPreviousSessionsListGlobal();
  }

  Future<List<StorageRouteItemModel>> getStorageData() async {
    return localStorage.getStorageData();
  }

  Future<PersonalConfigModel> getPersonalConfigModel() async {
    return await localStorage.getPersonalConfigModel();
  }

  Future<void> savePersonalConfigData(PersonalConfigModel data) async {
    await localStorage.savePersonalConfigData(data);
  }
}
