import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../product/service/firebase/firebase_authentication.dart';
import '../../../product/service/firebase/firebase_cloudfirestore.dart';
import '../../auth/model/user_model.dart';

part 'friends_viewmodel.g.dart';

class FriendsViewModel = _FriendsViewModelBase with _$FriendsViewModel;

abstract class _FriendsViewModelBase with Store {
  _FriendsViewModelBase() {
    addNewFriendFunction();
  }

  final firebaseCloudFireStore = FirebaseCloudFirestore.instance;

  final firebaseAuthService = FirebaseAuthService.instance;

  final inputPhoneNumberController = TextEditingController();

  @observable
  bool isLoadingData = false;

  @observable
  List<UserModel?>? friendsList = [];

  var _contacts;

  Future<void> fetchContacts() async {
    if (await Permission.contacts.status.isGranted) {
      Iterable<Contact> contacts = await ContactsService.getContacts();
      _contacts = contacts;
      print(_contacts.toString());
      debugPrint('Girdi 1');
    } else {
      debugPrint('PERMISSION ERROR');
    }
  }

  Future<void> addNewFriendFunction() async {
    isLoadingData = true;
    await fetchContacts();
    debugPrint('Girdi 2');
    await firebaseCloudFireStore.addFriendsFromPhoneDrirectory(_contacts);
    debugPrint('Girdi 3');
    await getFriendsData();
    debugPrint('Girdi 4');
    isLoadingData = false;
  }

  Future<void> getFriendsData() async {
    friendsList = await firebaseCloudFireStore.fetchFriendsData();
  }
}
