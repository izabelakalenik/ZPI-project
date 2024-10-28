import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
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
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,);

    return userCredential;
  }

}
