import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../config/models/user.dart';

const String baseUrl = 'https://infosys-test.fastaval.dk/api';

Future<User> login(String userId, String password) async {
  var url = Uri.parse('$baseUrl/user/$userId?pass=$password');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    var user = User.fromJson(jsonDecode(response.body));
    inspect(user);
    return user;
  } else {
    throw Exception('Failed to load login');
  }
}
