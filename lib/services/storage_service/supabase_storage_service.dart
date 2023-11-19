import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../constants.dart';

class SupabaseStorageService {
  SupabaseClient get client => Supabase.instance.client;

  Future<List<String>> listSessions(String folderName) async {
    List<FileObject> list =
        await client.storage.from(Constants.testsBucket).list(path: folderName);

    if (list[0].name == ".emptyFolderPlaceholder") {
      return [];
    }
    return list.map((x) => x.name).toList();
  }

  Future<Uint8List> getSession(String folderName, String fileName) async {
    //throws StorageException, FormatException
    final Uint8List file = await client.storage
        .from(Constants.testsBucket)
        .download('$folderName/$fileName');
    //const Utf8Decoder().convert(file)
    return file;
  }

  Future<Uint8List> getFileBytes(
      String folderName, String sessionName, String fileName) async {
    return await client.storage
        .from(Constants.imagesBucket)
        .download('$folderName/$sessionName/$fileName');
  }

  Future<Map<String, Uint8List>> downloadAllImages(
      String subjectName, String sessionName) async {
    Map<String, Uint8List> result = {};

    final List<FileObject> list = await client.storage
        .from(Constants.imagesBucket)
        .list(path: '$subjectName/$sessionName');

    final imageList = await Future.wait(
        list.map((file) => getFileBytes(subjectName, sessionName, file.name)));

    for (int i = 0; i < imageList.length; ++i) {
      result[list[i].name] = imageList[i];
    }

    return result;
  }
}
