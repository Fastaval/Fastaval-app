import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();

    var valueString = prefs.getString(key);
    return Future.value(valueString);
  }

  void setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(key, value);
  }
}
