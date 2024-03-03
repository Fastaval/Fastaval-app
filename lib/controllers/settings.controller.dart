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

  init() async {
    String foundLanguage = await storageService.getString(kLangKey);
    if (foundLanguage.isEmpty) {
      var defaultLang = Get.deviceLocale!.languageCode;
      updateLanguage(defaultLang);
      return Locale(defaultLang);
    }
    language(foundLanguage);
    return Locale(foundLanguage);
  }
}
