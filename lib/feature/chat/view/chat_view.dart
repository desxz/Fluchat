import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../product/service/navigation/navigation_service.dart';
import '../../auth/model/user_model.dart';
import '../model/message_model.dart';
import '../viewmodel/chat_viewmodel.dart';
import 'components/message_box.dart';

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
      body: buildChatViewBody(context),
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
        ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: CachedNetworkImage(
              imageUrl: user.imageUrl ?? '',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            )),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.07,
        ),
        Text(user.nameSurname!),
      ],
    );
  }

  Column buildChatViewBody(BuildContext context) {
    return Column(
      children: [
        buildScrollableMessageArea,
        Observer(
            builder: (_) => _chatVM.image != null
                ? Container(
                    child: Image.file(_chatVM.image!),
                    width: 160,
                    height: 160,
                  )
                : Container()),
        buildMessageBoxPadding(context),
        Observer(
          builder: (_) => _chatVM.emojiState ? emojiPicker : Container(),
        ),
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
                  //reverse: true,
                  shrinkWrap: true,
                  itemCount: _chatVM.messages[user.userid!]?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: _chatVM
                                  .messages[user.userid!]![index].senderId ==
                              _chatVM.firebaseAuthService.auth.currentUser!.uid
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MessageBox(
                            user: user,
                            color: _chatVM.messages[user.userid!]![index]
                                        .senderId ==
                                    _chatVM.senderID
                                ? Colors.lightGreen
                                : Colors.blue,
                            message:
                                _chatVM.messages[user.userid!]![index].message!,
                            time: _chatVM
                                .messages[user.userid!]![index].messageTime!,
                            statusIcon: Icons.done,
                          ),
                        ),
                      ],
                    );
                  });
            });
          },
        ),
      );

  Padding buildMessageBoxPadding(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: buildTextFieldMessage(context),
    );
  }

  Row buildTextFieldMessage(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            _chatVM.emojiState = !_chatVM.emojiState;
          },
          icon: Icon(Icons.emoji_emotions),
          iconSize: 24,
        ),
        IconButton(
          onPressed: () async {
            if (await Permission.camera.request().isGranted ||
                await Permission.accessMediaLocation.request().isGranted) {
              selectImageSource(context);
            }
          },
          icon: Icon(Icons.attachment),
          iconSize: 24,
        ),
        Expanded(
          child: Container(
            height: 50,
            child: TextField(
              maxLines: 1,
              controller: _chatVM.messageTextController,
              decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder().copyWith(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  suffixIcon: buildIconButton),
            ),
          ),
        ),
      ],
    );
  }

  Padding get buildIconButton {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: sendMessageButton,
    );
  }

  IconButton get sendMessageButton =>
      IconButton(onPressed: _chatVM.sendChatMessage, icon: Icon(Icons.send));

  SizedBox get emojiPicker {
    return SizedBox(
      height: 250,
      child: EmojiPicker(
        onEmojiSelected: (category, emoji) {
          _chatVM.messageTextController.value = _chatVM
              .messageTextController.value
              .copyWith(text: _chatVM.messageTextController.text + emoji.emoji);
          _chatVM.messageTextController.selection = TextSelection.fromPosition(
            TextPosition(offset: _chatVM.messageTextController.text.length),
          );
        },
        onBackspacePressed: () {
          //_chatVM.emojiState = false;
          _chatVM.messageTextController.value = _chatVM
              .messageTextController.value
              .copyWith(text: _chatVM.messageTextController.text);
        },
      ),
    );
  }

  void selectImageSource(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => _chatVM.pickImage(ImageSource.camera),
              child: Text('Camera'),
            ),
            CupertinoActionSheetAction(
              onPressed: () => _chatVM.pickImage(ImageSource.gallery),
              child: Text('Gallery'),
            ),
          ],
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) => Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () => _chatVM.pickImage(ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.photo_album),
              title: Text('Gallery'),
              onTap: () => _chatVM.pickImage(ImageSource.gallery),
            ),
          ],
        ),
      );
    }
  }
}
