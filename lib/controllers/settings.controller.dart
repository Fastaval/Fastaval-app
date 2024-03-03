import 'package:fastaval_app/services/local_storage.service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final LocalStorageService storageService = LocalStorageService();
  final storeName = 'Settings';
  final language = 'en'.obs;
  final kLangKey = 'LANG_KEY';

  updateLanguage(String name) {
    language(name);
    Get.updateLocale(Locale(name));
    storageService.setString(kLangKey, name);
  }

  Future<Locale> initLanguage() async {
    String foundLanguage = await storageService.getString(kLangKey);
    if (foundLanguage.isEmpty) {
      print('No language found, setting to default: ${language.value}');
      return Locale(language.value);
    }
    print('Language found: $foundLanguage');
    language(foundLanguage);
    return Locale(foundLanguage);
  }
}
