import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

import '../../../calls/view/calls_view.dart';
import '../../../friends/view/friends_view.dart';
import '../../../home/view/home_view.dart';

part 'tab_viewmodel.g.dart';

class TabViewModel = _TabViewModelBase with _$TabViewModel;

enum TabViewEnum {
  HOME,
  FRIENDS,
  CALLS,
}

abstract class _TabViewModelBase with Store {
  final List<MapEntry<TabViewEnum, Widget>> pageList = [
    MapEntry(TabViewEnum.HOME, HomeView()),
    MapEntry(TabViewEnum.FRIENDS, FriendsView()),
    MapEntry(TabViewEnum.CALLS, CallsView())
  ];

  @observable
  int selectedNavBarItem = 0;

  final pageController = PageController(initialPage: 0);

  final List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.child_friendly_sharp), label: 'Friends'),
    BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Calls'),
  ];
}
