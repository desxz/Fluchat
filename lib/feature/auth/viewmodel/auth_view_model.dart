import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../product/service/firebase/firebase_authentication.dart';
import '../../../product/service/firebase/firebase_cloudfirestore.dart';
import '../model/user_model.dart';

part 'auth_view_model.g.dart';

class AuthViewModel = _AuthViewModelBase with _$AuthViewModel;

abstract class _AuthViewModelBase with Store {
  @observable
  TextEditingController inputEmailController = TextEditingController();

  @observable
  TextEditingController inputPasswordController = TextEditingController();

  @observable
  TextEditingController inputNameController = TextEditingController();

  @observable
  TextEditingController inputSurnameController = TextEditingController();

  @observable
  TextEditingController inputImagePathController = TextEditingController();

  @observable
  UserModel userModel = UserModel();

  final formKeyLogin = GlobalKey<FormState>();

  final formKeyRegister = GlobalKey<FormState>();

  final FirebaseAuthService firebaseAuthService = FirebaseAuthService.instance;
  final FirebaseCloudFirestore firebaseCloudFirestore =
      FirebaseCloudFirestore.instance;
}
