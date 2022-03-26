import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctxt) {
    return Scaffold(
        appBar: AppBar(
      title: const Text("Multi Page Application"),
    ));
  }
}
