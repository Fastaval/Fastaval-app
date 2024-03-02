import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/constants/styles.constant.dart';
import 'package:fastaval_app/controllers/notification.controller.dart';
import 'package:fastaval_app/helpers/formatting.dart';
import 'package:fastaval_app/models/notification.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NotificationsScreen extends GetView<NotificationController> {
  NotificationsScreen({super.key});
  // late List<InfosysNotification> notificationList = widget.notifications;
  // late int listUpdatedAt = widget.updateTime;

  @override
  Widget build(BuildContext context) {
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
                    onRefresh: () async {
                      fetchNotifications().then((notificationList) => {
                            /* setState(() {
                              widget.updateParent(notificationList);
                              notificationList = notificationList;
                              listUpdatedAt =
                                  (DateTime.now().millisecondsSinceEpoch / 1000)
                                      .round();
                            }), */
                          });
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          buildMessages(),
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

  Widget buildMessages() {
    return Obx(() => Text('${controller.listUpdatedAt.value}'));
    /* return textAndTextCard(
        tr('notifications.title'),
        Text(
          "${tr('common.updated')} ${formatDay(listUpdatedAt, context)} ${formatTime(listUpdatedAt)}",
          style: kNormalTextSubdued,
        ),
        listWidget(widget.notifications.reversed.toList(), context)); */
  }

  Widget listWidget(List<InfosysNotification> notifications, context) {
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
        return userProgramItem(notifications[index]);
      },
    );
  }

  Widget userProgramItem(InfosysNotification notification) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
/*                 Text(
                  formatDay(notification.sendTime, context),
                  style: kNormalTextBoldStyle,
                ), */
                Text(formatTime(notification.sendTime +
                    7200)) // + 2 hours, to compensate for UTC => UTC+2
              ])),
      Expanded(
          child: Text(Get.locale?.languageCode == 'da'
              ? notification.da
              : notification.en))
    ]);
  }
}
