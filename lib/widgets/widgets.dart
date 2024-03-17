import 'package:fastaval_app/constants/styles.constant.dart';
import 'package:fastaval_app/controllers/notification.controller.dart';
import 'package:fastaval_app/helpers/formatting.dart';
import 'package:fastaval_app/models/activity_item.model.dart';
import 'package:fastaval_app/models/activity_run.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

final notificationController = Get.find<NotificationController>();

Widget oneTextRow(String text) {
  return Text(text, style: kNormalTextStyle, overflow: TextOverflow.ellipsis);
}

Widget programListItem(ActivityItem activity, ActivityRun run, Color color) {
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
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ]),
              ),
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Get.locale?.languageCode == 'da'
                          ? activity.daTitle
                          : activity.enTitle)
                    ])),
          ),
        ],
      ));
}

Widget menuCard(String title, IconData icon,
    [bool hasSubMenu = false, showBadge = false]) {
  return Card(
      surfaceTintColor: Colors.white,
      color: Colors.white,
      margin: kMenuCardMargin,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.black12, width: 1)),
      elevation: 1,
      child: Column(children: [
        ListTile(
          trailing:
              hasSubMenu ? Icon(Icons.keyboard_arrow_right_outlined) : null,
          title: Row(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 8, 0), child: Icon(icon)),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                  child: Text(title, style: kMenuCardHeaderStyle)),
              if (showBadge)
                Badge(
                    label: Text(
                        '${notificationController.notificationList.length - notificationController.notificationsOnLastClear.value}'))
            ],
          ),
        )
      ]));
}

Widget textAndIconCard(String title, IconData icon, content) {
  return Container(
      margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorWhite, width: 1),
      ),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 24, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: kCardHeaderStyle, overflow: TextOverflow.ellipsis),
              Icon(icon),
            ],
          ),
        ),
        content,
      ]));
}

Widget textAndTextCard(String title, String secondaryTitle, content) {
  return Container(
      margin: kCardMargin,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.41),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorWhite, width: 1),
      ),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: kCardHeaderStyle, overflow: TextOverflow.ellipsis),
              Text(secondaryTitle, style: kNormalTextSubdued),
            ],
          ),
        ),
        content
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
      padding: EdgeInsets.only(left: sidePadding ? 8 : 0),
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
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              });
            },
            child: Text(link,
                textAlign: TextAlign.right, style: kNormalTextClickableStyle)),
      ),
    ],
  );
}
