import 'package:client/auth/auth_provider_google.dart';
import 'package:client/auth/auth_provider_interface.dart';
import 'package:client/locator.dart';
import 'package:client/services/supabase_service.dart';
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

  void setData({User? user, Session? session, bool? premium}) {
    currentUser = user ?? currentUser;
    currentSession = session ?? currentSession;
    isPremium = premium ?? isPremium;
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
    setData(
        user: response.user!,
        session: response.session!,
        premium: await isUserPremium());
    return true;
  }

  Future<bool> signOut() async {
    //Can signOut from Supabase without singing out from google if the app was relaucnhed
    await Supabase.instance.client.auth.signOut();
    if (_authProvider == null) {
      return false;
    }
    try {
      await _authProvider!.signOut();
    } catch (_) {
      return false;
    }

    _authProvider = null;
    clearData();

    return true;
  }
}

extension PremiumManagement on AuthStateModel {
  Future<bool> isUserPremium({User? user}) async {
    final User? resUser = user ?? currentUser;
    if (resUser == null) {
      return false;
    }
    return locator.get<SupabaseService>().isUserPremium(resUser);
  }

  Future<void> updatePremiumStatus({bool ignoreServer = false}) async {
    if (ignoreServer) {
      setData(premium: true);
    } else {
      setData(premium: await isUserPremium());
    }
  }
}
