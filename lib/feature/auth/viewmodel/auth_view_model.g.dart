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
currentState: ${currentState}
    ''';
  }
}
