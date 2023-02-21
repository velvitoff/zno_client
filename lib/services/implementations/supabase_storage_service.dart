import 'dart:convert';
import 'dart:typed_data';
import 'package:client/services/interfaces/storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService implements StorageService {

  final SupabaseClient client;

  SupabaseStorageService._create(SupabaseClient supabaseClient)
      : client = supabaseClient;

  static Future<SupabaseStorageService> create() async {
    await Supabase.initialize(
      url: 'https://ydhnhgdhqmsgivefgczz.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlkaG5oZ2RocW1zZ2l2ZWZnY3p6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzE5Nzg0ODUsImV4cCI6MTk4NzU1NDQ4NX0.sygWhsrbleiuXWSN1AzO8EifKQL8X5tbKnBtCqEO-js',
    );

    return SupabaseStorageService._create(
        Supabase.instance.client
    );
  }


  @override
  Future<List<String>> listSessions(String folderName) async {
    List<FileObject> list = await client.storage
        .from('tests-bucket')
        .list(path: folderName);

    if (list[0].name == ".emptyFolderPlaceholder") {
      return [];
    }
    return list.map((x) => x.name).toList();
  }

  @override
  Future<String> getSession(String folderName, String fileName) async {
    final Uint8List file = await client.storage
        .from('tests-bucket')
        .download('$folderName/$fileName');

    return const Utf8Decoder().convert(file);
  }

}
