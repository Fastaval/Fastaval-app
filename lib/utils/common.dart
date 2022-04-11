import 'package:intl/intl.dart';

main() {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
  print(formatted); // something like 2013-04-20
}
