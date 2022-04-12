import 'package:intl/intl.dart';

DateTime unixtodatetime(int timeInUnixTime) {
  return DateTime.fromMillisecondsSinceEpoch(timeInUnixTime);
}
