import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

const androidClientId =
    '98934243915-hc1bf63svn2kn40ldqf6ss5gkg5omchj.apps.googleusercontent.com';
const webClientId =
    '98934243915-6n2mmddkjjn9krggjj8uigd8h7i18ikr.apps.googleusercontent.com';
const scopes = ['email']; //'profile' 'openid'

class AuthService {
  AuthService();

  GoogleSignInAccount? _googleAccount; //_account.authentication
  SupabaseClient get client => Supabase.instance.client;

  GoogleSignIn googleSignIn =
      GoogleSignIn(serverClientId: webClientId, scopes: scopes);

  bool get isLoggedIn => googleSignIn.currentUser != null;
  GoogleSignInAccount? get getAccount => isLoggedIn ? _googleAccount : null;

  Future<bool> signInGoogle() async {
    try {
      _googleAccount = await googleSignIn.signIn();
      print('_googleAccount: $_googleAccount');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }

    if (_googleAccount == null) {
      return false;
    }

    return true;
  }
}
