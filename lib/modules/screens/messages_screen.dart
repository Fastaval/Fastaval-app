import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/config/models/message.dart';
import 'package:fastaval_app/constants/style_constants.dart';
import 'package:fastaval_app/utils/services/messages_service.dart';
import 'package:fastaval_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessagesScreen extends StatefulWidget {
  final List<Message> messages;

  const MessagesScreen({Key? key, required this.messages}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
    return textAndIconCard(tr('profile.messagesFromFastaval'),
        Icons.speaker_notes, messageList(widget.messages, context));
  }

  Widget messageList(List<Message> messages, context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: messages.length,
      separatorBuilder: (context, int index) {
        return const SizedBox(height: 10);
      },
      itemBuilder: (buildContext, index) {
        return userProgramItem(messages[index]);
      },
    );
  }

  Widget userProgramItem(Message message) {
    return Text(message.da);
  }
}
