import 'package:client/auth/auth_provider_google.dart';
import 'package:client/auth/auth_provider_interface.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  AuthService();

  SupabaseClient get client => Supabase.instance.client;
  AuthProviderInterface? _authProvider;

  bool get isLoggedIn => client.auth.currentUser != null;

  void setAuthProviderGoogle() {
    _authProvider = AuthProviderGoogle();
  }

  Future<bool> signIn() async {
    if (_authProvider == null) {
      return false;
    }

    try {
      await _authProvider!.signIn();
    } catch (_) {
      return false;
    }
    return true;
  }

  Future<bool> signOut() async {
    if (_authProvider == null) {
      return false;
    }

    try {
      await Supabase.instance.client.auth.signOut();
      _authProvider!.signOut();
    } catch (_) {
      return false;
    }
    return true;
  }
}
