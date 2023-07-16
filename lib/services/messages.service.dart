import 'dart:convert';

import 'package:fastaval_app/constants/app.constant.dart';
import 'package:fastaval_app/models/notification.model.dart';
import 'package:fastaval_app/models/user.model.dart';
import 'package:fastaval_app/services/user.service.dart';
import 'package:http/http.dart' as http;

Future<List<InfosysNotification>> fetchNotifications() async {
  User user = await UserService().getUser();
  var response = await http
      .get(Uri.parse('$baseUrl/messages/${user.id}?pass=${user.password}'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => InfosysNotification.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to get messages');
  }
}
