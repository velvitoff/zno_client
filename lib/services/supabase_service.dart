import 'package:client/models/testing_route_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseClient get client => Supabase.instance.client;

  const SupabaseService();

  Future<bool> sendComplaint(
      TestingRouteModel model, String text, bool isPremium,
      {String? id}) async {
    try {
      await client.from('user_complaints').insert({
        'id': id,
        'data': {
          "subjectName": model.sessionData.subjectName,
          "sessionName": model.sessionData.sessionName,
          "page": model.pageIndex + 1,
          "text": text
        }.toString()
      });
      return true;
    } catch (_) {
      return false;
    }
  }
}
