import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  final String webClientId =
      '897078098090-6di38p5ebn67ff8sjkljki9rc87vjst3.apps.googleusercontent.com';

  Future<void> initialize() async {
    await GoogleSignIn.instance.initialize(serverClientId: webClientId);
  }

  Future<String?> signIn() async {
    try {
      final account = await _googleSignIn.authenticate();

      final idToken = account.authentication.idToken;

      if (idToken == null) {
        debugPrint('Google ID token is not available');
        return null;
      }

      return idToken;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        debugPrint('Google Sign-In cancelled by user');
      } else {
        debugPrint('Google Sign-In error: ${e.code} - ${e.description}');
      }
      return null;
    } catch (e) {
      debugPrint('Unexpected Google Sign-In error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
