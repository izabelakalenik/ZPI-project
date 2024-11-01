import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isUsernameUnique(String username) async {
    final users = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
    return users.docs.isEmpty;
  }

  Future<bool> isEmailUnique(String email) async {
    final users = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return users.docs.isEmpty;
  }

  Future<void> saveUser(UserModel user, String uid) async {
    await _firestore.collection('users').doc(uid).set({
      'name': user.name,
      'username': user.username,
      'birthYear': user.birthYear,
      'gender': user.gender,
      'country': user.country,
      'likedGenres': user.favoriteGenres,
      'email': user.email,
    });
  }

  Future<UserModel> fetchUser(String uid) async {
    try {
      final docSnapshot = await _firestore.collection('users').doc(uid).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        return UserModel(
          email: data?['email'] ?? '',
          password: '', // Passwords are not stored in Firestore, passing "" because passing UserModel is easier than passing all other vaLues separately
          name: data?['name'] ?? '',
          username: data?['username'] ?? '',
          birthYear: data?['birthYear'] ?? 0,
          gender: data?['gender'] ?? '',
          country: data?['country'] ?? '',
          favoriteGenres: List<String>.from(data?['likedGenres'] ?? []),
        );
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception("Failed to fetch user data: $e");
    }
  }
}
