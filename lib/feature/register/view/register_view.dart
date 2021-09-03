import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

import '../viewmodel/register_viewmodel.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key, required this.user}) : super(key: key);
  final User user;

  final _registerVM = RegisterViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                selectImageSource(context);
              },
              child: Observer(builder: (_) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: _registerVM.image == null
                          ? Icon(
                              Icons.camera_alt,
                              size: 36,
                            )
                          : Image.file(
                              _registerVM.image!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.11,
                      left: MediaQuery.of(context).size.width * 0.18,
                      child: CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.photo_camera),
                      ),
                    ),
                  ],
                );
              }),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            TextField(
              controller: _registerVM.inputNameSurnameController,
              decoration: InputDecoration(hintText: 'Name Surname'),
            ),
            SizedBox(
              height: 40,
            ),
            TextButton(
                child: Text('SAVE'),
                onPressed: () {
                  _registerVM.uploadProfilePhoto(user.uid);
                }),
          ],
        ),
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
              onPressed: () async {
                await _registerVM.pickImage(ImageSource.camera);
              },
              child: Text('Camera'),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                await _registerVM.pickImage(ImageSource.gallery);
              },
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
              onTap: () async {
                await _registerVM.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_album),
              title: Text('Gallery'),
              onTap: () async {
                await _registerVM.pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      );
    }
  }
}
