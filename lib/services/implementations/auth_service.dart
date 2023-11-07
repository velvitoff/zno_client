import 'package:supabase_flutter/supabase_flutter.dart';
//import 'package:google_sign_in/google_sign_in.dart';

const clientId =
    '98934243915-hc1bf63svn2kn40ldqf6ss5gkg5omchj.apps.googleusercontent.com';
const clientIdDebug =
    '98934243915-28499imh8iu3n0nt8ebadsnh2ptu47p5.apps.googleusercontent.com ';

class AuthService {
  const AuthService();

  SupabaseClient get client => Supabase.instance.client;

  Future<bool> signInGooglePack() async {
    //GoogleSignIn googleSignIn =
    //    GoogleSignIn(serverClientId: clientId, scopes: ['openid', 'email']);
    return true;
  }
}
