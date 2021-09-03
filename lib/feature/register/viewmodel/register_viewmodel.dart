import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../product/service/firebase/firebase_storage_service.dart';
import '../../../product/service/navigation/navigation_service.dart';

part 'register_viewmodel.g.dart';

class RegisterViewModel = _RegisterViewModelBase with _$RegisterViewModel;

final _storageService = FirebaseStorageService.instance;

abstract class _RegisterViewModelBase with Store {
  final inputNameSurnameController = TextEditingController();
  final _imagePicker = ImagePicker();

  @observable
  File? image;

  Future<void> pickImage(ImageSource source) async {
    try {
      NavigationService.instance.navigateToPop();
      final _selectedImage = await _imagePicker.pickImage(source: source);
      if (_selectedImage == null) return;

      final _imagePermanent = await saveImagePermanently(_selectedImage.path);
      image = _imagePermanent;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<File?> saveImagePermanently(String imagePath) async {
    final _directory = await getApplicationDocumentsDirectory();
    final _name = basename(imagePath);
    final _image = File('${_directory.path}/$_name');

    return File(imagePath).copy(_image.path);
  }

  Future<bool?> uploadProfilePhoto(String userId) async {
    try {
      await _storageService.uploadFile(image!.path, userId);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
