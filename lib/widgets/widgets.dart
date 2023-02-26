import 'package:fastaval_app/constants/style_constants.dart';
import 'package:flutter/material.dart';

Widget textAndIconCard(String title, IconData icon, content) {
  return Card(
      margin: kCardMargin,
      elevation: kCardElevation,
      child: Column(children: [
        ListTile(
            trailing: Icon(icon), title: Text(title, style: kCardHeaderStyle)),
        Padding(padding: kCardContentPadding, child: content)
      ]));
}

Widget textRowHeader(String text) {
  return Row(children: [Text(text, style: kNormalTextBoldStyle)]);
}
