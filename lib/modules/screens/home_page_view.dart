import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/config/models/user.dart';
import 'package:fastaval_app/modules/screens/infoscreen.dart';
import 'package:fastaval_app/modules/screens/loginscreen.dart';
import 'package:fastaval_app/modules/screens/profilescreen.dart';
import 'package:fastaval_app/modules/screens/programscreen.dart';
import 'package:fastaval_app/utils/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../notifications/login_notification.dart';

List<BottomNavigationBarItem> loggedInBars = [
  const BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
      ),
      label: 'Profil'),
  const BottomNavigationBarItem(
      icon: Icon(
        Icons.info,
      ),
      label: 'Information'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.calendar_view_day), label: 'Program'),
];

List<BottomNavigationBarItem> notLoggedInNavBars = [
  const BottomNavigationBarItem(
      icon: Icon(
        Icons.login,
      ),
      label: 'Login'),
  const BottomNavigationBarItem(
      icon: Icon(
        Icons.info,
      ),
      label: 'Information'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.calendar_view_day), label: 'Program'),
];

class HomePageState extends State<HomePageView> {
  UserService userService = UserService();
  late User user;
  int _currentIndex = 1;

  bool _loggedIn = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<LoginNotification>(
      onNotification: (notification) {
        setState(() {
          _loggedIn = notification.loggedIn;
          user = notification.user;
        });
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            tr('app.title'),
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_loggedIn)
                  IconButton(
                    icon: const Icon(
                      CupertinoIcons.barcode,
                      color: Colors.white,
                    ),
                    tooltip: 'Show barcode',
                    onPressed: () {
                      userService.getUser().then((user) => {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Center(
                                      child: RotatedBox(
                                        quarterTurns: 1,
                                        child: BarcodeWidget(
                                          barcode: Barcode
                                              .ean8(), // Barcode type and settings
                                          data: user.barcode.toString(),
                                        ),
                                      ),
                                    ),
                                  );
                                })
                          });
                    },
                  ),
                IconButton(
                  icon: const Icon(
                    Icons.map,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Fluttertoast.showToast(msg: 'No map for you');
                  },
                ),
              ],
            ),
          ],
        ),
        body: _loggedIn
            ? loggedInWidgets()[_currentIndex]
            : notLoggedInWidgets()[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: _loggedIn ? loggedInBars : notLoggedInNavBars,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  List<Widget> loggedInWidgets() {
    return <Widget>[
      ProfileScreen(
        appUser: user,
      ),
      const InfoScreen(),
      const Programscreen(),
    ];
  }

  List<Widget> notLoggedInWidgets() {
    return <Widget>[
      LoginScreen(this),
      const InfoScreen(),
      const Programscreen(),
    ];
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}
