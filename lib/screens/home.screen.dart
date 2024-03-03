import 'package:badges/badges.dart' as badges;
import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/constants/styles.constant.dart';
import 'package:fastaval_app/models/user.model.dart';
import 'package:fastaval_app/screens/info.screen.dart';
import 'package:fastaval_app/screens/login.screen.dart';
import 'package:fastaval_app/screens/more.screen.dart';
import 'package:fastaval_app/screens/profile.screen.dart';
import 'package:fastaval_app/screens/program.screen.dart';
import 'package:fastaval_app/services/user.service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../helpers/notification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late List<BottomNavigationBarItem> _bottomNavList = _bottomNavItems();
  late User? _user;
  late int _userFetchTime;
  bool _loggedIn = false;
  int _currentIndex = 1;
  int _waitingMessages = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        setState(() {
          //_getNotifications();
          _waitingMessages = 1;
          _bottomNavList = _bottomNavItems();
        });
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        setState(() {
          //_getNotifications();
          _waitingMessages = 1;
          _bottomNavList = _bottomNavItems();
        });
      }
    });

    return NotificationListener(
      onNotification: (notification) {
        if (notification is UserScrollNotification) return false;
        if (notification is OverscrollNotification) return false;
        if (notification is OverscrollIndicatorNotification) return false;

        if (notification is UserNotification) {
          setState(() {
            _loggedIn = notification.loggedIn;
            _user = notification.user;
            _userFetchTime =
                (DateTime.now().millisecondsSinceEpoch / 1000).round();
            _bottomNavList = _bottomNavItems();
          });
        }

        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(child: _screens()[_currentIndex]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: onNavClick,
          items: _bottomNavList,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          backgroundColor: colorOrangeDark,
          selectedItemColor: colorWhite,
          unselectedItemColor: Colors.white54,
        ),
      ),
    );
  }

  @override
  initState() {
    _getUser();
    super.initState();
  }

  void onNavClick(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<BottomNavigationBarItem> _bottomNavItems() {
    return <BottomNavigationBarItem>[
      if (_loggedIn == true)
        BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            label: tr('bottomNavigation.profil')),
      if (_loggedIn == false)
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
              showBadge: _waitingMessages > 0,
              badgeContent: Text("$_waitingMessages"),
              child: const Icon(Icons.more_horiz_outlined)),
          label: tr('bottomNavigation.more')),
    ];
  }

  Future _getUser() async {
    await UserService().getUser().then((newUser) => {
          _user = newUser,
          _loggedIn = true,
          _userFetchTime =
              (DateTime.now().millisecondsSinceEpoch / 1000).round()
        });

    setState(() {
      _bottomNavList = _bottomNavItems();
    });
  }

  List<Widget> _screens() {
    return <Widget>[
      if (_loggedIn && _user != null)
        ProfileScreen(user: _user!, updateTime: _userFetchTime),
      if (!_loggedIn) LoginScreen(this),
      InfoScreen(),
      Programscreen(),
      MoreScreen()
    ];
  }
}
