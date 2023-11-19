import 'package:client/auth/auth_provider_google.dart';
import 'package:client/auth/auth_provider_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthStateModel extends ChangeNotifier {
  AuthStateModel();
  SupabaseClient get client => Supabase.instance.client;

  AuthProviderInterface? _authProvider;
  User? currentUser;
  Session? currentSession;
  bool isPremium = false;

  void setAuthProviderGoogle() {
    _authProvider = AuthProviderGoogle();
    notifyListeners();
  }

  void setData(User user, Session session, bool premium) {
    currentUser = user;
    currentSession = session;
    isPremium = premium;
    notifyListeners();
  }

  void clearData() {
    currentUser = null;
    currentSession = null;
    isPremium = false;
    notifyListeners();
  }
}

extension AuthManagement on AuthStateModel {
  Future<bool> signIn() async {
    if (_authProvider == null) {
      return false;
    }
    //sign in
    AuthResponse response;
    try {
      response = await _authProvider!.signIn();
    } catch (_) {
      return false;
    }
    if (response.user == null || response.session == null) {
      return false;
    }
    //set data
    setData(response.user!, response.session!, await userHasPremium());
    return true;
  }

  Future<bool> signOut() async {
    try {
      await client.auth.signOut();
    } catch (_) {
      return false;
    }

    _authProvider = null;
    clearData();

    return true;
  }
}

extension PremiumManagement on AuthStateModel {
  Future<bool> userHasPremium({String? userId}) async {
    if (currentUser == null && userId == null) {
      return false;
    }
    String id = userId ?? currentUser!.id;
    try {
      final List<dynamic> response = await client
          .from('user_premium_public_view')
          .select('is_premium')
          .eq('user_id', id);
      if (response.length != 1) {
        return false;
      }

      return Map<String, dynamic>.from(response[0])['is_premium'] as bool;
    } catch (e) {
      if (kDebugMode) {
        print('userHasPremium() threw an error: $e');
      }
      return false;
    }
  }
}
