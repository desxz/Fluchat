import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../product/service/firebase/firebase_authentication.dart';
import '../../../product/service/firebase/firebase_cloudfirestore.dart';
import '../../../product/service/firebase/firebase_storage_service.dart';
import '../../../product/service/navigation/navigation_service.dart';
import '../../auth/model/user_model.dart';
import '../model/chatroom_model.dart';
import '../model/message_model.dart';

part 'chat_viewmodel.g.dart';

class ChatViewModel = _ChatViewModelBase with _$ChatViewModel;

abstract class _ChatViewModelBase with Store {
  FirebaseCloudFirestore get firebaseCloudFireStore =>
      FirebaseCloudFirestore.instance;

  FirebaseAuthService get firebaseAuthService => FirebaseAuthService.instance;
  FirebaseStorageService get firebaseStorageService =>
      FirebaseStorageService.instance;

  _ChatViewModelBase({
    this.user,
  }) {
    senderID = firebaseAuthService.auth.currentUser!.uid;
    chatRoomFinder();
    print('BAM!');
  }

  final TextEditingController messageTextController = TextEditingController();
  final _imagePicker = ImagePicker();

  final UserModel? user;
  late String senderID;

  @observable
  Map<String, List<MessageModel>> messages = {};

  @observable
  bool emojiState = false;

  @observable
  File? image;

  Stream<QuerySnapshot<Map<String, dynamic>>>? chatRoom;

  Future<void> chatRoomFinder() async {
    final roomId =
        await firebaseCloudFireStore.findChatRoomByOrder(user!.userid!);
    chatRoom = roomId!.snapshots();
  }

  Future<ChatRoom> findChatRoom() async {
    final room = await firebaseCloudFireStore.getPrivateChatRoom(user!.userid!);
    print(room!.parent!.id.toString());

    return ChatRoom(
      id: room.parent!.id,
      usersId: [senderID, user!.userid!],
      creatingTime: DateTime.now(),
    );
  }

  Future<void> sendChatMessage() async {
    var chatRoom = await findChatRoom();

    if (image != null) {
      var uploadFile =
          await uploadImageOrVideoAndAddMessage(chatRoom.id, image!);
      var imageUrl = await getImageUrl(uploadFile!);
      messageTextController.text = imageUrl!;
    }

    await firebaseCloudFireStore.sendMessage(
        messageTextController.text, user!.userid!);
    messageTextController.text = '';
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      NavigationService.instance.navigateToPop();
      final _selectedImage = await _imagePicker.pickImage(source: source);
      if (_selectedImage == null) return;

      final _imagePermanent = await _saveImagePermanently(_selectedImage.path);
      image = _imagePermanent;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<File?> _saveImagePermanently(String imagePath) async {
    final _directory = await getApplicationDocumentsDirectory();
    final _name = basename(imagePath);
    final _image = File('${_directory.path}/$_name');

    return File(imagePath).copy(_image.path);
  }

  Future<String?> uploadImageOrVideoAndAddMessage(
      String? chatroomid, File imagePath) async {
    final _uploadPath =
        'chatrooms/$chatroomid/images/${basename(imagePath.path)}';
    try {
      await firebaseStorageService.uploadFile(
          filePath: image!.path, uploadPath: _uploadPath);

      image = null;
      return _uploadPath;
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }

  Future<String?> getImageUrl(String downloadPath) async {
    var url =
        await FirebaseStorageService.instance.getFileDownloadUrl(downloadPath);
    return url;
  }
}
