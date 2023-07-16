import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/constants/styles.dart';
import 'package:fastaval_app/helpers/formatting.dart';
import 'package:fastaval_app/models/notification.dart';
import 'package:fastaval_app/services/messages_service.dart';
import 'package:fastaval_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationsScreen extends StatefulWidget {
  final List<InfosysNotification> notifications;
  final int updateTime;
  final Function updateParent;

  const NotificationsScreen(
      {Key? key,
      required this.notifications,
      required this.updateTime,
      required this.updateParent})
      : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<InfosysNotification> notificationList = widget.notifications;
  late int listUpdatedAt = widget.updateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(),
        title: Text(tr('drawer.messages')),
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
                            setState(() {
                              widget.updateParent(notificationList);
                              notificationList = notificationList;
                              listUpdatedAt =
                                  (DateTime.now().millisecondsSinceEpoch / 1000)
                                      .round();
                            }),
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
    return textAndTextCard(
        tr('notifications.title'),
        Text(
          "${tr('common.updated')} ${formatDay(listUpdatedAt, context)} ${formatTime(listUpdatedAt)}",
          style: kNormalTextSubdued,
        ),
        listWidget(widget.notifications.reversed.toList(), context));
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
                Text(
                  formatDay(notification.sendTime, context),
                  style: kNormalTextBoldStyle,
                ),
                Text(formatTime(notification.sendTime +
                    7200)) // + 2 hours, to compensate for UTC => UTC+2
              ])),
      Expanded(
          child: Text(context.locale.toString() == 'da'
              ? notification.da
              : notification.en))
    ]);
  }
}
