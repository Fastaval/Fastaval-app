import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/config/models/user.dart';
import 'package:fastaval_app/modules/screens/info_screen.dart';
import 'package:fastaval_app/modules/screens/login_screen.dart';
import 'package:fastaval_app/modules/screens/profile_screen.dart';
import 'package:fastaval_app/modules/screens/program_screen.dart';
import 'package:fastaval_app/utils/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../notifications/login_notification.dart';

class HomePageState extends State<HomePageView> {
  UserService userService = UserService();
  late List<BottomNavigationBarItem> _bottomNavList = _bottomNavItems();
  late User? _user;
  bool _loggedIn = false;
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<LoginNotification>(
      onNotification: (notification) {
        setState(() {
          _loggedIn = notification.loggedIn;
          _user = notification.user;
          _bottomNavList = _bottomNavItems();
        });
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            tr('app.title'),
            style: const TextStyle(color: Colors.white),
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
                    tooltip: tr('appbar.barcode.show'),
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
                                          barcode: Barcode.ean8(),
                                          // Barcode type and settings
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
                    Fluttertoast.showToast(
                        msg: tr('appbar.map.noMapAvailable'));
                  },
                ),
              ],
            ),
          ],
        ),
        body: _screens()[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: _bottomNavList,
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();
    _fetchUser();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<BottomNavigationBarItem> _bottomNavItems() {
    return <BottomNavigationBarItem>[
      _loggedIn
          ? BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: tr('bottomNavigation.profil'))
          : BottomNavigationBarItem(
              icon: const Icon(
                Icons.login,
              ),
              label: tr('bottomNavigation.login')),
      BottomNavigationBarItem(
          icon: const Icon(Icons.info),
          label: tr('bottomNavigation.information')),
      BottomNavigationBarItem(
          icon: const Icon(Icons.calendar_view_day),
          label: tr('bottomNavigation.program'))
    ];
  }

  Future _fetchUser() async {
    await userService
        .getUser()
        .then((newUser) => {_user = newUser, _loggedIn = true});

    setState(() {
      _bottomNavList = _bottomNavItems();
    });
  }

  List<Widget> _screens() {
    return <Widget>[
      _loggedIn && _user != null
          ? ProfileScreen(
              appUser: _user!,
            )
          : LoginScreen(this),
      const InfoScreen(),
      const Programscreen(),
    ];
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}
