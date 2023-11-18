import 'package:client/auth/auth_provider_google.dart';
import 'package:client/auth/auth_provider_interface.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthStateModel extends ChangeNotifier {
  AuthStateModel();

  AuthProviderInterface? _authProvider;
  User? currentUser;
  Session? currentSession;

  void setAuthProviderGoogle() {
    _authProvider = AuthProviderGoogle();
    notifyListeners();
  }

  void setUserAndSession(User user, Session session) {
    currentUser = user;
    currentSession = session;
    notifyListeners();
  }

  void clearUserAndSession() {
    currentUser = null;
    currentSession = null;
    notifyListeners();
  }
}

extension AuthManagement on AuthStateModel {
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
    if (response.user == null || response.session == null) {
      return false;
    }
    setUserAndSession(response.user!, response.session!);
    return true;
  }

  Future<bool> signOut() async {
    if (_authProvider == null) {
      return false;
    }

    try {
      await _authProvider!.signOut();
    } catch (_) {
      return false;
    }

    _authProvider = null;
    clearUserAndSession();

    return true;
  }
}
