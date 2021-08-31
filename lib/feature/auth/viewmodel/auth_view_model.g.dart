// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthViewModel on _AuthViewModelBase, Store {
  final _$inputEmailControllerAtom =
      Atom(name: '_AuthViewModelBase.inputEmailController');

  @override
  TextEditingController get inputEmailController {
    _$inputEmailControllerAtom.reportRead();
    return super.inputEmailController;
  }

  @override
  set inputEmailController(TextEditingController value) {
    _$inputEmailControllerAtom.reportWrite(value, super.inputEmailController,
        () {
      super.inputEmailController = value;
    });
  }

  final _$inputPasswordControllerAtom =
      Atom(name: '_AuthViewModelBase.inputPasswordController');

  @override
  TextEditingController get inputPasswordController {
    _$inputPasswordControllerAtom.reportRead();
    return super.inputPasswordController;
  }

  @override
  set inputPasswordController(TextEditingController value) {
    _$inputPasswordControllerAtom
        .reportWrite(value, super.inputPasswordController, () {
      super.inputPasswordController = value;
    });
  }

  final _$inputNameControllerAtom =
      Atom(name: '_AuthViewModelBase.inputNameController');

  @override
  TextEditingController get inputNameController {
    _$inputNameControllerAtom.reportRead();
    return super.inputNameController;
  }

  @override
  set inputNameController(TextEditingController value) {
    _$inputNameControllerAtom.reportWrite(value, super.inputNameController, () {
      super.inputNameController = value;
    });
  }

  final _$inputSurnameControllerAtom =
      Atom(name: '_AuthViewModelBase.inputSurnameController');

  @override
  TextEditingController get inputSurnameController {
    _$inputSurnameControllerAtom.reportRead();
    return super.inputSurnameController;
  }

  @override
  set inputSurnameController(TextEditingController value) {
    _$inputSurnameControllerAtom
        .reportWrite(value, super.inputSurnameController, () {
      super.inputSurnameController = value;
    });
  }

  final _$inputImagePathControllerAtom =
      Atom(name: '_AuthViewModelBase.inputImagePathController');

  @override
  TextEditingController get inputImagePathController {
    _$inputImagePathControllerAtom.reportRead();
    return super.inputImagePathController;
  }

  @override
  set inputImagePathController(TextEditingController value) {
    _$inputImagePathControllerAtom
        .reportWrite(value, super.inputImagePathController, () {
      super.inputImagePathController = value;
    });
  }

  final _$userModelAtom = Atom(name: '_AuthViewModelBase.userModel');

  @override
  UserModel get userModel {
    _$userModelAtom.reportRead();
    return super.userModel;
  }

  @override
  set userModel(UserModel value) {
    _$userModelAtom.reportWrite(value, super.userModel, () {
      super.userModel = value;
    });
  }

  @override
  String toString() {
    return '''
inputEmailController: ${inputEmailController},
inputPasswordController: ${inputPasswordController},
inputNameController: ${inputNameController},
inputSurnameController: ${inputSurnameController},
inputImagePathController: ${inputImagePathController},
userModel: ${userModel}
    ''';
  }
}
