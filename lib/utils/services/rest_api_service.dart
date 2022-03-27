import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../config/models/program.dart';

const String baseUrl = 'https://infosys-test.fastaval.dk/api';

Future<Program> fetchProgram() async {
  var url = Uri.parse('$baseUrl/app/v2/activities/*');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    var user = Program.fromJson(jsonDecode(response.body));
    inspect(user);
    return user;
  } else {
    throw Exception('Failed to load program');
  }
}
