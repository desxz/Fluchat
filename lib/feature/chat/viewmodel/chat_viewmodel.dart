import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../product/service/firebase/firebase_cloudfirestore.dart';
import '../../auth/model/user_model.dart';
import '../model/message_model.dart';

part 'chat_viewmodel.g.dart';

class ChatViewModel = _ChatViewModelBase with _$ChatViewModel;

abstract class _ChatViewModelBase with Store {
  FirebaseCloudFirestore get firebaseCloudFireStore =>
      FirebaseCloudFirestore.instance;

  _ChatViewModelBase({
    this.user,
  }) {
    chatRoomFinder();
  }

  final TextEditingController messageTextController = TextEditingController();
  final UserModel? user;

  @observable
  Map<String, List<MessageModel>> messages = {};

  Stream<QuerySnapshot<Map<String, dynamic>>>? chatRoom;

  Future<void> chatRoomFinder() async {
    final roomId =
        await firebaseCloudFireStore.findChatRoomByOrder(user!.userid!);
    chatRoom = roomId!.snapshots();
  }

  Future<void> sendChatMessage() async {
    await firebaseCloudFireStore.sendMessage(
        messageTextController.text, user!.userid!);
    messageTextController.text = '';
  }
}
