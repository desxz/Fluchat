import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../product/service/navigation/navigation_service.dart';
import '../../auth/model/user_model.dart';
import '../model/message_model.dart';
import '../viewmodel/chat_viewmodel.dart';

// ignore: must_be_immutable
class ChatView extends StatelessWidget {
  final UserModel user;

  ChatView({
    Key? key,
    required this.user,
  }) : super(key: key) {
    _chatVM = ChatViewModel(user: user);
  }

  late ChatViewModel _chatVM;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildChatViewBody,
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: IconButton(
          onPressed: () => NavigationService.instance.navigateToPop(),
          icon: Icon(Icons.arrow_back)),
      title: buildAppBarTitle(context),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.phone)),
        IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
      ],
    );
  }

  Row buildAppBarTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
            radius: 20,
            child: CachedNetworkImage(imageUrl: user.imageUrl ?? '')),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.07,
        ),
        Text('$user.nameSurname'),
      ],
    );
  }

  Column get buildChatViewBody {
    return Column(
      children: [
        buildScrollableMessageArea,
        buildMessageBoxPadding,
      ],
    );
  }

  Expanded get buildScrollableMessageArea => Expanded(
        child: StreamBuilder<QuerySnapshot>(
          stream: _chatVM.chatRoom,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong!'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (snapshot.hasData) {
              List<MessageModel> _messages = snapshot.data!.docs
                  .map((e) =>
                      MessageModel().fromJson(e.data() as Map<String, dynamic>))
                  .toList();
              _chatVM.messages[user.userid!] = _messages;
            }
            return Observer(builder: (_) {
              return ListView.builder(
                  itemCount: _chatVM.messages[user.userid!]?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment:
                          _chatVM.messages[user.userid!]![index].receiverId ==
                                  user.userid
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width / 4,
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.75,
                              minHeight: 40,
                            ),
                            decoration: BoxDecoration(
                              color: _chatVM.messages[user.userid!]![index]
                                          .receiverId ==
                                      user.userid
                                  ? Colors.blue
                                  : Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(_chatVM
                                .messages[user.userid!]![index].message!),
                          ),
                        ),
                      ],
                    );
                  });
            });
          },
        ),
      );

  Padding get buildMessageBoxPadding {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: buildTextFieldMessage,
    );
  }

  TextField get buildTextFieldMessage {
    return TextField(
      controller: _chatVM.messageTextController,
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
    await _chatVM.firebaseCloudFireStore
        .sendMessage(_chatVM.messageTextController.text, user.userid!);
    _chatVM.messageTextController.text = '';
  }
}
