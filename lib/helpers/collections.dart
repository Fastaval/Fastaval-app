import 'package:flutter/material.dart';

Map<String, Color> colorMap = {
  'braet': Color(0xBCB2DAFB),
  'designer': Color(0xFFFFB851),
  'gds': Color(0xFFFFB851),
  'junior': Color(0xFFfdef90),
  'ottoviteter': Color(0xFFFFB851),
  'rolle': Color(0xFFAED581),
  'spilleder': Color(0xFFFFB851),
  'system': Color(0xFFFFB851),
  'live': Color(0xFFAED581),
  'magic': Colors.purpleAccent.shade100,
  'workshop': Colors.amberAccent.shade200,
  'figur': Colors.red.shade300
};

/// Returns the color associated with the given activity type.
Color getActivityColor(String type) {
  return colorMap[type] ?? Colors.grey;
}
