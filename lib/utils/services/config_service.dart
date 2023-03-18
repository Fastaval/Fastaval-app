import 'dart:convert';

import 'package:fastaval_app/constants/app_constants.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class ConfigService {
  //Define default values
  final String _defaultAppTitle = "App Title";
  final String _defaultBackgroundColor = "#000";

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  // Fetching, caching, and activating remote config
  void initConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      // cache refresh time
      fetchTimeout: const Duration(seconds: 1),
      // a fetch will wait up to 10 seconds before timing out
      minimumFetchInterval: const Duration(seconds: 10),
    ));
    await _remoteConfig.fetchAndActivate();
  }

  String getUrlFromConfig() {
    return _remoteConfig.getString("API");
  }
}
