import 'dart:async';
import 'dart:convert';

import '../../config/models/user.dart';
import 'local_storage_service.dart';

class UserService {
  static const String kUserKey = 'USER_KEY';
  final LocalStorageService storageService = LocalStorageService();

  Future<User> getUser() async {
    String userString = await storageService.getString(kUserKey);
    try {
      return Future.value(User.fromJson(jsonDecode(userString)));
    } catch (error) {
      return Future.error(error);
    }
  }

  setUser(User user) {
    String userString = jsonEncode(user);
    storageService.setString(kUserKey, userString);
  }

  removeUser() {
    storageService.setString(kUserKey, '');
  }

  //Future<bool?> hasBarcode() async {
  //  User user = await getUser();
  //  return user.barcode?.isNotEmpty;
  // }
}
