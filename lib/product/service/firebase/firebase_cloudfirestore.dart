import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../feature/auth/model/user_model.dart';

class FirebaseCloudFirestore {
  static FirebaseCloudFirestore? _instance;
  static FirebaseCloudFirestore get instance =>
      _instance ??= FirebaseCloudFirestore._init();
  FirebaseCloudFirestore._init();

  final _users = FirebaseFirestore.instance.collection('users');
  final Stream<QuerySnapshot> userData =
      FirebaseFirestore.instance.collection('users').snapshots();

  Future<void> saveUserData(UserModel usermodel) async {
    try {
      await _users.add(usermodel.toJson());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<UserModel?>?> fecthAllUser() async {
    List<UserModel> _userList = [];

    try {
      final response = await _users.get();
      _userList =
          response.docs.map((e) => UserModel().fromJson(e.data())).toList();
      print(_userList);
      return _userList;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void sendMassage() {}
}
