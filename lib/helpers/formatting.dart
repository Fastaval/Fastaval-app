import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

formatDay(int? time) {
  return DateFormat.E(Get.locale!.languageCode == 'da' ? 'da_DK' : 'en_UK')
      .format(formatTimestampToDateTime(time!))
      .capitalizeString();
}

String formatTime(int? time) {
  return DateFormat('HH:mm').format(formatTimestampToDateTime(time!));
}

DateTime formatTimestampToDateTime(int timeInUnixTime) {
  return DateTime.fromMillisecondsSinceEpoch(timeInUnixTime * 1000);
}

String getLanguage(String language) {
  switch (language) {
    case 'dansk':
      return tr('common.danish');
    case 'engelsk':
      return tr('common.english');
    case 'dansk+engelsk':
      return tr('common.danEng');
    default:
      return '';
  }
}

extension StringExtensions on String {
  String capitalizeString() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
