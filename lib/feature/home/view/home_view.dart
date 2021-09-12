import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../product/constants/navigation_constants.dart';
import '../../../product/service/navigation/navigation_service.dart';
import '../../auth/model/user_model.dart';
import '../viewmodel/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final _homeVM = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return buildStreamBuilderBody();
  }

  StreamBuilder<QuerySnapshot<Object?>> buildStreamBuilderBody() {
    return StreamBuilder<QuerySnapshot>(
      stream: _homeVM.rooms,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return buildErrorWidget();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildLoadingIndicator();
        }

        if (snapshot.hasData) {
          _homeVM.getSnapshotData(snapshot);
        }

        return buildRoomListBuilder();
      },
    );
  }

  Center buildErrorWidget() => Center(child: Text('Something went wrong!'));

  Center buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }

  Observer buildRoomListBuilder() {
    return Observer(builder: (_) {
      return ListView.builder(
        itemCount: _homeVM.chatRoomList.length,
        itemBuilder: (context, index) => buildChatRoomCard(index),
      );
    });
  }

  InkWell buildChatRoomCard(int index) {
    return InkWell(
      onTap: () {
        NavigationService.instance.navigateToPage(
            path: NavigationConstants.CHAT,
            data: _homeVM.chatRoomList[index].users![0]!['userid']! ==
                    _homeVM.currentUserId!
                ? UserModel().fromJson(_homeVM.chatRoomList[index].users![1]!)
                : UserModel().fromJson(_homeVM.chatRoomList[index].users![0]!));
      },
      child: ListTile(
        title: Text(_homeVM.chatRoomList[index].users![0]!['userid']! ==
                _homeVM.currentUserId!
            ? _homeVM.chatRoomList[index].users![1]!['nameSurname']!
            : _homeVM.chatRoomList[index].users![0]!['nameSurname']!),
      ),
    );
  }
}
