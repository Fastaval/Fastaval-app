import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {

  Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return Future.value(prefs.getString(key));
  }

  void setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(key, value);
  }
}