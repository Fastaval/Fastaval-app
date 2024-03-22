import 'dart:convert';

import 'package:fastaval_app/models/activity_item.model.dart';
import 'package:fastaval_app/models/program.model.dart';
import 'package:fastaval_app/services/config.service.dart';
import 'package:fastaval_app/services/local_storage.service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ActivitiesService {
  static const String kFavoritesKey = 'FAVORITES_KEY24';
  final LocalStorageService storageService = LocalStorageService();

  retrieveFavorites() async {
    String favoritesString = await storageService.getString(kFavoritesKey);
    if (favoritesString == '') return [];
    return jsonDecode(favoritesString);
  }

  storeFavorites(RxList favorites) {
    String favoritesString = jsonEncode(favorites);
    storageService.setString(kFavoritesKey, favoritesString);
  }

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
}
