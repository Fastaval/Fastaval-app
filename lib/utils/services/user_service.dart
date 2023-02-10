import 'dart:convert';

import '../../config/models/user.dart';
import 'local_storage_service.dart';

class UserService {
  static const String kUserKey = 'USER_KEY';
  final LocalStorageService storage = LocalStorageService();

  Future<User> getUser() async {
    String userString = await storage.getString(kUserKey);
    try {
      return Future.value(User.fromJson(jsonDecode(userString)));
    } catch (error) {
      return Future.error(error);
    }
  }

  void setUser(User user) {
    String userString = jsonEncode(user);
    storage.setString(kUserKey, userString);
  }

  //Future<bool?> hasBarcode() async {
  //  User user = await getUser();
  //  return user.barcode?.isNotEmpty;
  // }
}
