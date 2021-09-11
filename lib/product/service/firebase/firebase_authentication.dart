import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  static FirebaseAuthService? _instance;
  static FirebaseAuthService get instance =>
      _instance ??= FirebaseAuthService._init();
  FirebaseAuthService._init();

  final auth = FirebaseAuth.instance;

  Future<void> firebaseVerifyPhoneNumber(
      String phoneNumber,
      void Function(PhoneAuthCredential) verificationCompleted,
      void Function(FirebaseAuthException) verificationFailed,
      void Function(String, int?) codeSent,
      void Function(String) codeAutoRetrievalTimeout,
      int? forceResendingToken,
      Duration? timeoutDuration) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        forceResendingToken: forceResendingToken,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        timeout: timeoutDuration ?? Duration(seconds: 90),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<User?> signInWithPhoneAuthCredential(
      PhoneAuthCredential credential) async {
    try {
      final _credential = await auth.signInWithCredential(credential);
      return _credential.user;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
