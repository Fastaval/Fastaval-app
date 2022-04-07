import 'package:fastaval_app/modules/screens/infoscreen.dart';
import 'package:flutter/material.dart';
import 'modules/screens/loginscreen.dart';
import 'modules/screens/home_page_view.dart';

import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fastaval App Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: HomePageView(title: 'Fastaval App\'en'),
    );
  }
}
