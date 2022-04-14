import 'package:barcode_widget/barcode_widget.dart';
import 'package:fastaval_app/config/models/user.dart';
import 'package:fastaval_app/modules/screens/Programscreen.dart';
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
  BottomNavigationBarItem(
      icon: Icon(
        Icons.login,
      ),
      label: 'Login'),
  BottomNavigationBarItem(
      icon: Icon(
        Icons.info,
      ),
      label: 'Information'),
  BottomNavigationBarItem(
      icon: Icon(Icons.calendar_view_day), label: 'Program'),
];

List<BottomNavigationBarItem> loggedInBars = [
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
];

class HomePageState extends State<HomePageView> {

  UserService userService = UserService();
  late PdfViewerController _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _pdfViewerStateKey = GlobalKey();
  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  int _currentIndex = 1;
  bool isLoggedIn = false;
  


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

  String userBarCode = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  CupertinoIcons.barcode,
                  color: Colors.white,
                ),
                tooltip: 'Show barcode',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return barcodedialog();
                      });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.map,
                  color: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                          insetPadding: EdgeInsets.fromLTRB(20, 10, 20, 20),
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
      body: isLoggedIn
          ? loggedInWidgets(this)[_currentIndex]
          : notLoggedInWidgets(this)[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: isLoggedIn ? loggedInBars : notLoggedInNavBars,
      ),

    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget barcodedialog() {
    return AlertDialog(
      content: Center(
        child: RotatedBox(
          quarterTurns: 1,
          child: BarcodeWidget(
            barcode: Barcode.ean8(), // Barcode type and settings
            data: userBarCode,
            //TODO add barcode from userdata
          ),
        ),
      ),
    );
  }

  List<Widget> notLoggedInWidgets(HomePageState parent) {
    return <Widget>[
      //ProfilePage(parent),
      LoginScreen(parent),
      InfoScreen(),
      Programscreen(),
    ];
  }

  List<Widget> loggedInWidgets(HomePageState parent) {
    return <Widget>[
      //ProfilePage(parent),
      ProfileScreen(
        appUser: myuser,
      ),
      InfoScreen(),
      Programscreen(),
    ];
  }
}
