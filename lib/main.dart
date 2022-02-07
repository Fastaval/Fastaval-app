import 'package:flutter/material.dart';

import 'modules/screens/homescreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      home: new HomeScreen(),
    );
  }
}
