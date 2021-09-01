import 'package:mobx/mobx.dart';

import '../../../product/service/firebase/firebase_cloudfirestore.dart';
import '../../auth/model/user_model.dart';

part 'friends_viewmodel.g.dart';

class FriendsViewModel = _FriendsViewModelBase with _$FriendsViewModel;

abstract class _FriendsViewModelBase with Store {
  _FriendsViewModelBase() {
    getFriendsData();
  }

  final firebaseCloudFireStore = FirebaseCloudFirestore.instance;

  @observable
  bool isLoadingData = false;

  @observable
  List<UserModel?>? friendsList = [];

  Future<void> getFriendsData() async {
    isLoadingData = true;
    friendsList = await firebaseCloudFireStore.fetchFriendsData();
    isLoadingData = false;
  }
}
