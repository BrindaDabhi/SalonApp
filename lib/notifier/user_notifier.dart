import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_salon/model/user_model.dart';

class UserNotifier with ChangeNotifier {
  List<UserModel> _userList = [];
  UserModel? _currentUser;

  UnmodifiableListView<UserModel> get userList =>
      UnmodifiableListView(_userList);

  UserModel get currentUser => _currentUser!;

  set userList(List<UserModel> userList) {
    _userList = userList;
    notifyListeners();
  }

  set currentUser(UserModel userModel) {
    _currentUser = userModel;
    notifyListeners();
  }
}

getUsers(UserNotifier userNotifier) async {
  var snapshot = await FirebaseFirestore.instance.collection('Users').get();

  List<UserModel> _userList = [];

  snapshot.docs.forEach((element) {
    UserModel userModel = UserModel.fromJson(element.data());
    _userList.add(userModel);
  });

  userNotifier.userList = _userList;
}
