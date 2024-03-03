import 'dart:convert';

import 'package:fastaval_app/constants/app.constant.dart';
import 'package:fastaval_app/models/boardgame.model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BoardGameController extends GetxController {
  RxList boardgameList = [].obs;
  RxList filteredList = [].obs;
  var listUpdatedAt = 0.obs;

  init() {
    getBoardGames();
  }

  getBoardGames() {
    fetchBoardgames().then((gamesList) {
      print('fetched ${gamesList.length} boardgames');
      _updateBoardgameList(gamesList);
    });
  }

  _updateBoardgameList(List<Boardgame> gamesList) {
    boardgameList.value = gamesList;
    listUpdatedAt.value =
        (DateTime.now().millisecondsSinceEpoch / 1000).round();
    applyFilterToList();
  }

  applyFilterToList([String? filter]) {
    filteredList.value = filter == null
        ? boardgameList
        : boardgameList
            .where((game) =>
                game.name.toLowerCase().contains(filter.toLowerCase()))
            .toList();
  }
}

Future<List<Boardgame>> fetchBoardgames() async {
  var response = await http.get(Uri.parse('$baseUrl/v1/boardgames'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((game) => Boardgame.fromJson(game))
        .toList();
  }

  throw Exception('Failed to load boardgames');
}