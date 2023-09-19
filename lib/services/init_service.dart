import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants.dart';

class InitService {
  InitService._();

  static Future<InitService> init() async {
    await Supabase.initialize(
      url: Constants.supabaseUrl,
      anonKey: Constants.supabaseAnonKey,
    );
    return InitService._();
  }
}
