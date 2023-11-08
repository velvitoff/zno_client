import 'package:client/dto/session_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseClient get client => Supabase.instance.client;

  const SupabaseService();

  Future<bool> sendComplaint(SessionData sessionData, String text,
      {String? email}) async {
    try {
      await client.from('user_complaints').insert({
        'email': email,
        'data': {
          "subjectName": sessionData.subjectName,
          "sessionName": sessionData.sessionName,
          "text": text
        }.toString()
      });
      return true;
    } catch (_) {
      return false;
    }
  }
}
