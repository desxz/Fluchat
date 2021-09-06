import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../viewmodel/tab_viewmodel.dart';

class TabView extends StatelessWidget {
  TabView({Key? key, this.user}) : super(key: key);
  final User? user;

  final _tabVM = TabViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
      ),
      bottomNavigationBar: Observer(builder: (_) {
        return BottomNavigationBar(
          items: _tabVM.bottomNavBarItems,
          currentIndex: _tabVM.selectedNavBarItem,
          onTap: (index) async {
            _tabVM.selectedNavBarItem = index;
            await _tabVM.pageController.animateToPage(_tabVM.selectedNavBarItem,
                duration: Duration(milliseconds: 300), curve: Curves.easeIn);
          },
        );
      }),
      body: SafeArea(
        child: PageView.builder(
          controller: _tabVM.pageController,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _tabVM.pageList.length,
          itemBuilder: (context, index) => _tabVM.pageList[index].value,
        ),
      ),
    );
  }
}
