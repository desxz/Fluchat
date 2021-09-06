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

  Future<bool?> uploadFile({String? filePath, String? uploadPath}) async {
    final _file = File(filePath ?? '');

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(uploadPath ?? '')
          .putFile(_file);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<String?> getFileDownloadUrl(String downloadPath) async {
    try {
      final downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref(downloadPath)
          .getDownloadURL();
      return downloadURL;
    } catch (e) {
      debugPrint(e.toString());
      return 'false';
    }
  }
}
