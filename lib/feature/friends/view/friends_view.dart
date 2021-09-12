import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../product/constants/navigation_constants.dart';
import '../../../product/service/navigation/navigation_service.dart';
import '../viewmodel/friends_viewmodel.dart';
import 'components/default_functions_card.dart';
import 'components/friend_card.dart';

class FriendsView extends StatelessWidget {
  FriendsView({Key? key}) : super(key: key);

  final _friendsVM = FriendsViewModel();

  @override
  Widget build(BuildContext context) {
    return buildBodyObserver(context);
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
      controller: _friendsVM.inputPhoneNumberController,
      decoration: InputDecoration(hintText: 'Phone Number'),
    );
  }

  TextButton get buildAddNewFriendsButtonInDialog {
    return TextButton(
      onPressed: _friendsVM.inputPhoneNumberController.text ==
              _friendsVM.firebaseAuthService.auth.currentUser!.phoneNumber
          ? () {}
          : () => _friendsVM
              .addNewFriendWithPhoneNumber(
                  _friendsVM.inputPhoneNumberController.text)
              .then((value) => _friendsVM.inputPhoneNumberController.text = ''),
      child: Text('Add friend'),
    );
  }

  Observer buildBodyObserver(BuildContext context) {
    return Observer(
      builder: (_) {
        return _friendsVM.isLoadingData
            ? buildLoadingIndicator
            : buildFriendsBodyColumn(context);
      },
    );
  }

  Center get buildLoadingIndicator =>
      Center(child: CircularProgressIndicator.adaptive());

  Column buildFriendsBodyColumn(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 2,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                DefaultFunctionsCard(
                  title: Text('Add new friend'),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => buildAddNewFriendAlertDialog,
                  ),
                  leading: Icon(Icons.group_add),
                ),
                DefaultFunctionsCard(
                  title: Text('Create new group'),
                  onPressed: () {},
                  leading: Icon(Icons.group_add),
                ),
              ],
            )),
        Divider(
          height: 4,
          thickness: 1,
        ),
        Expanded(
          flex: 9,
          child: buildFriendsCardBuilder,
        ),
      ],
    );
  }

  ListView get buildFriendsCardBuilder {
    return ListView.builder(
      itemCount: _friendsVM.friendsList?.length ?? 0,
      itemBuilder: (context, index) => buildFriendsCardObserver(index),
    );
  }

  Observer buildFriendsCardObserver(int index) {
    return Observer(builder: (_) {
      return _friendsVM.firebaseAuthService.auth.currentUser!.uid ==
              _friendsVM.friendsList?[index]?.userid
          ? buildEmptyWidget
          : buildFriendCardTappableWidget(index);
    });
  }

  SizedBox get buildEmptyWidget => SizedBox();

  FriendCard buildFriendCardTappableWidget(int index) {
    return FriendCard(
      onPressed: () => NavigationService.instance.navigateToPage(
          path: NavigationConstants.CHAT, data: _friendsVM.friendsList?[index]),
      name: _friendsVM.friendsList?[index]?.nameSurname,
      imageUrl: _friendsVM.friendsList?[index]?.imageUrl,
    );
  }
}
