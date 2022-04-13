import 'package:barcode_widget/barcode_widget.dart';
import 'package:fastaval_app/modules/screens/Programscreen.dart';
import 'package:fastaval_app/modules/screens/loginscreen.dart';
import 'package:fastaval_app/modules/screens/infoscreen.dart';
import 'package:fastaval_app/utils/services/user_service.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../notifications/login_notification.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePageView> {
  UserService userService = UserService();
  int _currentIndex = 1;
  final List<Widget> _children = [
    LoginScreen(),
    InfoScreen(),
    Programscreen(),
  ];

  bool _loggedIn = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<LoginNotification>(
        onNotification: (notification) {
          setState(() { _loggedIn = notification.loggedIn; });
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                widget.title,
                style: TextStyle(color: Colors.white),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(_loggedIn)
                    IconButton(
                      icon: Icon(
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
                                      barcode:
                                      Barcode.ean8(), // Barcode type and settings
                                      data: user.barcode!,
                                    ),
                                  ),
                                ),
                              );
                            })
                            }
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.map,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // do something
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // do something
                      },
                    )
                  ],
                ),
              ],
            ),
            body: _children[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: onTabTapped,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                    ),
                    label: 'Profil'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.info,
                    ),
                    label: 'Information'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_view_day), label: 'Program'),
              ],
            ),
          )
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
