import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../constants.dart';

class SupabaseStorageService {
  SupabaseClient get client => Supabase.instance.client;
  bool isPremium = false;

  Future<List<String>> listSessions(String folderName) async {
    List<FileObject> listResult =
        await client.storage.from(Constants.testsBucket).list(path: folderName);
    if (listResult.isEmpty || listResult[0].name == ".emptyFolderPlaceholder") {
      listResult = [];
    }

    if (isPremium) {
      final List<FileObject> listPremium = await client.storage
          .from(Constants.testsBucketPaid)
          .list(path: folderName);
      if (listPremium.isNotEmpty &&
          listPremium[0].name != ".emptyFolderPlaceholder") {
        listResult.addAll(listPremium);
      }
    }

    return listResult.map((x) => x.name).toList();
  }

  Future<Uint8List> getSession(String folderName, String fileName) async {
    Future<Uint8List> req(String bucket) async {
      return await client.storage
          .from(bucket)
          .download('$folderName/$fileName');
    }

    if (isPremium) {
      try {
        return await req(Constants.testsBucketPaid);
      } on StorageException {
        return await req(Constants.testsBucket);
      }
    }
    //throws StorageException, FormatException
    return req(Constants.testsBucket);
  }

  Future<Uint8List> getFileBytes(
      String folderName, String sessionName, String fileName) async {
    Future<Uint8List> req(String bucket) async {
      return await client.storage
          .from(bucket)
          .download('$folderName/$sessionName/$fileName');
    }

    if (isPremium) {
      try {
        return await req(Constants.imagesBucketPaid);
      } on StorageException {
        return await req(Constants.imagesBucket);
      }
    }
    return req(Constants.imagesBucket);
  }

  Future<Map<String, Uint8List>> downloadAllImages(
      String subjectName, String sessionName) async {
    Map<String, Uint8List> result = {};

    List<FileObject> list = [];
    list = await client.storage
        .from(Constants.imagesBucket)
        .list(path: '$subjectName/$sessionName');
    if (list.isEmpty || list[0].name == ".emptyFolderPlaceholder") {
      list = [];
      if (isPremium) {
        list = await client.storage
            .from(Constants.imagesBucketPaid)
            .list(path: '$subjectName/$sessionName');
        if (list.isEmpty || list[0].name == ".emptyFolderPlaceholder") {
          list = [];
        }
      }
    }

    final imageList = await Future.wait(
        list.map((file) => getFileBytes(subjectName, sessionName, file.name)));

    for (int i = 0; i < imageList.length; ++i) {
      result[list[i].name] = imageList[i];
    }

    return result;
  }
}
