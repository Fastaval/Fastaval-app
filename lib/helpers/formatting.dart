import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

String formatDay(int? time, BuildContext context) {
  return DateFormat.E(context.locale.languageCode == 'da' ? 'da_DK' : 'en_UK')
      .format(formatTimestampToDateTime(time!))
      .capitalize();
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

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
