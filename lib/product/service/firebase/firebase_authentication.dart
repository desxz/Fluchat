import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../feature/auth/model/user_model.dart';
import 'firebase_cloudfirestore.dart';

class FirebaseAuthService {
  static FirebaseAuthService? _instance;
  static FirebaseAuthService get instance =>
      _instance ??= FirebaseAuthService._init();
  FirebaseAuthService._init();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get auth => _auth;
  final FirebaseCloudFirestore _firestore = FirebaseCloudFirestore.instance;

  Future<User?> createUserWithEmailAndPassword(UserModel usermodel) async {
    try {
      final _authResult = await _auth.createUserWithEmailAndPassword(
          email: usermodel.email ?? '', password: usermodel.password ?? '');
      final User? user = _authResult.user;

      usermodel.userid = user!.uid;
      await _firestore.saveUserData(usermodel);
      return user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = _authResult.user;
      return user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
