import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/config/models/user.dart';
import 'package:fastaval_app/constants/style_constants.dart';
import 'package:fastaval_app/modules/screens/info_screen.dart';
import 'package:fastaval_app/modules/screens/login_screen.dart';
import 'package:fastaval_app/modules/screens/profile_screen.dart';
import 'package:fastaval_app/modules/screens/program_screen.dart';
import 'package:fastaval_app/utils/services/config_service.dart';
import 'package:fastaval_app/utils/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../notifications/login_notification.dart';

class HomePageState extends State<HomePageView> {
  late List<BottomNavigationBarItem> _bottomNavList = _bottomNavItems();
  late User? _user;
  bool _loggedIn = false;
  int _currentIndex = 1;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

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
        key: _scaffoldKey,
        body: SafeArea(child: _screens()[_currentIndex]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: _bottomNavList,
        ),
        endDrawer: drawMenu(context),
      ),
    );
  }

  @override
  initState() {
    ConfigService().initConfig();
    _fetchUser();
    super.initState();
  }

  void onTabTapped(int index) {
    if (index == 3) {
      _openDrawer();
      return;
    }
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
              icon: const Icon(Icons.login),
              label: tr('bottomNavigation.login')),
      BottomNavigationBarItem(
          icon: const Icon(Icons.info),
          label: tr('bottomNavigation.information')),
      BottomNavigationBarItem(
          icon: const Icon(Icons.calendar_view_day),
          label: tr('bottomNavigation.program')),
      BottomNavigationBarItem(
          icon: const Icon(Icons.menu_open), label: tr('bottomNavigation.more'))
    ];
  }

  Future _fetchUser() async {
    await UserService()
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

  Drawer drawMenu(BuildContext context) {
    return Drawer(
      elevation: 10.0,
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: backgroundBoxDecorationStyle,
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    buildIdIcon(),
                    Row(
                      children: [
                        if (_loggedIn)
                          IconButton(
                            icon: const Icon(
                              CupertinoIcons.barcode,
                              color: Colors.white,
                            ),
                            tooltip: tr('appbar.barcode.show'),
                            onPressed: () {
                              UserService()
                                  .getUser()
                                  .then((user) => {barcode(context, user)});
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
                )
              ],
            ),
          ),

          //Here you place your menu items
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(tr('bottomNavigation.profil'),
                style: const TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
            },
          ),
          const Divider(height: 3.0),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
            },
          ),
          ListTile(
            leading: const Icon(Icons.close),
            title: const Text('Close Drawer', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> barcode(BuildContext context, User user) {
    return showDialog(
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
        });
  }

  Widget buildIdIcon() {
    String text;
    if (_loggedIn) {
      text = _user!.id.toString();
    } else {
      text = "";
    }
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 58,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans'),
          ),
        ),
      ],
    );
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}
