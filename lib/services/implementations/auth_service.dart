import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  AuthService();

  SupabaseClient get client => Supabase.instance.client;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '98934243915-hc1bf63svn2kn40ldqf6ss5gkg5omchj.apps.googleusercontent.com',
  );

  Future<bool> signInGoogle() async {
    //begin interactive sign-in process
    GoogleSignInAccount? gUser;
    try {
      gUser = await _googleSignIn.signIn();
    } catch (e) {
      print(e);
    }

    if (gUser == null) {
      return false;
    }

    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser.authentication;
    final String? idToken = gAuth.idToken;
    final String? accessToken = gAuth.accessToken;
    if (idToken == null || accessToken == null) {
      return false;
    }

    //create a new credential for user
    final AuthResponse response = await client.auth.signInWithIdToken(
      provider: Provider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
    print(response.session);
    print(response.user);
    return true;
  }
}
