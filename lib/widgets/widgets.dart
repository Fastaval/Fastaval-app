import 'dart:developer';

import 'package:fastaval_app/constants/styles.constant.dart';
import 'package:fastaval_app/helpers/formatting.dart';
import 'package:fastaval_app/models/activity_item.model.dart';
import 'package:fastaval_app/models/activity_run.model.dart';
import 'package:fastaval_app/services/config.service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget oneTextRow(String text) {
  return Text(text, style: kNormalTextStyle, overflow: TextOverflow.ellipsis);
}

Widget programListItem(ActivityItem activity, ActivityRun run, Color color) {
  inspect(activity);
  var currLang = ConfigService.instance.currLang;
  return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
      child: Row(
        children: [
          SizedBox(
            height: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(width: 5, color: color),
                    right: BorderSide(width: 1, color: Colors.grey.shade300)),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        formatTime(run.start),
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontFamily: 'OpenSans'),
                      ),
                    ]),
              ),
            ),
          ),
          SizedBox(width: 10),
          SizedBox(
            height: 25,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(currLang == 'da' ? activity.daTitle : activity.enTitle)
                ]),
          ),
        ],
      ));
}

Widget textAndIconCard(String title, IconData icon, content) {
  return Card(
      surfaceTintColor: Colors.white,
      color: Colors.white,
      margin: kCardMargin,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.black12, width: 1)),
      elevation: 1,
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
      surfaceTintColor: Colors.white,
      color: Colors.white,
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
            child: Text(link,
                textAlign: TextAlign.right, style: kNormalTextClickableStyle)),
      ),
    ],
  );
}
