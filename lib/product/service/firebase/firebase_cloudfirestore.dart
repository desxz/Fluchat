import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../feature/auth/model/user_model.dart';
import '../../../feature/chat/model/message_model.dart';

class FirebaseCloudFirestore {
  static FirebaseCloudFirestore? _instance;
  static FirebaseCloudFirestore get instance =>
      _instance ??= FirebaseCloudFirestore._init();
  FirebaseCloudFirestore._init();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> saveUserData(UserModel usermodel) async {
    final user = FirebaseFirestore.instance
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid);

    try {
      await user.set(usermodel.toJson());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>?>?>? searchFriendData(
      String usermail) {
    final _allUsers = FirebaseFirestore.instance.collection('users');
    try {
      final response = _allUsers.where('email', isEqualTo: usermail).get();
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> addFriends(String usermail) async {
    List<UserModel> _friendList = await searchFriendData(usermail)!.then(
        (value) =>
            value!.docs.map((e) => UserModel().fromJson(e.data()!)).toList());
    final _friendsCol = FirebaseFirestore.instance
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('friends')
        .doc(_friendList[0].userid);
    try {
      await _friendsCol.set(_friendList[0].toJson());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<List<UserModel?>?> fetchFriendsData() async {
    final _friendsCol = FirebaseFirestore.instance
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('friends');
    List<UserModel> _friendsList = [];
    try {
      final response = await _friendsCol.get();
      _friendsList =
          response.docs.map((e) => UserModel().fromJson(e.data())).toList();
      return _friendsList;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<bool?> sendMessage(String message, String receiverId) async {
    final _chatRoom = FirebaseFirestore.instance
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('friends')
        .doc(receiverId)
        .collection('chatroom');
    try {
      await _chatRoom.add(
          new MessageModel(message: message, receiverId: receiverId).toJson());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
