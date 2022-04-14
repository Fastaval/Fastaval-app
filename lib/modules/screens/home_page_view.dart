import 'package:barcode_widget/barcode_widget.dart';
import 'package:fastaval_app/config/models/user.dart';
import 'package:fastaval_app/modules/screens/programscreen.dart';
import 'package:fastaval_app/modules/screens/loginscreen.dart';
import 'package:fastaval_app/modules/screens/infoscreen.dart';
import 'package:fastaval_app/utils/services/user_service.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'profilescreen.dart';

import '../notifications/login_notification.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

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

class HomePageState extends State<HomePageView> {
  UserService userService = UserService();
  late PdfViewerController _pdfViewerController;
  late User user;
  @override
  void initState() {
    _pdfViewerController = PdfViewerController();

    super.initState();
  }

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
            widget.title,
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
                                          data: user.barcode!,
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                            insetPadding:
                                const EdgeInsets.fromLTRB(20, 10, 20, 20),
                            child: Scaffold(
                                body: RotatedBox(
                                    quarterTurns: 1,
                                    child: SfPdfViewer.asset(
                                      'Mariagerfjord_kort_2022.pdf',
                                      controller: _pdfViewerController,
                                    ))));
                      },
                    );
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

  List<Widget> notLoggedInWidgets() {
    return <Widget>[
      //ProfilePage(parent),
      LoginScreen(this),
      const InfoScreen(),
      const Programscreen(),
    ];
  }

  List<Widget> loggedInWidgets() {
    return <Widget>[
      //ProfilePage(parent),
      ProfileScreen(
        appUser: user,
      ),
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
