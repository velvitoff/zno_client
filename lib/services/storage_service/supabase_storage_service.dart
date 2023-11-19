import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../constants.dart';

class SupabaseStorageService {
  SupabaseClient get client => Supabase.instance.client;
  bool isPremium = false;

  String get testsBucketString =>
      isPremium ? Constants.testsBucketPaid : Constants.testsBucket;
  String get imagesBucketString =>
      isPremium ? Constants.imagesBucketPaid : Constants.imagesBucket;

  Future<List<String>> listSessions(String folderName) async {
    List<FileObject> list =
        await client.storage.from(testsBucketString).list(path: folderName);

    if (list[0].name == ".emptyFolderPlaceholder") {
      return [];
    }
    return list.map((x) => x.name).toList();
  }

  Future<Uint8List> getSession(String folderName, String fileName) async {
    //throws StorageException, FormatException
    final Uint8List file = await client.storage
        .from(testsBucketString)
        .download('$folderName/$fileName');
    //const Utf8Decoder().convert(file)
    return file;
  }

  Future<Uint8List> getFileBytes(
      String folderName, String sessionName, String fileName) async {
    return await client.storage
        .from(imagesBucketString)
        .download('$folderName/$sessionName/$fileName');
  }

  Future<Map<String, Uint8List>> downloadAllImages(
      String subjectName, String sessionName) async {
    Map<String, Uint8List> result = {};

    final List<FileObject> list = await client.storage
        .from(imagesBucketString)
        .list(path: '$subjectName/$sessionName');

    final imageList = await Future.wait(
        list.map((file) => getFileBytes(subjectName, sessionName, file.name)));

    for (int i = 0; i < imageList.length; ++i) {
      result[list[i].name] = imageList[i];
    }

    return result;
  }
}
