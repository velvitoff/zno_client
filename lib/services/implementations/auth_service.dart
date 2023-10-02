import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

const clientId =
    '98934243915-hc1bf63svn2kn40ldqf6ss5gkg5omchj.apps.googleusercontent.com';
const clientIdDebug =
    '98934243915-28499imh8iu3n0nt8ebadsnh2ptu47p5.apps.googleusercontent.com ';

class AuthService {
  const AuthService();

  SupabaseClient get client => Supabase.instance.client;

  String _generateRandomString() {
    final random = Random.secure();
    return base64Url.encode(List<int>.generate(16, (_) => random.nextInt(256)));
  }

  Future<bool> signInGooglePack() async {
    GoogleSignIn googleSignIn =
        GoogleSignIn(serverClientId: clientId, scopes: ['openid', 'email']);

    try {
      await googleSignIn.signIn();
    } catch (error) {
      print('PRINT: $error');
    }
    return true;
  }

  Future<bool> signInGoogle() async {
    final rawNonce = _generateRandomString();
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

    final redirectUrl = '${clientId.split('.').reversed.join('.')}:/';
    const discoveryUrl =
        'https://accounts.google.com/.well-known/openid-configuration';
    final appAuth = const FlutterAppAuth();

    print('BEGIN');
    // authorize the user by opening the consent page
    final result = await appAuth.authorize(
      AuthorizationRequest(
        clientId,
        redirectUrl,
        discoveryUrl: discoveryUrl,
        nonce: hashedNonce,
        scopes: [
          'openid',
          'email',
        ],
      ),
    );
    if (result == null) {
      print('Could not find AuthorizationResponse after authorizing');
      return false;
    }

    // Request the access and id token to google
    final tokenResult = await appAuth.token(
      TokenRequest(
        clientId,
        redirectUrl,
        authorizationCode: result.authorizationCode,
        discoveryUrl: discoveryUrl,
        codeVerifier: result.codeVerifier,
        nonce: result.nonce,
        scopes: [
          'openid',
          'email',
        ],
      ),
    );

    final idToken = tokenResult?.idToken;

    if (idToken == null) {
      print('Could not find idToken from the token response');
      return false;
    }

    final AuthResponse authResponse = await client.auth.signInWithIdToken(
      provider: Provider.google,
      idToken: idToken,
      accessToken: tokenResult?.accessToken,
      nonce: rawNonce,
    );
    print('authResponse: ${authResponse.user}');
    return true;
  }
}
