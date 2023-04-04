import 'dart:convert';

import 'package:fastaval_app/constants/app_constants.dart';
import 'package:http/http.dart' as http;

import '../../config/models/boardgame.dart';

Future<List<BoardGame>> fetchBoardGames() async {
  var response = await http.get(Uri.parse('$baseUrl/v1/boardgames'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List).map((game) => BoardGame.fromJson(game)).toList();
  }

  throw Exception('Failed to load boardgames');
}
