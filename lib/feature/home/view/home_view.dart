import 'package:flutter/material.dart';

import '../../auth/viewmodel/auth_view_model.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final _authVM = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          //StoriesWidget(),
        ]),
      ),
    );
  }
}
