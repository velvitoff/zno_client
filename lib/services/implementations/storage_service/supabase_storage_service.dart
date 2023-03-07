import 'dart:convert';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../constants.dart';
import '../../interfaces/external_storage_service.dart';

class SupabaseStorageService implements ExternalStorageService {

  final SupabaseClient client;

  SupabaseStorageService._create(SupabaseClient supabaseClient)
      : client = supabaseClient;

  static Future<SupabaseStorageService> create() async {
    await Supabase.initialize(
      url: Constants.supabaseUrl,
      anonKey: Constants.supabaseAnonKey,
    );

    return SupabaseStorageService._create(Supabase.instance.client);
  }


  @override
  Future<List<String>> listSessions(String folderName) async {
    List<FileObject> list = await client.storage
        .from(Constants.testsBucket)
        .list(path: folderName);

    if (list[0].name == ".emptyFolderPlaceholder") {
      return [];
    }
    return list.map((x) => x.name).toList();
  }

  @override
  Future<String> getSession(String folderName, String fileName) async { //throws StorageException, FormatException
    final Uint8List file = await client.storage
        .from(Constants.testsBucket)
        .download('$folderName/$fileName');

    return const Utf8Decoder().convert(file);
  }

  @override
  Future<Uint8List> getImage(String folderName, String sessionName, String fileName) async {
    return await client.storage
      .from(Constants.imagesBucket)
      .download('$folderName/$sessionName/$fileName');
  }

  @override
  Future<Map<String, Uint8List>> downloadAllImages(String subjectName, String sessionName) async {
    Map<String, Uint8List> result = {};

    final List<FileObject> list = await client.storage
        .from(Constants.imagesBucket)
        .list(path: '$subjectName/$sessionName');

    final imageList = await Future.wait(list.map((file) =>
      getImage(subjectName, sessionName, file.name)
    ));

    for(int i = 0; i < imageList.length; ++i) {
      result[list[i].name] = imageList[i];
    }

    return result;
  }

}
