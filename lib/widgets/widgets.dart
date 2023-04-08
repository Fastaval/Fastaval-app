import 'package:fastaval_app/constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget oneTextRow(String text) {
  return Text(text, style: kNormalTextStyle, overflow: TextOverflow.ellipsis);
}

Widget textAndIconCard(String title, IconData icon, content) {
  return Card(
      margin: kCardMargin,
      elevation: kCardElevation,
      child: Column(children: [
        ListTile(
            trailing: Icon(icon), title: Text(title, style: kCardHeaderStyle)),
        Row(children: [
          Expanded(child: Padding(padding: kCardContentPadding, child: content))
        ])
      ]));
}

Widget textAndTextCard(String title, Text secondaryTitle, content) {
  return Card(
      margin: kCardMargin,
      elevation: kCardElevation,
      child: Column(children: [
        ListTile(
            trailing: secondaryTitle,
            title: Text(title, style: kCardHeaderStyle)),
        Row(children: [
          Expanded(child: Padding(padding: kCardContentPadding, child: content))
        ])
      ]));
}

Widget textRowHeader(String text) {
  return Row(mainAxisSize: MainAxisSize.max, children: [
    Expanded(
        child: Text(text,
            style: kNormalTextBoldStyle, overflow: TextOverflow.ellipsis))
  ]);
}

Widget threeTextRow(String leftText, String centerText, String rightText) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        flex: 2,
        child: Text(leftText,
            textAlign: TextAlign.center, style: kNormalTextStyle),
      ),
      Expanded(
        flex: 5,
        child: Text(centerText,
            textAlign: TextAlign.left, style: kNormalTextStyle),
      ),
      Expanded(
        flex: 4,
        child: Text(rightText,
            textAlign: TextAlign.right, style: kNormalTextStyle, maxLines: 4),
      ),
    ],
  );
}

Widget twoTextRow(String textLeft, String textRight,
    {bool selectable = false, bool sidePadding = false}) {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: sidePadding ? 16 : 0),
      child: Row(
        children: <Widget>[
          Expanded(flex: 4, child: Text(textLeft, style: kNormalTextStyle)),
          Expanded(
            flex: 6,
            child: selectable
                ? SelectableText(textRight,
                    textAlign: TextAlign.right, style: kNormalTextStyle)
                : Text(textRight,
                    textAlign: TextAlign.right, style: kNormalTextStyle),
          ),
        ],
      ));
}

Widget twoTextRowWithTapAction(String title, String link, Uri url) {
  return Row(
    children: <Widget>[
      Expanded(flex: 11, child: Text(title, style: kNormalTextStyle)),
      Expanded(
        flex: 9,
        child: GestureDetector(
            onTap: () {
              canLaunchUrl(url).then((bool result) async {
                if (result) {
                  await launchUrl(url);
                }
              });
            },
            child: Text(url.path,
                textAlign: TextAlign.right, style: kNormalTextStyle)),
      ),
    ],
  );
}
