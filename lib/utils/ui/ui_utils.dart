import 'package:flutter/material.dart';

BoxDecoration decoration() {
  return const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFFF9800),
        Color(0xFFFB8c00),
        Color(0xFFF57C00),
        Color(0xFFEF6c00),
      ],
      stops: [0.1, 0.4, 0.7, 0.9],
    ),
  );
}
