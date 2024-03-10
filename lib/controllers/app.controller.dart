import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/models/user.model.dart';
import 'package:fastaval_app/services/local_storage.service.dart';
import 'package:fastaval_app/services/user.service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  final LocalStorageService storageService = LocalStorageService();
  final loggedIn = false.obs;
  final navIndex = 1.obs;
  late User user;
  final userUpdateTime = 0.obs;

  updateLoggedIn(bool status) {
    loggedIn(status);
  }

  updateNavIndex(int index) {
    navIndex(index);
  }

  updateUser(User newUser) {
    user = newUser;
    userUpdateTime((DateTime.now().millisecondsSinceEpoch / 1000).round());
  }

  init() async {
    await getUserDetails();
  }

  Future getUserDetails() async {
    await UserService().getUser().then((newUser) => {
          if (newUser != null) {updateUser(newUser), updateLoggedIn(true)}
        });
  }

  login(String id, String password) {
    fetchUser(id, password)
        .then((newUser) => scheduleMicrotask(() {
              newUser.password = password;
              updateUser(newUser);
              updateLoggedIn(true);
              UserService().setUser(newUser);
              UserService().registerToInfosys(newUser);
              updateNavIndex(0);
            }))
        .onError((error, stackTrace) =>
            Fluttertoast.showToast(msg: tr('error.login')));
  }

  logout() {
    UserService().removeUser();
    user.id = 0;
    user.password = '';
    loggedIn(false);
    updateNavIndex(0);
    Fluttertoast.showToast(msg: tr('logout.message'));
  }
}
