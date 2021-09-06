import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class UserFormStateWidget extends StatelessWidget {
  UserFormStateWidget({
    Key? key,
    required this.user,
    required this.phoneNumber,
    this.onPressed,
    this.controller,
    this.image,
    this.pickImageFromGallery,
    this.pickImageFromCamera,
  }) : super(key: key);
  final User user;
  final String phoneNumber;
  final void Function()? onPressed;
  final TextEditingController? controller;
  final File? image;
  final void Function()? pickImageFromGallery;
  final void Function()? pickImageFromCamera;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    child: image == null
                        ? Icon(
                            Icons.camera_alt,
                            size: 36,
                          )
                        : Image.file(
                            image!,
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
            controller: controller,
            decoration: InputDecoration(hintText: 'Name Surname'),
          ),
          SizedBox(
            height: 40,
          ),
          TextButton(child: Text('SAVE'), onPressed: onPressed),
        ],
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
              onPressed: pickImageFromCamera!,
              child: Text('Camera'),
            ),
            CupertinoActionSheetAction(
              onPressed: pickImageFromGallery!,
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
              onTap: pickImageFromCamera,
            ),
            ListTile(
              leading: Icon(Icons.photo_album),
              title: Text('Gallery'),
              onTap: pickImageFromGallery,
            ),
          ],
        ),
      );
    }
  }
}
