import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:zpi_project/database_configuration/firestore_service.dart';

import '../models/user.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final firestoreService = FirestoreService();

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signInWithCredential({
    required AuthCredential credential,
  }) async {
    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signOutUser() async {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseAuth.instance.signOut();
      debugPrint("User logged out");
    }
  }

  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    return await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Check if a user is currently signed in
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<UserCredential> registerUser(UserModel user) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
    return userCredential;
  }

  Future<UserCredential?> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status == LoginStatus.cancelled) {
      return null;
    } else if (loginResult.status == LoginStatus.failed) {
      return null;
    }

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    final email = await getEmailFromFacebook();

    if (await firestoreService.isEmailUnique(email)) {
      signOutUser();
      throw FirebaseAuthException(code: 'account-does-not-exist');
    } else {
      debugPrint("Logged user: $email");
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(facebookAuthCredential);
      return userCredential;
    }
  }

  Future<UserCredential?> registerWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status == LoginStatus.cancelled) {
      return null;
    } else if (loginResult.status == LoginStatus.failed) {
      return null;
    }

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    final email = await getEmailFromFacebook();

    if (!await firestoreService.isEmailUnique(email)) {
      signOutUser();
      throw FirebaseAuthException(code: 'email-already-in-use');
    } else {
      debugPrint("Logged user: $email");
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(facebookAuthCredential);
      return userCredential;
    }
  }

  Future<String> getEmailFromFacebook() async {
    final userData = await FacebookAuth.instance.getUserData();
    return userData['email'] ?? '';
  }
}
