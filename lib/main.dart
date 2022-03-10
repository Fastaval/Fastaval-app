import 'package:flutter/material.dart';

import 'modules/screens/loginscreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      title: 'Fastaval App Login',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
