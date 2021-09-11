// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthViewModel on _AuthViewModelBase, Store {
  final _$isLoadingVerificationAtom =
      Atom(name: '_AuthViewModelBase.isLoadingVerification');

  @override
  bool get isLoadingVerification {
    _$isLoadingVerificationAtom.reportRead();
    return super.isLoadingVerification;
  }

  @override
  set isLoadingVerification(bool value) {
    _$isLoadingVerificationAtom.reportWrite(value, super.isLoadingVerification,
        () {
      super.isLoadingVerification = value;
    });
  }

  final _$isLoadingUploadDataAtom =
      Atom(name: '_AuthViewModelBase.isLoadingUploadData');

  @override
  bool get isLoadingUploadData {
    _$isLoadingUploadDataAtom.reportRead();
    return super.isLoadingUploadData;
  }

  @override
  set isLoadingUploadData(bool value) {
    _$isLoadingUploadDataAtom.reportWrite(value, super.isLoadingUploadData, () {
      super.isLoadingUploadData = value;
    });
  }

  final _$resendButtonStateAtom =
      Atom(name: '_AuthViewModelBase.resendButtonState');

  @override
  bool get resendButtonState {
    _$resendButtonStateAtom.reportRead();
    return super.resendButtonState;
  }

  @override
  set resendButtonState(bool value) {
    _$resendButtonStateAtom.reportWrite(value, super.resendButtonState, () {
      super.resendButtonState = value;
    });
  }

  final _$timeOTPConfirmDurationAtom =
      Atom(name: '_AuthViewModelBase.timeOTPConfirmDuration');

  @override
  int get timeOTPConfirmDuration {
    _$timeOTPConfirmDurationAtom.reportRead();
    return super.timeOTPConfirmDuration;
  }

  @override
  set timeOTPConfirmDuration(int value) {
    _$timeOTPConfirmDurationAtom
        .reportWrite(value, super.timeOTPConfirmDuration, () {
      super.timeOTPConfirmDuration = value;
    });
  }

  final _$imageAtom = Atom(name: '_AuthViewModelBase.image');

  @override
  File? get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(File? value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$userModelAtom = Atom(name: '_AuthViewModelBase.userModel');

  @override
  UserModel? get userModel {
    _$userModelAtom.reportRead();
    return super.userModel;
  }

  @override
  set userModel(UserModel? value) {
    _$userModelAtom.reportWrite(value, super.userModel, () {
      super.userModel = value;
    });
  }

  final _$currentStateAtom = Atom(name: '_AuthViewModelBase.currentState');

  @override
  VerificationState get currentState {
    _$currentStateAtom.reportRead();
    return super.currentState;
  }

  @override
  set currentState(VerificationState value) {
    _$currentStateAtom.reportWrite(value, super.currentState, () {
      super.currentState = value;
    });
  }

  @override
  String toString() {
    return '''
isLoadingVerification: ${isLoadingVerification},
isLoadingUploadData: ${isLoadingUploadData},
resendButtonState: ${resendButtonState},
timeOTPConfirmDuration: ${timeOTPConfirmDuration},
image: ${image},
userModel: ${userModel},
currentState: ${currentState}
    ''';
  }
}
