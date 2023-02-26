import 'dart:convert';

import 'package:fastaval_app/config/models/program.dart';
import 'package:fastaval_app/constants/app_constants.dart';
import 'package:http/http.dart' as http;

Future<Program> fetchProgram() async {
  var response = await http.get(Uri.parse('$baseUrl/app/v3/activities/*'));

  if (response.statusCode == 200) {
    return Program.fromJson(jsonDecode(response.body));
  }

  throw Exception('Failed to load program');
}
