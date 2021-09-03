import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class FirebaseStorageService {
  static FirebaseStorageService? _instance;
  static FirebaseStorageService get instance =>
      _instance ??= FirebaseStorageService._init();
  FirebaseStorageService._init();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<bool?> uploadFile(String filePath, String userId) async {
    final _file = File(filePath);

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('profile_photos/$userId.png')
          .putFile(_file);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
