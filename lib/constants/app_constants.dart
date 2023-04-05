import 'package:fastaval_app/utils/services/config_service.dart';

final String baseUrl = ConfigService().getRemoteConfig('API');

const kWifiNetworkName = 'SNET';
const kWifiUser = 'mfg-guest@mf-gym.dk';
const kWifiPassword = 'Fjernvarme2022';
const kTaxi1PhoneNumber = "+4598525354";
const kTaxi2PhoneNumber = "+4598512300";
const kHeroForcePhoneNumber = "+4593899062";
const kDutyGeneralPhoneNumber = "+4593899065";
const kSafetyHostPhoneNumber = "+4593899064";
const kSafeFastavalMail = "safe@fastaval.dk";
const kServiceOpeningHours = {
  "bar": {"day1": "17:00 - 02:00"},
  "boardGames": {"day1": "09:00 - 02:00", "day2": "09:00 - 15:00"},
  "coffeeCafe": {"day1": "12:30 - 01:00", "day2": "09:00 - 01:00", "day3": "09:00 - 15:00"},
  "information": {"day1": "15:00 - 20:30", "day2": "09:30 - 20:30", "day3": "09:30 - 17:00"},
  "kiosk": {"day1": "08:00 - 00:00", "day2": "08:00 - 16:00"},
  "oasis": {"day1": "15:00 - 02:00", "day2": "12:00 - 02:00"},
};
const kStoreOpeningHours = {
  "store1": {"day1": "10:00 - 00:00"},
  "store2": {"day1": "10:00 - 22:00"},
  "store3": {"day1": "12:30 - 18:00"}
};
