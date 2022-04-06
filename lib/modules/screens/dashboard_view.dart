import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  final Color color;

  DashboardView(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
