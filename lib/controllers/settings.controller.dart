import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/services/local_storage.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final LocalStorageService storageService = LocalStorageService();
  final language = 'en'.obs;
  final kLangKey = 'LANG_KEY';
  BuildContext? appContext;

  updateLanguage(String name) {
    storageService.setString(kLangKey, name);
    language(name);
    Get.updateLocale(Locale(name));
    if (appContext != null) {
      appContext!.setLocale(Locale(name));
    }
  }

  init() async {
    String foundLanguage = await storageService.getString(kLangKey);
    if (foundLanguage.isEmpty) {
      var defaultLang = Get.deviceLocale!.languageCode == 'da' ? 'da' : 'en';
      updateLanguage(defaultLang);
      return Locale(defaultLang);
    }

    language(foundLanguage);
    return Locale(foundLanguage);
  }

  setContext(BuildContext context) {
    appContext = context;
  }
}
