import 'dart:io';

import 'package:fastaval_app/services/local_storage.service.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class ConfigService {
  ConfigService._privateConstructor();
  static final ConfigService instance = ConfigService._privateConstructor();
  final LocalStorageService _localStorageService = LocalStorageService();
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  final String _kAppLang = 'APP_LANG';

  String currLang = 'en';

  void initConfig() async {
    await _remoteConfig.setDefaults(const {
      'API': 'https://infosys.fastaval.dk/api',
      'APItest': 'https://infosys-test.fastaval.dk/api'
    });
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 10),
    ));
    await _remoteConfig.fetchAndActivate();
  }

  String getRemoteConfig(String string) {
    print(_remoteConfig.getString(string));
    return _remoteConfig.getString(string);
  }

  Future<String> getCurrentLang() async {
    var langFromStorage = await _localStorageService.getString(_kAppLang);
    if (langFromStorage != '') {
      print('getting stored language: $langFromStorage');
      return langFromStorage;
    }

    Platform.localeName.startsWith('da')
        ? setCurrentLang('da')
        : setCurrentLang('en');
    print('getting new language: $currLang');
    return currLang;
  }

  setCurrentLang(String lang) {
    currLang = lang;
    _localStorageService.setString(_kAppLang, lang);
  }
}
