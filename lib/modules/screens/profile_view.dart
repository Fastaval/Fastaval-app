import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  final Color color;

  ProfileView(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
