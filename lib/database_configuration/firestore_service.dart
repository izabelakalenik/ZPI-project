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
}
