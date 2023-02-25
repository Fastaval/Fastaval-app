import 'package:fastaval_app/config/models/user.dart';
import 'package:flutter/widgets.dart';

class LoginNotification extends Notification {
  bool loggedIn = false;
  User? user;
  LoginNotification({
    required this.loggedIn,
    required this.user,
  });
}
