import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/utils/services/config_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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

  registerToInfosys(BuildContext context, User user) {
    registerAppToInfosys(context, user);
  }
}

Future<void> registerAppToInfosys(BuildContext context, User user) async {
  String? title = tr('login.alert.title');
  String? description = tr('login.alert.description');
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, textScaleFactor: 1),
          content: Text(description, textScaleFactor: 1),
          actions: <Widget>[
            TextButton(
                child: Text(tr('login.alert.dialogNo')),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            ElevatedButton(
                child: Text(tr('login.alert.dialogYes')),
                onPressed: () {
                  sendFCMTokenToInfosys(user.id!);
                  Navigator.of(context).pop();
                }),
          ],
        );
      });
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

Future<void> sendFCMTokenToInfosys(int userId) async {
  String token = await getDeviceToken();
  var response = await http.post(Uri.parse('$baseUrl/user/$userId/register'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'gcm_id': token}));

  inspect(response);

  if (response.statusCode == 200) {
    print(response.body);
    return;
  }
  throw Exception('Failed to register app with infosys');
  //TODO: Vis fejl hvis registering ikke lykkesede
}

//get device token to use for push notification
Future<String> getDeviceToken() async {
  //request user permission for push notification
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  await firebaseMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  String? deviceToken = await firebaseMessaging.getToken();
  return (deviceToken == null) ? "" : deviceToken;
}
