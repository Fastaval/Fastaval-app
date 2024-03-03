import 'dart:convert';

import 'package:fastaval_app/models/notification.model.dart';
import 'package:fastaval_app/models/user.model.dart';
import 'package:fastaval_app/services/config.service.dart';
import 'package:fastaval_app/services/user.service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  RxList notificationList = [].obs;
  RxInt notificationsWaiting = 0.obs;
  RxInt notificationListUpdatedAt = 0.obs;

  init() {
    getNotifications();
  }

  getNotifications() {
    fetchNotifications()
        .then((notificationList) => _updateNotificationList(notificationList));
  }

  _updateNotificationList(List<InfosysNotification> notifications) {
    notificationList.value = RxList(notifications);
    notificationListUpdatedAt =
        RxInt((DateTime.now().millisecondsSinceEpoch / 1000).round());
  }

  addNotificationWaiting() {
    print('ADDING NOTIFICATION');
    notificationsWaiting++;
  }

  clearNotificationsWaiting() {
    print('CLEARING NOTIFICATIONS');
    notificationsWaiting = 0.obs;
  }
}

Future<List<InfosysNotification>> fetchNotifications() async {
  User user = await UserService().getUser();
  var response = await http
      .get(Uri.parse('$baseUrl/messages/${user.id}?pass=${user.password}'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => InfosysNotification.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to get messages');
  }
}
