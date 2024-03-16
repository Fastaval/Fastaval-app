import 'package:flutter/material.dart';

Map<String, Color> colorMap = {
  'rolle': Color(0xFFfeb951),
  'braet': Color(0xBE64B5F6),
  'live': Color(0xFFfeb951),
  'ottoviteter': Color(0xBEFF9700),
  'junior': Colors.pink.shade300,
  'magic': Colors.purpleAccent.shade100,
  'workshop': Colors.amberAccent.shade200,
  'figur': Colors.red.shade300
};

/// Returns the color associated with the given activity type.
Color getActivityColor(String type) {
  return colorMap[type] ?? Colors.grey.shade300;
}
