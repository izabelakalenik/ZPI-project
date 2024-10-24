import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

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

  Future<UserCredential> registerUser({
    required String email,
    required String password,
    required String name,
    required String username,
    required String birthYear,
    required String gender,
    required List<String> likedGenres,
  }) async {
    // Register the user in Firebase Authentication
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // After registration, save additional user details to Firestore
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'name': name,
      'username': username,
      'birthYear': birthYear,
      'gender': gender,
      'likedGenres': likedGenres,
      'email': email,
    });

    return userCredential;
  }

  Future<void> updateFavoriteGenres(List<String> favoriteGenres) async {
    final User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      await _firestore.collection('users').doc(firebaseUser.uid).update({
        'likedGenres': favoriteGenres,
      });
    } else {
      throw Exception("User not logged in");
    }
  }
}
