// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  final _$chatRoomListAtom = Atom(name: '_HomeViewModelBase.chatRoomList');

  @override
  List<ChatRoom> get chatRoomList {
    _$chatRoomListAtom.reportRead();
    return super.chatRoomList;
  }

  @override
  set chatRoomList(List<ChatRoom> value) {
    _$chatRoomListAtom.reportWrite(value, super.chatRoomList, () {
      super.chatRoomList = value;
    });
  }

  final _$isLoadingDataAtom = Atom(name: '_HomeViewModelBase.isLoadingData');

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

  final _$_HomeViewModelBaseActionController =
      ActionController(name: '_HomeViewModelBase');

  @override
  void getRoomStream() {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.getRoomStream');
    try {
      return super.getRoomStream();
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
chatRoomList: ${chatRoomList},
isLoadingData: ${isLoadingData}
    ''';
  }
}
