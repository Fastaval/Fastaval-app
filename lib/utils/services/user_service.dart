import 'dart:convert';

import 'package:http/http.dart';

import '../../config/models/user.dart';
import 'local_storage_service.dart';

class UserService {
  final String USER_KEY = 'USER_KEY';
  final LocalStorageService storage = LocalStorageService();
  Future<User> getUser() async {
    String userString = await storage.getString(USER_KEY);
    try {
      return Future.value(User.fromJson(userString));
    } catch (error) {
      return Future.error(error);
    }
  }

  void setUser(User user) {
    String userString = jsonEncode(user.toJson());
    storage.setString(USER_KEY, userString);
  }

  Future<bool?> hasBarcode() async {
    User user = await getUser();
    return user.barcode?.isNotEmpty;
  }
}