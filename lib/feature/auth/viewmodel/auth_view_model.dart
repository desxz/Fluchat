import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../product/service/firebase/firebase_authentication.dart';
import '../../../product/service/firebase/firebase_cloudfirestore.dart';
import '../model/user_model.dart';
import '../view/verification_view.dart';

part 'auth_view_model.g.dart';

class AuthViewModel = _AuthViewModelBase with _$AuthViewModel;

abstract class _AuthViewModelBase with Store {
  FirebaseAuthService get firebaseAuthService => FirebaseAuthService.instance;

  FirebaseCloudFirestore get firebaseCloudFirestore =>
      FirebaseCloudFirestore.instance;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController inputPhoneNumberController = TextEditingController();

  TextEditingController inputVerificationIdController = TextEditingController();

  TextEditingController inputNameController = TextEditingController();

  TextEditingController inputSurnameController = TextEditingController();

  TextEditingController inputImagePathController = TextEditingController();

  UserModel userModel = UserModel();

  @observable
  var isLoadingVerification = false;

  String? verifyId;

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
        isLoadingVerification = false;
      },
      (verificationId) {
        isLoadingVerification = false;
      },
      Duration(seconds: 90),
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
}
