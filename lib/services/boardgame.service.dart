import 'dart:convert';

import 'package:fastaval_app/constants/app.constant.dart';
import 'package:fastaval_app/models/boardgame.model.dart';
import 'package:http/http.dart' as http;

Future<List<Boardgame>> fetchBoardgames() async {
  var response = await http.get(Uri.parse('$baseUrl/v1/boardgames'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((game) => Boardgame.fromJson(game))
        .toList();
  }

  throw Exception('Failed to load boardgames');
}
