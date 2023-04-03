import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/config/helpers/formatting.dart';
import 'package:fastaval_app/config/models/message.dart';
import 'package:fastaval_app/constants/style_constants.dart';
import 'package:fastaval_app/utils/services/messages_service.dart';
import 'package:fastaval_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationsScreen extends StatefulWidget {
  final List<Message> messages;

  const NotificationsScreen({Key? key, required this.messages})
      : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
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
                      fetchMessages()
                          .then((messages) => scheduleMicrotask(() {}));
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 10),
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
    return textAndIconCard(tr('notifications.title'), Icons.speaker_notes,
        messageList(widget.messages.reversed.toList(), context));
  }

  Widget messageList(List<Message> messages, context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: messages.length,
      separatorBuilder: (context, int index) {
        return const Divider(
          height: 20,
          color: Colors.grey,
        );
      },
      itemBuilder: (buildContext, index) {
        return userProgramItem(messages[index]);
      },
    );
  }

  Widget userProgramItem(Message message) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  formatDay(message.sendTime, context),
                  style: kNormalTextBoldStyle,
                ),
                Text(formatTime(message.sendTime +
                    7200)) // + 2 hours, to compensate for UTC => UTC+2
              ])),
      Expanded(
          child:
              Text(context.locale.toString() == 'en' ? message.en : message.da))
    ]);
  }
}
