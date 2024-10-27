import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<UserCredential> registerUser(String email, String password, String name, String username, int birthYear, String gender, String country, List<String> favoriteGenres) async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'name': name,
      'username': username,
      'birthYear': birthYear,
      'gender': gender,
      'country': country,
      'likedGenres': favoriteGenres,
      'email': email,
    });

    return userCredential;
  }

  Future<bool> isUsernameUnique(String username) async {
    final users = await FirebaseFirestore.instance.collection('users')
        .where('username', isEqualTo: username)
        .get();
    return users.docs.isEmpty;
  }

  Future<bool> isEmailUnique(String email) async {
    final users = await FirebaseFirestore.instance.collection('users')
        .where('email', isEqualTo: email)
        .get();
    return users.docs.isEmpty;
  }



}
