import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart' as path;
import '../../interfaces/storage_service.dart';

class LocalStorageService with StorageService {
  final Directory _appDir;

  LocalStorageService._create(Directory appDirectory)
    : _appDir = appDirectory;

  static Future<LocalStorageService> create() async {
    return LocalStorageService._create(
      await path.getApplicationDocumentsDirectory()
    );
  }

  String get _testsDir => '${_appDir.path}${Platform.pathSeparator}zno_client${Platform.pathSeparator}tests';
  String get _imageDir => '${_appDir.path}${Platform.pathSeparator}zno_client${Platform.pathSeparator}images';
  String _sessionPath(String subjectFolderName, String sessionFileName) {
    return '$_testsDir${Platform.pathSeparator}'
           '$subjectFolderName${Platform.pathSeparator}'
           '$sessionFileName';
  }
  String _imagePath(String subjectFolderName, String sessionFolderName, String fileName) {
    return '$_imageDir${Platform.pathSeparator}'
           '$subjectFolderName${Platform.pathSeparator}'
           '$sessionFolderName${Platform.pathSeparator}'
           '$fileName';
  }

  @override
  Future<List<String>> listSessions(String folderName) async {
    var dir = Directory('$_testsDir${Platform.pathSeparator}$folderName');
    if (! await dir.exists()) {
      return [];
    }
    return dir.list()
        .where((entity) => entity is File)
        .map((file) => file.path.split(Platform.pathSeparator).last)
        .toList();
  }

  @override
  Future<String> getSession(String folderName, String fileName) async { //throws FileSystemException
    return await File(
      _sessionPath(folderName, fileName)
    ).readAsString();
  }

  Future<DateTime> getSessionDate(String folderName, String fileName) async { //throws FileSystemException
    return await File(
      _sessionPath(folderName, fileName)
    ).lastModified();
  }

  Future<void> saveSession(String folderName, String fileName, String contents) async {
    var file = await File(
      _sessionPath(folderName, fileName)
    )
    .create(recursive: true);
    await file.writeAsString(contents);
  }

  @override
  Future<Uint8List> getImage(String folderName, String sessionName, String fileName) async {
    return File(
      _imagePath(folderName, sessionName, fileName)
    )
    .readAsBytes();
  }

  Future<void> saveImagesToFolder(String subjectName, String sessionName, Map<String, Uint8List> images) async {
    await Future.wait(images.entries.map((entry) {
      return File(_imagePath(subjectName, sessionName, entry.key))
          .create(recursive: true)
          .then((file) => file.writeAsBytes(entry.value));
    }));
  }

  Future<bool> imageFolderExists(String subjectName, String sessionName) async {
    sessionName = sessionName.replaceFirst('.json', '');
    return await Directory(
      _imagePath(subjectName, sessionName, '')
    ).exists();
  }



}
