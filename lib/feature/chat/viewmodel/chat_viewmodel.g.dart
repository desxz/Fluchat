// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatViewModel on _ChatViewModelBase, Store {
  final _$messagesAtom = Atom(name: '_ChatViewModelBase.messages');

  @override
  Map<String, List<MessageModel>> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(Map<String, List<MessageModel>> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  final _$emojiStateAtom = Atom(name: '_ChatViewModelBase.emojiState');

  @override
  bool get emojiState {
    _$emojiStateAtom.reportRead();
    return super.emojiState;
  }

  @override
  set emojiState(bool value) {
    _$emojiStateAtom.reportWrite(value, super.emojiState, () {
      super.emojiState = value;
    });
  }

  final _$imageAtom = Atom(name: '_ChatViewModelBase.image');

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

  @override
  String toString() {
    return '''
messages: ${messages},
emojiState: ${emojiState},
image: ${image}
    ''';
  }
}
