import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../product/constants/navigation_constants.dart';
import '../../../product/service/navigation/navigation_service.dart';
import '../../auth/viewmodel/auth_view_model.dart';
import '../viewmodel/friends_viewmodel.dart';
import 'components/friend_card.dart';

class FriendsView extends StatelessWidget {
  FriendsView({Key? key}) : super(key: key);

  final _userVM = FriendsViewModel();
  final _authVM = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBodyObserver,
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Friends'),
      centerTitle: true,
      actions: [
        buildAppBarAddNewFriendButton(context),
      ],
      leading: SizedBox(),
    );
  }

  IconButton buildAppBarAddNewFriendButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => buildAddNewFriendAlertDialog,
        );
      },
      icon: Icon(Icons.add),
    );
  }

  AlertDialog get buildAddNewFriendAlertDialog {
    return AlertDialog(
      title: Text('Add Friends'),
      content: buildTextFieldAddNewFriendEmail,
      actions: [
        buildAddNewFriendsButtonInDialog,
      ],
    );
  }

  TextField get buildTextFieldAddNewFriendEmail {
    return TextField(
      controller: _authVM.inputEmailController,
      decoration: InputDecoration(hintText: 'Email'),
    );
  }

  TextButton get buildAddNewFriendsButtonInDialog {
    return TextButton(
      onPressed: addNewFriendFunction,
      child: Text('Add friend'),
    );
  }

  Future<void> addNewFriendFunction() async {
    await _userVM.firebaseCloudFireStore
        .addFriends(_authVM.inputEmailController.text);
    NavigationService.instance.navigateToPop();
    await _userVM.getFriendsData();
  }

  Observer get buildBodyObserver {
    return Observer(
      builder: (_) {
        return _userVM.isLoadingData
            ? buildLoadingIndicator
            : buildFriendsBodyColumn;
      },
    );
  }

  Center get buildLoadingIndicator =>
      Center(child: CircularProgressIndicator.adaptive());

  Column get buildFriendsBodyColumn {
    return Column(
      children: [
        Expanded(
          child: buildFriendsCardBuilder,
        ),
      ],
    );
  }

  ListView get buildFriendsCardBuilder {
    return ListView.builder(
      itemCount: _userVM.friendsList?.length ?? 0,
      itemBuilder: (context, index) => buildFriendsCardObserver(index),
    );
  }

  Observer buildFriendsCardObserver(int index) {
    return Observer(builder: (_) {
      return _authVM.firebaseAuthService.auth.currentUser!.uid ==
              _userVM.friendsList?[index]?.userid
          ? buildEmptyWidget
          : buildFriendCardTappableWidget(index);
    });
  }

  SizedBox get buildEmptyWidget => SizedBox();

  InkWell buildFriendCardTappableWidget(int index) {
    return InkWell(
      onTap: () => NavigationService.instance.navigateToPage(
          path: NavigationConstants.CHAT,
          data: _userVM.friendsList?[index] ?? []),
      child: FriendCard(
        name: _userVM.friendsList?[index]?.name,
        surname: _userVM.friendsList?[index]?.surname,
        imageUrl: _userVM.friendsList?[index]?.imageUrl,
      ),
    );
  }
}
