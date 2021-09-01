import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../product/service/navigation/navigation_service.dart';
import '../../auth/model/user_model.dart';
import '../../friends/viewmodel/friends_viewmodel.dart';

class ChatView extends StatelessWidget {
  ChatView({Key? key, this.user}) : super(key: key);

  final UserModel? user;
  final _userVM = FriendsViewModel();
  final Stream<QuerySnapshot> _messageStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
            onPressed: () => NavigationService.instance.navigateToPop(),
            icon: Icon(Icons.arrow_back)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
                radius: 20,
                child: CachedNetworkImage(imageUrl: user?.imageUrl ?? '')),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.07,
            ),
            Text('${user?.name} ${user?.surname}'),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.phone)),
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Container()),
          buildMessageBoxPadding,
        ],
      ),
    );
  }

  Padding get buildMessageBoxPadding {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: buildTextFieldMessage,
    );
  }

  TextField get buildTextFieldMessage {
    return TextField(
      controller: _userVM.messageTextController,
      decoration: InputDecoration(
          border: OutlineInputBorder().copyWith(
            borderRadius: BorderRadius.circular(40),
          ),
          suffixIcon: buildIconButton),
    );
  }

  Padding get buildIconButton {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: sendMessageButton,
    );
  }

  IconButton get sendMessageButton =>
      IconButton(onPressed: sendChatMessage, icon: Icon(Icons.send));

  Future<void> sendChatMessage() async {
    await _userVM.firebaseCloudFireStore
        .sendMessage(_userVM.messageTextController.text, user!.userid!);
    _userVM.messageTextController.text = '';
  }
}
