import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../product/service/firebase/firebase_authentication.dart';
import '../../../product/service/firebase/firebase_cloudfirestore.dart';
import '../model/user_model.dart';

part 'auth_view_model.g.dart';

class AuthViewModel = _AuthViewModelBase with _$AuthViewModel;

abstract class _AuthViewModelBase with Store {
  final formKeyLogin = GlobalKey<FormState>();

  final formKeyRegister = GlobalKey<FormState>();

  FirebaseAuthService firebaseAuthService = FirebaseAuthService.instance;

  FirebaseCloudFirestore firebaseCloudFirestore =
      FirebaseCloudFirestore.instance;

  TextEditingController inputEmailController = TextEditingController();

  TextEditingController inputPasswordController = TextEditingController();

  TextEditingController inputNameController = TextEditingController();

  TextEditingController inputSurnameController = TextEditingController();

  TextEditingController inputImagePathController = TextEditingController();

  UserModel userModel = UserModel();
}
