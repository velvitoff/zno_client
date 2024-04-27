import 'dart:typed_data';
import 'package:client/models/exam_file_adress_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants.dart';

class SupabaseStorageRepository {
  SupabaseClient get client => Supabase.instance.client;

  Future<List<ExamFileAddressModel>> listExamFiles(
      String folderName, String subjectName, bool isPremium) async {
    List<FileObject> listFree =
        await client.storage.from(Constants.testsBucket).list(path: folderName);
    if (listFree[0].name == ".emptyFolderPlaceholder") {
      listFree = [];
    }

    if (isPremium) {
      List<FileObject> listPremium = await client.storage
          .from(Constants.testsBucketPaid)
          .list(path: folderName);
      if (listPremium[0].name == ".emptyFolderPlaceholder") {
        listPremium = [];
      }
      listFree.addAll(listPremium);
    }

    return listFree
        .map((e) => ExamFileAddressModel.fromIncomplete(
            folderName: folderName, fileName: e.name, subjectName: subjectName))
        .toList();
  }

  Future<Uint8List> getExamFileBytes(
      ExamFileAddressModel examFile, bool isPremium) async {
    Future<Uint8List> req(String bucket) async {
      return await client.storage
          .from(bucket)
          .download('${examFile.folderName}/${examFile.fileName}');
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

  Future<Uint8List> getImageBytes(ExamFileAddressModel examFileAddress,
      String fileName, bool isPremium) async {
    Future<Uint8List> req(String bucket) async {
      return await client.storage.from(bucket).download(
          '${examFileAddress.folderName}/${examFileAddress.fileNameNoExtension}/$fileName');
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
      ExamFileAddressModel examFileAddress, bool isPremium) async {
    final imageFolderName = examFileAddress.fileNameNoExtension;
    Map<String, Uint8List> result = {};

    List<FileObject> list = [];
    list = await client.storage
        .from(Constants.imagesBucket)
        .list(path: '${examFileAddress.folderName}/$imageFolderName');
    if (list.isEmpty || list[0].name == ".emptyFolderPlaceholder") {
      list = [];
      if (isPremium) {
        list = await client.storage
            .from(Constants.imagesBucketPaid)
            .list(path: '${examFileAddress.folderName}/$imageFolderName');
        if (list.isEmpty || list[0].name == ".emptyFolderPlaceholder") {
          list = [];
        }
      }
    }

    final imageList = await Future.wait(list
        .map((file) => getImageBytes(examFileAddress, file.name, isPremium)));

    for (int i = 0; i < imageList.length; ++i) {
      result[list[i].name] = imageList[i];
    }

    return result;
  }
}
