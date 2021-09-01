import 'package:flutter/material.dart';

import '../../chat/view/chat_view.dart';
import '../../friends/view/friends_view.dart';
import '../viewmodel/tab_viewmodel.dart';

class TabView extends StatelessWidget {
  TabView({Key? key}) : super(key: key);

  final _tabVM = TabViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home)),
        BottomNavigationBarItem(icon: Icon(Icons.child_friendly_sharp)),
      ]),
      body: PageView(
        controller: _tabVM.pageController,
        children: [
          ChatView(),
          FriendsView(),
        ],
      ),
    );
  }
}
