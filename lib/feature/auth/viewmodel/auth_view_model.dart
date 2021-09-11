import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
import '../model/user_model.dart';
import '../view/state/verification_view_state.dart';

part 'auth_view_model.g.dart';

class AuthViewModel = _AuthViewModelBase with _$AuthViewModel;

abstract class _AuthViewModelBase with Store {
  FirebaseAuthService get firebaseAuthService => FirebaseAuthService.instance;

  FirebaseCloudFirestore get firebaseCloudFirestore =>
      FirebaseCloudFirestore.instance;

  FirebaseStorageService get firebaseStorageService =>
      FirebaseStorageService.instance;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final inputNameSurnameController = TextEditingController();
  final _imagePicker = ImagePicker();

  TextEditingController inputPhoneNumberController = TextEditingController();

  TextEditingController inputVerificationIdController = TextEditingController();

  TextEditingController inputImagePathController = TextEditingController();

  @observable
  var isLoadingVerification = false;

  @observable
  var isLoadingUploadData = false;

  @observable
  var resendButtonState = false;

  User? user;

  String? verifyId;

  int? forceResendingToken;

  @observable
  int timeOTPConfirmDuration = 120;

  @observable
  File? image;

  @observable
  UserModel? userModel = UserModel();

  @observable
  var currentState = VerificationState.MOBILE_FORM_STATE;

  Future<void> verifyPhoneNumber(BuildContext context) async {
    await firebaseAuthService.firebaseVerifyPhoneNumber(
      inputPhoneNumberController.text,
      (credential) {
        isLoadingVerification = false;
      },
      (exception) {
        isLoadingVerification = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Something went wrong!\n + ${exception.message}",
            ),
            duration: Duration(seconds: 3),
          ),
        );
      },
      (verificationId, resendingToken) {
        currentState = VerificationState.OTP_STATE;
        verifyId = verificationId;
        forceResendingToken = resendingToken;

        isLoadingVerification = false;
      },
      (verificationId) {
        isLoadingVerification = false;
        resendButtonState = true;
      },
      forceResendingToken,
      Duration(seconds: timeOTPConfirmDuration),
    );
  }

  // ignore: non_constant_identifier_names
  Future<User?> verifyOTPCode() async {
    PhoneAuthCredential _phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: verifyId!,
      smsCode: inputVerificationIdController.text,
    );
    try {
      final _user = await firebaseAuthService
          .signInWithPhoneAuthCredential(_phoneAuthCredential);
      return _user;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> reSendOTPCode(BuildContext context) async {
    await verifyPhoneNumber(context);
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

  Future<bool?> uploadProfilePhoto(String? userId) async {
    final _uploadPath = 'users/$userId/profile_photo/$userId.png';
    try {
      await firebaseStorageService.uploadFile(
          filePath: image!.path, uploadPath: _uploadPath);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<String?> getProfilePhotoUrl(String userId) async {
    final _downloadPath = '/users/$userId/profile_photo/$userId.png';
    try {
      final _profilePhotoURL =
          await firebaseStorageService.getFileDownloadUrl(_downloadPath);
      return _profilePhotoURL;
    } catch (e) {
      debugPrint(e.toString());
      return 'false';
    }
  }

  Future<void> saveUserDataFireStore(UserModel? usermodel) async {
    await firebaseCloudFirestore.saveUserData(usermodel!);
    resendButtonState = false;
  }
}
