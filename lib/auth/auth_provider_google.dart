import 'package:client/auth/auth_provider_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProviderGoogle implements AuthProviderInterface {
  //TO DO: check
  static const webClientId =
      '98934243915-6n2mmddkjjn9krggjj8uigd8h7i18ikr.apps.googleusercontent.com';
  static const scopes = ['email']; //'profile' 'openid'

  GoogleSignIn googleSignIn =
      GoogleSignIn(serverClientId: webClientId, scopes: scopes);

  /// throws
  @override
  Future<AuthResponse> signIn() async {
    GoogleSignInAccount? googleAccount;
    try {
      googleAccount = await googleSignIn.signIn();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw ("Sign-in error");
    }

    if (googleAccount == null) {
      throw ("_googleAccount is null");
    }
    final authData = await googleAccount.authentication;
    final accessToken = authData.accessToken;
    final idToken = authData.idToken;

    if (accessToken == null || idToken == null) {
      throw ("accessToken is null");
    }

    return Supabase.instance.client.auth.signInWithIdToken(
        provider: Provider.google, idToken: idToken, accessToken: accessToken);
  }

  @override
  Future<bool> signOut() async {
    try {
      await googleSignIn.signOut();
    } catch (e) {
      if (kDebugMode) {
        print("signOut exception: $e");
      }
      return false;
    }

    return true;
  }
}
