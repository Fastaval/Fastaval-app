import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFF9800),
                      Color(0xFFFB8c00),
                      Color(0xFFF57C00),
                      Color(0xFFEF6c00),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[_buildSafeFastaval(), _buildWIFI()],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildSafeFastaval() {
  return Container(
    width: double.infinity,
    child: Card(
      margin: EdgeInsetsDirectional.fromSTEB(8, 10, 8, 0),
      elevation: 5,
      child: ListTile(
        leading: const Icon(Icons.phone),
        title: const Text(
          'Safe Fastaval',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'Vagthavende General: +45 61 40 92 65',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: 'OpenSans',
              ),
            ),
            Text(
              'Tryghedsvært: +45 61 40 92 64',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: 'OpenSans',
              ),
            ),
            Text(
              'Safemail: safe@fastaval.dk',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: 'OpenSans',
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget _buildWIFI() {
  return Container(
    width: double.infinity,
    child: Card(
      margin: EdgeInsetsDirectional.fromSTEB(8, 10, 8, 0),
      elevation: 5,
      child: ListTile(
        leading: const Icon(Icons.phone),
        title: const Text(
          'WIFI',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'Netværk: Undervisning',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: 'OpenSans',
              ),
            ),
            Text(
              'Brugernavn: mfg-guest@mf-gym.dk',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: 'OpenSans',
              ),
            ),
            Text(
              'Kode: Teleskop2022 ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: 'OpenSans',
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget _buildOpenHours() {
  return Container(
    width: double.infinity,
    child: Card(
      margin: EdgeInsetsDirectional.fromSTEB(8, 10, 8, 0),
      elevation: 5,
      child: ListTile(
        leading: const Icon(Icons.phone),
        title: const Text(
          'Åbningstider',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'Informationen',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: 'OpenSans',
              ),
            ),
            Text(
              'Tryghedsvært: +45 61 40 92 64',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: 'OpenSans',
              ),
            ),
            Text(
              'Safemail: safe@fastaval.dk',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: 'OpenSans',
              ),
            )
          ],
        ),
      ),
    ),
  );
}
