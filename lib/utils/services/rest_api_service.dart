import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:fastaval_app/utils/services/user_service.dart';
import 'package:fastaval_app/config/models/program.dart';
import 'package:fastaval_app/config/models/user.dart';

const String baseUrl = 'https://infosys-test.fastaval.dk/api';

Future<Program> fetchProgram() async {
  var url = Uri.parse('$baseUrl/app/v3/activities/*');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    var program = Program.fromJson(jsonDecode(response.body));

    return program;
  } else {
    throw Exception('Failed to load program');
  }
}

Future<User> login(String userId, String password) async {
  final UserService userService = UserService();

  var url = Uri.parse('$baseUrl/v3/user/$userId?pass=$password');
  final response = await http.get(url);
  inspect(response);

  if (response.statusCode == 200) {
    var user = User.fromJson(jsonDecode(response.body));

    userService.setUser(user);

    return user;
  } else {
    throw Exception('Failed to load login');
    //TODO:fix fejl
  }
}
