import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../product/service/firebase/firebase_authentication.dart';
import '../../../product/service/firebase/firebase_cloudfirestore.dart';
import '../../chat/model/chatroom_model.dart';

part 'home_viewmodel.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  final firebaseFirestore = FirebaseCloudFirestore.instance;
  final firebaseAuthService = FirebaseAuthService.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>>? rooms;

  @observable
  List<ChatRoom> chatRoomList = [];

  String? currentUserId;

  @observable
  var isLoadingData = false;

  _HomeViewModelBase() {
    currentUserId = firebaseAuthService.auth.currentUser!.uid;
    getRoomStream();
  }

  Future<void> getSnapshotData(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot) async {
    isLoadingData = true;

    chatRoomList = snapshot.data!.docs
        .map((e) => ChatRoom().fromJson(e.data() as Map<String, dynamic>))
        .toList();

    isLoadingData = false;
  }

  @action
  void getRoomStream() {
    rooms = firebaseFirestore.getChatRooms().snapshots();
  }
}
