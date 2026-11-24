import 'package:bhumi_manthan/helpers/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_auth/firebase_auth.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signIn() async {
    try {
      await GoogleSignIn.instance.initialize();

      final googleUser = await GoogleSignIn.instance.authenticate();

      final googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      AppLoader.show();
      final userCredential = await _auth.signInWithCredential(credential);
      if (userCredential.user == null) return null;

      final idToken = await userCredential.user!.getIdToken();
      await AppLoader.close();

      return idToken;
    } catch (e) {
      debugPrint('Google Login Error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await GoogleSignIn.instance.signOut();

      debugPrint('Google Logout Successful');
    } catch (e) {
      debugPrint('Google Logout Error: $e');
    }
  }
}
