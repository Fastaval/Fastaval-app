import 'dart:convert';

import 'package:fastaval_app/constants/app.dart';
import 'package:fastaval_app/models/activity_item.dart';
import 'package:fastaval_app/models/program.dart';
import 'package:http/http.dart' as http;

Future<Program> fetchProgram() async {
  var response = await http.get(Uri.parse('$baseUrl/app/v3/activities/*'));

  if (response.statusCode == 200) {
    return Program.fromJson(jsonDecode(response.body));
  }

  throw Exception('Failed to load program');
}

Future<List<ActivityItem>> getDay(String isoDate) async {
  final response =
      await http.get(Uri.parse('$baseUrl/app/v3/activities/$isoDate'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => ActivityItem.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to download programs');
  }
}
