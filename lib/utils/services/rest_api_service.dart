import 'dart:convert';
import 'dart:developer';

import 'package:fastaval_app/config/models/activity.dart';
import 'package:http/http.dart' as http;

import '../../config/models/program.dart';
import '../../config/models/user.dart';

const String baseUrl = 'https://infosys-test.fastaval.dk/api';

Future<Program> fetchProgram() async {
  var url = Uri.parse('$baseUrl/app/v2/activities/*');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    var program = Program.fromJson(jsonDecode(response.body));
    inspect(program);
    return program;
  } else {
    throw Exception('Failed to load program');
  }
}

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

Future<Activity> getProgram() async {
  var url = Uri.parse('$baseUrl/app/v2/activities/*');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    var activity = Activity.fromJson(jsonDecode(response.body));
    return activity;
  } else {
    throw Exception('Failed to download programs');
  }
}
