import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../feature/auth/model/user_model.dart';
import '../../../feature/chat/model/message_model.dart';

class FirebaseCloudFirestore {
  static FirebaseCloudFirestore? _instance;
  static FirebaseCloudFirestore get instance =>
      _instance ??= FirebaseCloudFirestore._init();
  FirebaseCloudFirestore._init();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel?>? getCurrentUserData(String uid) {
    try {
      final _currentUser = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((value) => UserModel().fromJson(value.data()!));
      return _currentUser;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

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
      String userPhoneNumber) {
    final _allUsers = FirebaseFirestore.instance.collection('users');
    try {
      final response =
          _allUsers.where('phoneNumber', isEqualTo: userPhoneNumber).get();
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> addFriends(String userPhoneNumber) async {
    List<UserModel> _friendList = await searchFriendData(userPhoneNumber)!.then(
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

  Future<bool?> addFriendsFromPhoneDrirectory(
      Iterable<Contact> contacts) async {
    for (var item in contacts) {
      try {
        Map<String, dynamic> map = {};
        if (item.phones != null && item.phones!.isNotEmpty) {
          String? phoneNumber;

          print('DOGRU GİDİYOR!');
          print(item.phones.toString());
          phoneNumber = item.phones!.first.value!.replaceAll(' ', '');
          final currentContact = await searchFriendData(phoneNumber);
          if (currentContact!.docs.isNotEmpty) {
            map = currentContact.docs[0].data()!;
            print(map.toString());
            print('BURADA ŞUAN');

            await FirebaseFirestore.instance
                .collection('users')
                .doc(_firebaseAuth.currentUser!.uid)
                .collection('friends')
                .doc(map['userid'])
                .set(map);
          }
        } else {
          print('BURAYA DÜŞTÜ');
        }
      } catch (e) {
        debugPrint(e.toString());
        return false;
      }
    }
    return true;
  }

  Future<bool?> addFriendsWithInvite(String userPhoneNumber) async {
    List<UserModel> _friendList = await searchFriendData(userPhoneNumber)!.then(
        (value) =>
            value!.docs.map((e) => UserModel().fromJson(e.data()!)).toList());
    final invitations = FirebaseFirestore.instance
        .collection('users')
        .doc(_friendList[0].userid)
        .collection('invitations')
        .doc(_firebaseAuth.currentUser!.uid);
    final userData = await getCurrentUserData(_firebaseAuth.currentUser!.uid);
    try {
      final response = invitations.set(userData!.toJson());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<List<UserModel?>?> fetchFriendsData() async {
    final _friendsCol = FirebaseFirestore.instance
        .collection('users')
        .doc(_firebaseAuth.currentUser?.uid)
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

  Future<CollectionReference<Map<String, dynamic>>?> findChatRoom(
      String receiverId) async {
    var _messageList = [];

    final _chatRoom = await FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(_firebaseAuth.currentUser!.uid + receiverId)
        .collection('messages')
        .get()
        .then((value) => _messageList.addAll(value.docs));
    if (_messageList.isEmpty) {
      return FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(receiverId + _firebaseAuth.currentUser!.uid)
          .collection('messages');
    } else {
      return FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(_firebaseAuth.currentUser!.uid + receiverId)
          .collection('messages');
    }
  }

  Future<Query<Map<String, dynamic>>?> findChatRoomByOrder(
      String receiverId) async {
    var _messageList = [];

    final _chatRoom = await FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(_firebaseAuth.currentUser!.uid + receiverId)
        .collection('messages')
        .get()
        .then((value) => _messageList.addAll(value.docs));
    if (_messageList.isEmpty) {
      return FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(receiverId + _firebaseAuth.currentUser!.uid)
          .collection('messages')
          .orderBy('messageTime', descending: false);
    } else {
      return FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(_firebaseAuth.currentUser!.uid + receiverId)
          .collection('messages')
          .orderBy('messageTime', descending: false);
    }
  }

  Future<bool?> sendMessage(String message, String receiverId) async {
    final _chatRoom = await findChatRoom(receiverId);
    try {
      await _chatRoom!.add(
          new MessageModel(message: message, receiverId: receiverId).toJson());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
