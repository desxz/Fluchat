import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../feature/auth/model/user_model.dart';
import '../../../feature/chat/model/chatroom_model.dart';
import '../../../feature/chat/model/message_model.dart';

class FirebaseCloudFirestore {
  static FirebaseCloudFirestore? _instance;
  static FirebaseCloudFirestore get instance =>
      _instance ??= FirebaseCloudFirestore._init();
  FirebaseCloudFirestore._init();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel?> getUserDataById(String userId) async {
    var user = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) => UserModel().fromJson(value.data()!));
    return user;
  }

  Future<void> saveUser(UserModel usermodel) async {
    final currentUser = _firebaseAuth.currentUser!;

    final user =
        FirebaseFirestore.instance.collection('users').doc(currentUser.uid);

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
    final currentUser = _firebaseAuth.currentUser!;

    List<UserModel> _friendList = await searchFriendData(userPhoneNumber)!.then(
        (value) =>
            value!.docs.map((e) => UserModel().fromJson(e.data()!)).toList());
    final _friendsCol = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
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
    final currentUser = _firebaseAuth.currentUser!;

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
                .doc(currentUser.uid)
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

  Future<List<UserModel?>?> fetchFriendsData() async {
    final currentUser = _firebaseAuth.currentUser!;

    final _friendsCol = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
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

  Future<CollectionReference<Map<String, dynamic>>?>
      getPrivateChatRoomCollection(String receiverId) async {
    final currentUser = _firebaseAuth.currentUser!;

    var _currentId = currentUser.uid;
    var roomid1 =
        '0private' + _currentId.substring(0, 9) + receiverId.substring(0, 9);
    var roomid2 =
        '0private' + receiverId.substring(0, 9) + _currentId.substring(0, 9);

    final _chatRoom = await FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(roomid1)
        .collection('messages')
        .get()
        .then((value) => value.docs.isNotEmpty ? true : false);
    if (_chatRoom) {
      return FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(roomid1)
          .collection('messages');
    } else {
      return FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(roomid2)
          .collection('messages');
    }
  }

  Future<Query<Map<String, dynamic>>?> findChatRoomByOrder(
      String receiverId) async {
    final currentUser = _firebaseAuth.currentUser!;

    var _currentId = currentUser.uid;
    var roomid1 =
        '0private' + _currentId.substring(0, 9) + receiverId.substring(0, 9);
    var roomid2 =
        '0private' + receiverId.substring(0, 9) + _currentId.substring(0, 9);

    final _chatRoom = await FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(roomid1)
        .collection('messages')
        .get()
        .then((value) => value.docs.isNotEmpty ? true : false);
    if (_chatRoom) {
      return FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(roomid1)
          .collection('messages')
          .orderBy('messageTime', descending: false);
    } else {
      return FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(roomid2)
          .collection('messages')
          .orderBy('messageTime', descending: false);
    }
  }

  Query<Map<String, dynamic>> getChatRooms() {
    final currentUser = _firebaseAuth.currentUser!;

    var _currentId = currentUser.uid;
    final startQuery = '0private' + _currentId.substring(0, 9);
    final endQuery = _currentId.substring(0, 9) + '~';

    var rooms = FirebaseFirestore.instance
        .collection('chatrooms')
        .where('id', isGreaterThanOrEqualTo: startQuery)
        .where('id', isLessThanOrEqualTo: endQuery);

    print(rooms);

    return rooms;
  }

  Future<bool?> sendMessage(String message, String receiverId) async {
    final currentUser = _firebaseAuth.currentUser!;

    final _chatRoom = await getPrivateChatRoomCollection(receiverId);
    final _chatRoomData =
        _chatRoom!.parent!.collection('features').doc('room-data');
    final _currentSender = currentUser.uid;
    final roomdata = await _chatRoom.parent!.parent
        .get()
        .then((value) => value.docs.isEmpty ? true : false);

    final currentUserModel = await getUserDataById(currentUser.uid);
    final receiverModel = await getUserDataById(receiverId);

    try {
      if (roomdata) {
        await FirebaseFirestore.instance
            .collection('chatrooms')
            .doc(_chatRoom.parent!.id)
            .set(ChatRoom(
              users: [currentUserModel!.toJson(), receiverModel!.toJson()],
              id: _chatRoomData.parent.parent!.id,
              lastMessage: DateTime.now(),
            ).toJson());
      } else {
        FirebaseFirestore.instance
            .collection('chatrooms')
            .doc(_chatRoom.parent!.id)
            .set(ChatRoom(
              users: [currentUserModel!.toJson(), receiverModel!.toJson()],
              id: _chatRoomData.parent.parent!.id,
              lastMessage: DateTime.now(),
            ).toJson());
      }

      await _chatRoom.add(MessageModel(
              message: message,
              receiverId: receiverId,
              messageTime: DateTime.now(),
              senderId: _currentSender)
          .toJson());

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
