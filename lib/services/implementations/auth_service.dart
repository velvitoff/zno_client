import 'package:client/auth/auth_provider_google.dart';
import 'package:client/auth/auth_provider_interface.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  AuthService();

  SupabaseClient get client => Supabase.instance.client;
  AuthProviderInterface? _authProvider;
  User? _currentUser;
  Session? _currentSession;

  bool get isLoggedIn => _currentUser != null;

  void setAuthProviderGoogle() {
    _authProvider = AuthProviderGoogle();
  }

  Future<bool> signIn() async {
    if (_authProvider == null) {
      return false;
    }
    AuthResponse response;
    try {
      response = await _authProvider!.signIn();
    } catch (_) {
      return false;
    }
    _currentUser = response.user;
    _currentSession = response.session;
    return true;
  }

  Future<bool> signOut() async {
    if (_authProvider == null) {
      return false;
    }
    _currentUser = null;
    _currentSession = null;
    _authProvider = null;

    try {
      await client.auth.signOut();
    } catch (_) {
      return false;
    }
    return true;
  }
}
