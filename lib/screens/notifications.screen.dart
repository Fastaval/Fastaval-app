import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/constants/styles.constant.dart';
import 'package:fastaval_app/controllers/notification.controller.dart';
import 'package:fastaval_app/helpers/formatting.dart';
import 'package:fastaval_app/models/notification.model.dart';
import 'package:fastaval_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:timezone/standalone.dart' as tz;

class NotificationsScreen extends StatelessWidget {
  final notificationController = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    notificationController.clearNotificationsWaiting();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorOrangeDark,
        foregroundColor: colorWhite,
        toolbarHeight: 40,
        centerTitle: true,
        titleTextStyle: kAppBarTextStyle,
        title: Text(tr('screenTitle.notifications')),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: backgroundBoxDecorationStyle,
              ),
              SizedBox(
                  height: double.infinity,
                  child: RefreshIndicator(
                    backgroundColor: colorWhite,
                    color: colorOrange,
                    onRefresh: () async {
                      notificationController.getNotifications();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Obx(() => textAndTextCard(
                              tr('notifications.title'),
                              Text(
                                "${tr('common.updated')} ${formatDay(notificationController.notificationListUpdatedAt.value)} ${formatTime(notificationController.notificationListUpdatedAt.value)}",
                                style: kNormalTextSubdued,
                              ),
                              listWidget(
                                  notificationController
                                      .notificationList.reversed
                                      .toList(),
                                  context))),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget listWidget(List<dynamic> notifications, context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: notifications.length,
      separatorBuilder: (context, int index) {
        return const Divider(
          height: 20,
          color: Colors.grey,
        );
      },
      itemBuilder: (buildContext, index) {
        return notificationItem(notifications[index]);
      },
    );
  }

  Widget notificationItem(InfosysNotification notification) {
    var tzOffset =
        (tz.getLocation('Europe/Copenhagen').currentTimeZone.offset / 1000)
            .round();
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(formatTime((notification.sendTime + tzOffset)))
              ])),
      Expanded(
          child: Text(Get.locale?.languageCode == 'da'
              ? notification.da
              : notification.en))
    ]);
  }
}
