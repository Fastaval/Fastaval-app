import 'dart:convert';

import 'package:fastaval_app/controllers/app.controller.dart';
import 'package:fastaval_app/models/notification.model.dart';
import 'package:fastaval_app/services/config.service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  RxList notificationList = [].obs;
  RxInt notificationsWaiting = 0.obs;
  RxInt notificationListUpdatedAt = 0.obs;
  final appController = Get.find<AppController>();

  init() {
    getNotifications();
  }

  setNotificationsWaiting() {
    fetchNotifications().then((notificationList) => {
          _updateNotificationList(notificationList),
          notificationsWaiting(notificationList.length)
        });
  }

  getNotifications() {
    fetchNotifications()
        .then((notificationList) => _updateNotificationList(notificationList));
  }

  _updateNotificationList(List<InfosysNotification> notifications) {
    notificationList(notifications);
    notificationListUpdatedAt(
        (DateTime.now().millisecondsSinceEpoch / 1000).round());
  }

  addNotificationWaiting() {
    notificationsWaiting++;
  }

  clearNotificationsWaiting() {
    notificationsWaiting(0);
  }

  Future<List<InfosysNotification>> fetchNotifications() async {
    if (appController.user.id == 0) throw Exception('User not logged in');

    var response = await http.get(Uri.parse(
        '$baseUrl/messages/${appController.user.id}?pass=${appController.user.password}'));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((item) => InfosysNotification.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to get messages');
    }
  }
}
