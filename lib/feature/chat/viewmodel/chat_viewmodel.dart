import 'package:mobx/mobx.dart';

part 'chat_viewmodel.g.dart';

class ChatViewModel = _ChatViewModelBase with _$ChatViewModel;

abstract class _ChatViewModelBase with Store {}
