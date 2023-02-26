import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

String formatDay(int? time, BuildContext context) {
  return DateFormat.E(context.locale.toString() == 'en' ? 'en_UK' : 'da_DK')
      .format(formatTimestampToDateTime(time!));
}

String formatTime(int? time) {
  return DateFormat.Hm().format(formatTimestampToDateTime(time!));
}

DateTime formatTimestampToDateTime(int timeInUnixTime) {
  return DateTime.fromMillisecondsSinceEpoch(timeInUnixTime * 1000);
}

DateTime unixtodatetime(int timeInUnixTime) {
  return DateTime.fromMillisecondsSinceEpoch(timeInUnixTime);
}
