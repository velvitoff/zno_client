import 'dart:typed_data';

import 'package:client/models/exam_file_adress_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants.dart';

class SupabaseStorageRepository {
  SupabaseClient get client => Supabase.instance.client;

  Future<List<ExamFileAddressModel>> listExamFiles(
    String folderName,
    String subjectName,
  ) async {
    List<FileObject> list =
        await client.storage.from(Constants.testsBucket).list(path: folderName);
    if (list.isNotEmpty && list[0].name == ".emptyFolderPlaceholder") {
      list = [];
    }

    return list
        .map((e) => ExamFileAddressModel.fromIncomplete(
            folderName: folderName, fileName: e.name, subjectName: subjectName))
        .toList();
  }

  Future<Uint8List> getExamFileBytes(ExamFileAddressModel examFile) async {
    return await client.storage
        .from(Constants.testsBucket)
        .download('${examFile.folderName}/${examFile.fileName}');
  }

  Future<Uint8List> getImageBytes(
      ExamFileAddressModel examFileAddress, String fileName) async {
    Future<Uint8List> req(String bucket) async {
      return await client.storage.from(bucket).download(
          '${examFileAddress.folderName}/${examFileAddress.fileNameNoExtension}/$fileName');
    }

    return req(Constants.imagesBucket);
  }

  Future<Map<String, Uint8List>> downloadAllImages(
      ExamFileAddressModel examFileAddress) async {
    final imageFolderName = examFileAddress.fileNameNoExtension;
    Map<String, Uint8List> result = {};

    List<FileObject> list = [];
    list = await client.storage
        .from(Constants.imagesBucket)
        .list(path: '${examFileAddress.folderName}/$imageFolderName');
    if (list.isEmpty || list[0].name == ".emptyFolderPlaceholder") {
      list = [];
    }

    final imageList = await Future.wait(
        list.map((file) => getImageBytes(examFileAddress, file.name)));

    for (int i = 0; i < imageList.length; ++i) {
      result[list[i].name] = imageList[i];
    }

    return result;
  }
}
