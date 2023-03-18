import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:fastaval_app/utils/services/config_service.dart';
import 'package:http/http.dart' as http;

import '../../config/models/user.dart';
import 'local_storage_service.dart';

final String baseUrl = ConfigService().getUrlFromConfig();

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
    storageService.deleteString(kUserKey);
  }
}

Future<User> checkUserLogin(String userId, String password) async {
  var response =
      await http.get(Uri.parse('$baseUrl/v3/user/$userId?pass=$password'));

  inspect(response);

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  }

  throw Exception('Failed to load login');
  //TODO: Vis fejl hvis login fejler
}

Future sendFCMTokenToInfosys(String userId, String token) async {
  var response = await http.post(Uri.parse('$baseUrl/v3/user/$userId/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'gcm_id': token,
      }));

  inspect(response);

  if (response.statusCode == 200) {
    print(response);
    return;
  }
  throw Exception('Failed to load login');
  //TODO: Vis fejl hvis login fejler
}
