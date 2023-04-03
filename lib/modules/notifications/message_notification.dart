import 'package:fastaval_app/config/models/message.dart';
import 'package:flutter/widgets.dart';

class MessageNotification extends Notification {
  Message? message;

  MessageNotification({required this.message});
}
