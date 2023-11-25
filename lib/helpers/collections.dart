import 'package:flutter/material.dart';

final Map<String, Color> colorMap = {
  'rolle': Colors.lightGreen.shade300,
  'braet': Colors.blue.shade300,
  'live': Colors.teal.shade400,
  'ottoviteter': Colors.orangeAccent.shade400,
  'junior': Colors.pink.shade300,
  'magic': Colors.purpleAccent.shade100,
  'workshop': Colors.amberAccent.shade200,
  'figur': Colors.red.shade300
};

/// Returns the color associated with the given activity type.
Color getActivityColor(String type) {
  return colorMap[type] ?? Colors.grey.shade300;
}
