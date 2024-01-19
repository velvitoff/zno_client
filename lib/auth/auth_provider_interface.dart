import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthProviderInterface {
  Future<AuthResponse> signIn();
  Future<bool> signOut();
}
