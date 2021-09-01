import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../product/constants/navigation_constants.dart';
import '../../../product/service/navigation/navigation_service.dart';
import '../../auth/viewmodel/auth_view_model.dart';
import '../viewmodel/friends_viewmodel.dart';

class FriendsView extends StatelessWidget {
  FriendsView({Key? key, required this.user}) : super(key: key);
  final User user;

  final _userVM = FriendsViewModel();
  final _authVM = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Add Friends'),
                  content: TextField(
                    controller: _authVM.inputEmailController,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await _userVM.firebaseCloudFireStore
                            .addFriends(_authVM.inputEmailController.text);
                        NavigationService.instance.navigateToPop();
                        await _userVM.getFriendsData();
                      },
                      child: Text('Add friend'),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
        leading: SizedBox(),
      ),
      body: Observer(
        builder: (_) {
          return _userVM.isLoadingData
              ? Center(child: CircularProgressIndicator.adaptive())
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _userVM.friendsList?.length ?? 0,
                        itemBuilder: (context, index) => Observer(builder: (_) {
                          return _authVM.firebaseAuthService.auth.currentUser!
                                      .uid ==
                                  _userVM.friendsList?[index]?.userid
                              ? SizedBox()
                              : InkWell(
                                  onTap: () => NavigationService.instance
                                      .navigateToPage(
                                          path: NavigationConstants.CHAT,
                                          data: _userVM.friendsList?[index] ??
                                              []),
                                  child: ListTile(
                                    title: Text(
                                        _userVM.friendsList?[index]?.name ??
                                            'Text'),
                                    subtitle: Text(
                                        _userVM.friendsList?[index]?.surname ??
                                            'Text'),
                                    leading: CircleAvatar(
                                      radius: 36,
                                      child: CachedNetworkImage(
                                          imageUrl: _userVM.friendsList?[index]
                                                  ?.imageUrl ??
                                              'Text'),
                                    ),
                                  ),
                                );
                        }),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
