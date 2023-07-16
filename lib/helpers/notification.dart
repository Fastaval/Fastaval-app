import 'package:fastaval_app/models/user.dart';
import 'package:flutter/widgets.dart';

class UserNotification extends Notification {
  bool loggedIn = false;
  User? user;
  UserNotification({required this.loggedIn, required this.user});
}
