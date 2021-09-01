// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FriendsViewModel on _FriendsViewModelBase, Store {
  final _$isLoadingDataAtom = Atom(name: '_FriendsViewModelBase.isLoadingData');

  @override
  bool get isLoadingData {
    _$isLoadingDataAtom.reportRead();
    return super.isLoadingData;
  }

  @override
  set isLoadingData(bool value) {
    _$isLoadingDataAtom.reportWrite(value, super.isLoadingData, () {
      super.isLoadingData = value;
    });
  }

  final _$friendsListAtom = Atom(name: '_FriendsViewModelBase.friendsList');

  @override
  List<UserModel?>? get friendsList {
    _$friendsListAtom.reportRead();
    return super.friendsList;
  }

  @override
  set friendsList(List<UserModel?>? value) {
    _$friendsListAtom.reportWrite(value, super.friendsList, () {
      super.friendsList = value;
    });
  }

  @override
  String toString() {
    return '''
isLoadingData: ${isLoadingData},
friendsList: ${friendsList}
    ''';
  }
}
