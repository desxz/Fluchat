import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../product/service/firebase/firebase_cloudfirestore.dart';
import '../../../product/service/navigation/navigation_service.dart';
import '../../auth/model/user_model.dart';

part 'friends_viewmodel.g.dart';

class FriendsViewModel = _FriendsViewModelBase with _$FriendsViewModel;

abstract class _FriendsViewModelBase with Store {
  _FriendsViewModelBase() {
    getFriendsData();
  }

  final firebaseCloudFireStore = FirebaseCloudFirestore.instance;

  final inputEmailController = TextEditingController();

  @observable
  bool isLoadingData = false;

  @observable
  List<UserModel?>? friendsList = [];

  Future<void> addNewFriendFunction() async {
    await firebaseCloudFireStore.addFriends(inputEmailController.text);
    NavigationService.instance.navigateToPop();
    await getFriendsData();
  }

  Future<void> getFriendsData() async {
    isLoadingData = true;
    friendsList = await firebaseCloudFireStore.fetchFriendsData();
    isLoadingData = false;
  }
}
