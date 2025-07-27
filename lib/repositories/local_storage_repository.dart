import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:client/extensions/directory_extension.dart';
import 'package:client/models/exam_file_adress_model.dart';
import 'package:client/models/exam_file_model.dart';
import 'package:client/models/personal_config_model.dart';
import 'package:client/models/previous_attempt_model.dart';
import 'package:client/routes/testing_route/state/testing_time_state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart' as path;

import '../models/storage_route_item_model.dart';
import '../routes/testing_route/state/testing_route_state_model.dart';

class LocalStorageRepository {
  final Directory _appDir;

  LocalStorageRepository._create(Directory appDirectory)
      : _appDir = appDirectory;

  static Future<LocalStorageRepository> create() async {
    return LocalStorageRepository._create(
        await path.getApplicationDocumentsDirectory());
  }

  String get _znoDirPath =>
      '${_appDir.path}${Platform.pathSeparator}zno_client';
  String get _testsDir => '$_znoDirPath${Platform.pathSeparator}tests';
  String get _imageDir => '$_znoDirPath${Platform.pathSeparator}images';
  String get _historyDir => '$_znoDirPath${Platform.pathSeparator}history';

  String _getSessionPath(ExamFileAddressModel file) {
    return '$_testsDir${Platform.pathSeparator}'
        '${file.folderName}${Platform.pathSeparator}'
        '${file.fileName}';
  }

  String getImagePath(ExamFileAddressModel examFileAddress, String fileName) {
    return '$_imageDir${Platform.pathSeparator}'
        '${examFileAddress.folderName}${Platform.pathSeparator}'
        '${examFileAddress.fileNameNoExtension}${Platform.pathSeparator}'
        '$fileName';
  }

  String _historyPath(ExamFileAddressModel examFileAddress, String fileName) {
    return '$_historyDir${Platform.pathSeparator}'
        '${examFileAddress.folderName}${Platform.pathSeparator}'
        '${examFileAddress.fileNameNoExtension}${Platform.pathSeparator}'
        '$fileName';
  }

  Future<List<ExamFileAddressModel>> listExamFiles(
      String folderName, String subjectName) async {
    var dir = Directory('$_testsDir${Platform.pathSeparator}$folderName');
    if (!await dir.exists()) {
      return [];
    }
    return dir
        .list()
        .where((entity) => entity is File)
        .map((file) => ExamFileAddressModel.fromIncomplete(
              folderName: folderName,
              subjectName: subjectName,
              fileName: file.path.split(Platform.pathSeparator).last,
            ))
        .toList();
  }

  Future<Uint8List> getExamFileData(ExamFileAddressModel examFile) async {
    //throws FileSystemException
    return await File(_getSessionPath(examFile)).readAsBytes();
  }

  Future<DateTime> getExamFileDate(ExamFileAddressModel examFile) async {
    //throws FileSystemException
    return await File(_getSessionPath(examFile)).lastModified();
  }

  Future<void> saveExamFile(
      ExamFileAddressModel examFileAddress, Uint8List contents) async {
    var file =
        await File(_getSessionPath(examFileAddress)).create(recursive: true);
    await file.writeAsBytes(contents);
  }

  Future<Uint8List> getImageBytes(
      ExamFileAddressModel examFileAddress, String fileName) async {
    return File(getImagePath(examFileAddress, fileName)).readAsBytes();
  }

  Future<void> saveImages(ExamFileAddressModel examFileAddress,
      Map<String, Uint8List> images) async {
    await Future.wait(images.entries.map((entry) {
      return File(getImagePath(examFileAddress, entry.key))
          .create(recursive: true)
          .then((file) => file.writeAsBytes(entry.value));
    }));
  }

  Future<bool> imageFolderExists(ExamFileAddressModel examFileAddress) async {
    return await Directory(getImagePath(examFileAddress, '')).exists();
  }

  Future<PreviousAttemptModel?> saveSessionEnd(
    TestingRouteStateModel data,
    TestingTimeStateModel timerData,
    bool completed,
  ) async {
    if (data.prevSessionData != null && data.prevSessionData!.completed) {
      return null;
    }
    if (data.allAnswers.isEmpty) {
      return null;
    }

    final newData =
        PreviousAttemptModel.fromTestingRouteModel(data, timerData, completed);
    final map = newData.toJson();

    String filePath = _historyPath(data.sessionData, newData.sessionId);
    File file = File(filePath);

    if (await file.exists()) {
      await file.writeAsString(json.encode(map), mode: FileMode.writeOnly);
    } else {
      await file.create(recursive: true);
      await file.writeAsString(json.encode(map), mode: FileMode.writeOnly);
    }

    return newData;
  }

  PreviousAttemptModel? saveSessionEndSync(TestingRouteStateModel data,
      TestingTimeStateModel timerData, bool completed) {
    if (data.prevSessionData != null && data.prevSessionData!.completed) {
      return null;
    }
    if (data.allAnswers.isEmpty) {
      return null;
    }

    final newData =
        PreviousAttemptModel.fromTestingRouteModel(data, timerData, completed);
    final map = newData.toJson();

    String filePath = _historyPath(data.sessionData, newData.sessionId);
    File file = File(filePath);

    if (file.existsSync()) {
      file.writeAsStringSync(json.encode(map), mode: FileMode.writeOnly);
    } else {
      file.createSync(recursive: true);
      file.writeAsStringSync(json.encode(map), mode: FileMode.writeOnly);
    }

    return newData;
  }

  Future<List<PreviousAttemptModel>> getPreviousAttemptsList(
      String subjectName, String sessionName) async {
    var dir = Directory('$_historyDir${Platform.pathSeparator}'
        '$subjectName${Platform.pathSeparator}'
        '$sessionName${Platform.pathSeparator}');

    if (!await dir.exists()) {
      return [];
    }

    final List<File> files = await dir
        .list()
        .where((entity) => entity is File)
        .map((entity) => entity as File)
        .toList();

    final List<String> strings =
        await Future.wait(files.map((file) async => await file.readAsString()));

    return strings
        .map((string) => PreviousAttemptModel.fromJson(jsonDecode(string)))
        .toList();
  }

  Future<List<PreviousAttemptModel>> getPreviousAttemptsListGlobal() async {
    Directory historyDir = Directory(_historyDir);
    if (!await historyDir.exists()) {
      return [];
    }

    List<PreviousAttemptModel> result = [];
    for (Directory subjectFolder in await historyDir
        .list()
        .where((x) => x is Directory)
        .map((x) => x as Directory)
        .toList()) {
      for (Directory sessionFolder in await subjectFolder
          .list()
          .where((x) => x is Directory)
          .map((x) => x as Directory)
          .toList()) {
        for (File session in await sessionFolder
            .list()
            .where((x) => x is File)
            .map((x) => x as File)
            .toList()) {
          result.add(PreviousAttemptModel.fromJson(
              jsonDecode(await session.readAsString())));
        }
      }
    }

    result.sort((a, b) => a.date.compareTo(b.date));
    return result;
  }

  Future<List<StorageRouteItemModel>> getStorageData() async {
    Directory testsDir = Directory(_testsDir);
    if (!await testsDir.exists()) {
      return [];
    }

    List<Directory> subjectFolders = await testsDir
        .list()
        .where((folder) => folder is Directory)
        .map((folder) => folder as Directory)
        .toList();

    Map<Directory, List<File>> mapOfSessions = Map.fromIterables(
        subjectFolders,
        await Future.wait(subjectFolders.map((folder) => folder
            .list()
            .where((file) => file is File)
            .map((file) => file as File)
            .toList())));

    List<StorageRouteItemModel> result = [];
    for (var entry in mapOfSessions.entries) {
      for (var file in entry.value) {
        String fileString;
        fileString = await file.readAsString();
        final data = ExamFileModelNoQuestions.fromJson(jsonDecode(fileString));
        final String imageFolderPath = '$_imageDir${Platform.pathSeparator}'
            '${entry.key.path.split(Platform.pathSeparator).last}${Platform.pathSeparator}'
            '${data.imageFolderName}';

        result.add(StorageRouteItemModel(
            subjectName: data.subject,
            sessionName: data.name,
            filePath: file.path,
            imageFolderPath: imageFolderPath,
            size:
                await file.length() + await Directory(imageFolderPath).length(),
            key: UniqueKey()));
      }
    }

    return result;
  }

  Future<PersonalConfigModel> getPersonalConfigModel() async {
    final file =
        File('$_znoDirPath${Platform.pathSeparator}personal_config.json');
    if (!await file.exists()) {
      return PersonalConfigModel.getDefault();
    }

    final data = await file.readAsString();
    return PersonalConfigModel.fromJSON(jsonDecode(data));
  }

  Future<void> savePersonalConfigData(PersonalConfigModel data) async {
    final file =
        await File('$_znoDirPath${Platform.pathSeparator}personal_config.json')
            .create(recursive: true);
    await file.writeAsString(jsonEncode(data.toJSON()));
  }
}
