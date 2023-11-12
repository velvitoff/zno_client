import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

const clientId =
    '98934243915-hc1bf63svn2kn40ldqf6ss5gkg5omchj.apps.googleusercontent.com';
const clientIdDebug =
    '98934243915-28499imh8iu3n0nt8ebadsnh2ptu47p5.apps.googleusercontent.com ';

class AuthService {
  AuthService();

  GoogleSignInAccount? _account;
  SupabaseClient get client => Supabase.instance.client;

  GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: clientId, scopes: ['openid', 'email']); //'profile'

  bool get isLoggedIn => googleSignIn.currentUser != null;
  GoogleSignInAccount? get getAccount => isLoggedIn ? _account : null;

  Future<bool> signInGoogle() async {
    try {
      _account = await googleSignIn.signIn();
      if (_account == null) {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
    return true;
  }
}
