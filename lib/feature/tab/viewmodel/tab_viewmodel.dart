import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../chat/view/chat_view.dart';
import '../../friends/view/friends_view.dart';

part 'tab_viewmodel.g.dart';

class TabViewModel = _TabViewModelBase with _$TabViewModel;

abstract class _TabViewModelBase with Store {
  @observable
  int? initPage = 0;

  @observable
  List<Widget> pageList = [ChatView(), FriendsView()];

  final pageController = PageController(initialPage: 0);
}
