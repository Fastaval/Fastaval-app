import 'dart:convert';

import 'package:fastaval_app/config/models/message.dart';
import 'package:fastaval_app/config/models/user.dart';
import 'package:fastaval_app/constants/app_constants.dart';
import 'package:fastaval_app/utils/services/user_service.dart';
import 'package:http/http.dart' as http;

Future<List<Message>> fetchMessages() async {
  User user = await UserService().getUser();
  var response = await http
      .get(Uri.parse('$baseUrl/messages/${user.id}?pass=${user.password}'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => Message.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to get messages');
  }
}
