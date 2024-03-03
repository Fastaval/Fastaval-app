import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();

    var valueString = prefs.getString(key);
    return Future.value(valueString ?? '');
  }

  setString(String key, String value) async {
    var preferences = await SharedPreferences.getInstance();

    preferences.setString(key, value);
  }

  deleteString(String key) async {
    var preferences = await SharedPreferences.getInstance();

    preferences.remove(key);
  }
}
