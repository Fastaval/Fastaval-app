import 'package:firebase_remote_config/firebase_remote_config.dart';

class ConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  void initConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 10),
    ));
    await _remoteConfig.fetchAndActivate();
  }

  String getUrlFromConfig() {
    return _remoteConfig.getString("API");
  }
}
