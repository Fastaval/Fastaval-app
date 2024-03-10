import 'package:badges/badges.dart' as badges;
import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/constants/styles.constant.dart';
import 'package:fastaval_app/controllers/app.controller.dart';
import 'package:fastaval_app/controllers/notification.controller.dart';
import 'package:fastaval_app/screens/info.screen.dart';
import 'package:fastaval_app/screens/login.screen.dart';
import 'package:fastaval_app/screens/more.screen.dart';
import 'package:fastaval_app/screens/notifications.screen.dart';
import 'package:fastaval_app/screens/profile.screen.dart';
import 'package:fastaval_app/screens/program.screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final appController = Get.find<AppController>();
  final notificationController = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        Get.to(() => NotificationsScreen(), transition: Transition.rightToLeft);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        notificationController.addNotificationWaiting();
      }
    });

    return NotificationListener(
      onNotification: (notification) {
        if (notification is UserScrollNotification) return false;
        if (notification is OverscrollNotification) return false;
        if (notification is OverscrollIndicatorNotification) return false;

        return false;
      },
      child: Scaffold(
        body: SafeArea(
            child: Obx(() => _screens()[appController.navIndex.value])),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: appController.navIndex.value,
              onTap: onNavClick,
              items: bottomNavItems(),
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              backgroundColor: colorOrangeDark,
              selectedItemColor: colorWhite,
              unselectedItemColor: Colors.white54,
            )),
      ),
    );
  }

  void onNavClick(int index) {
    appController.updateNavIndex(index);
  }

  bottomNavItems() {
    return [
      if (appController.loggedIn.value == true)
        BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            label: tr('bottomNavigation.profil')),
      if (appController.loggedIn.value == false)
        BottomNavigationBarItem(
            icon: const Icon(Icons.login_outlined),
            label: tr('bottomNavigation.login')),
      BottomNavigationBarItem(
          icon: const Icon(Icons.info_outline),
          label: tr('bottomNavigation.information')),
      BottomNavigationBarItem(
          icon: const Icon(Icons.calendar_month_outlined),
          label: tr('bottomNavigation.program')),
      BottomNavigationBarItem(
          icon: badges.Badge(
              showBadge: notificationController.notificationsWaiting.value > 0,
              badgeAnimation: badges.BadgeAnimation.slide(),
              badgeContent:
                  Text('${notificationController.notificationsWaiting.value}'),
              child: const Icon(Icons.more_horiz_outlined)),
          label: tr('bottomNavigation.more')),
    ];
  }

  List<Widget> _screens() {
    return [
      if (appController.loggedIn.value == true) ProfileScreen(),
      if (appController.loggedIn.value == false) LoginScreen(),
      InfoScreen(),
      Programscreen(),
      MoreScreen()
    ];
  }
}
