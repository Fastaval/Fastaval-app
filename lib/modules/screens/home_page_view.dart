import 'package:barcode_widget/barcode_widget.dart';
import 'package:fastaval_app/modules/screens/Programscreen.dart';
import 'package:fastaval_app/modules/screens/loginscreen.dart';
import 'package:fastaval_app/modules/screens/infoscreen.dart';
import 'package:fastaval_app/utils/services/user_service.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePageView> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    LoginScreen(),
    InfoScreen(),
    Programscreen(),
    Programscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code),
            tooltip: 'Show barcode',
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      content: Center(
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: BarcodeWidget(
                            barcode: Barcode.ean8(), // Barcode type and settings
                            data: '22000347',
                          ),
                        ),
                      ),
                    );
                  }
              );
            },
          )
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
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
