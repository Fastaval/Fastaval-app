import 'package:fastaval_app/constants/styleconstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    children: <Widget>[
                      _buildSafeFastaval(),
                      _buildWIFI(),
                      _buildOpenHours(),
                      _buildstores(),
                      _buildfastawaer(),
                      _buildlostfound(),
                      _buildTransport(),
                      const Padding(padding: EdgeInsets.only(bottom: 80))
                    ],
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
  return SizedBox(
    width: double.infinity,
    child: Card(
      margin: kCardMargin,
      elevation: 5,
      child: Padding(
        padding: kCardPadding,
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
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'Vagthavende General:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        canLaunch('tel:+4561409065').then((bool result) async {
                          if (result) {
                            final Uri launchUri = Uri(
                              scheme: 'tel',
                              path: '+4561409065',
                            );
                            await launch(launchUri.toString());
                          }
                        });
                      },
                      child: const Text(
                        '+45 61 40 90 65',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'GDS:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        canLaunch('tel:+4561409264').then((bool result) async {
                          if (result) {
                            final Uri launchUri = Uri(
                              scheme: 'tel',
                              path: '+4561409264',
                            );
                            await launch(launchUri.toString());
                          }
                        });
                      },
                      child: const Text(
                        '+45 61 40 92 64',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'Tryghedsvært:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        canLaunch('tel:+4561409264').then((bool result) async {
                          if (result) {
                            final Uri launchUri = Uri(
                              scheme: 'tel',
                              path: '+4561409264',
                            );
                            await launch(launchUri.toString());
                          }
                        });
                      },
                      child: const Text(
                        '+45 61 40 92 64',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Safemail:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'safe@fastaval.dk',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildWIFI() {
  return SizedBox(
    width: double.infinity,
    child: Card(
      margin: kCardMargin,
      elevation: 5,
      child: Padding(
        padding: kCardPadding,
        child: ListTile(
          leading: const Icon(Icons.wifi),
          title: const Text(
            'WIFI',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          subtitle: Container(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
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
      ),
    ),
  );
}

Widget _buildOpenHours() {
  return SizedBox(
    width: double.infinity,
    child: Card(
      margin: kCardMargin,
      elevation: 5,
      child: Padding(
        padding: kCardPadding,
        child: ListTile(
          leading: const Icon(Icons.watch),
          title: const Text(
            'Åbningstider',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          subtitle: Container(
            padding: const EdgeInsets.only(top: 2, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //infomation
                const Text(
                  'Informationen:',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: const <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Onsdag',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'kl. 15:00 - 21:00',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                    Row(
                      children: const <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Tor-lør',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'kl. 09:00 - 21:00',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                    Row(
                      children: const <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Søndag',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'kl. 09:00 - 17:00',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                ),
                //kaffekro
                const Text(
                  "Otto's Kaffekro:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: const <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Ons-søn',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'kl. 09:00 - 23:00',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                ),
                //brætspilscafe
                const Text(
                  "Brætspilscaféen:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: const <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Ons-lør',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'kl. 09:00 - 02:00',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                    Row(
                      children: const <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            'søndag',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'kl. 09:00 - 15:00',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                ),
                //Kiosken
                const Text(
                  "Kiosken:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: const <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Ons-lør',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'kl. 09:00 - 00:00',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                    Row(
                      children: const <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            'søndag',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'kl. 09:00 - 17:00',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                ),
                //Baren
                const Text(
                  "Baren:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: const <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Ons-søn',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'kl. 17:00 - 02:00',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                ),
                const Text(
                  "Oasen:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: const <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Onsdag',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'kl. 16:00 - 02:00',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                    Row(
                      children: const <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Tor-søn',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'kl. 12:00 - 02:00',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildstores() {
  return SizedBox(
    width: double.infinity,
    child: Card(
      margin: kCardMargin,
      elevation: 5,
      child: Padding(
        padding: kCardPadding,
        child: ListTile(
          leading: const Icon(Icons.store),
          title: const Text(
            'Butikker',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          subtitle: Container(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Epic Panda i B45',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'OpenSans',
                  ),
                ),
                Column(
                  children: const <Widget>[
                    Text(
                      'Onsdag kl.16.00 - 23.00',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    Text(
                      'Tors-lør kl.10.00 - 23.00',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    Text(
                      'Søndag kl.10.00 - 15.00',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                const Text(
                  'Tier1MTG i A07 (kl. 10.00-22.00)',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'OpenSans',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                const Text(
                  'Corra Design i fællesområdet  (Fre-søn kl. 10.00-16.00)',
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
      ),
    ),
  );
}

Widget _buildlostfound() {
  return SizedBox(
    width: double.infinity,
    child: Card(
      margin: kCardMargin,
      elevation: 5,
      child: Padding(
        padding: kCardPadding,
        child: ListTile(
          leading: const Icon(Icons.move_to_inbox),
          title: const Text(
            'Lost & Found',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          subtitle: Container(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'Har du mistet eller fundet noget? Gå til Informationen for at få hjælp!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildfastawaer() {
  return SizedBox(
    width: double.infinity,
    child: Card(
      margin: kCardMargin,
      elevation: 5,
      child: Padding(
        padding: kCardPadding,
        child: ListTile(
          leading: const Icon(Icons.person),
          title: const Text(
            'Fasta-Wear',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          subtitle: Container(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'Har du bestilt wear?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'OpenSans',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text(
                  'Det kan hentes i Informationen efter du har tjekket ind. Oplys dit navn og deltagernummer og du vil få udleveret dit wear.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'OpenSans',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text(
                  'I år får alle tilmeldte deltagere et navneskilt. Det kan hentes i Informationen under Fastaval',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildTransport() {
  return SizedBox(
    width: double.infinity,
    child: Card(
      margin: kCardMargin,
      elevation: 5,
      child: Padding(
        padding: kCardPadding,
        child: ListTile(
          leading: const Icon(Icons.local_parking),
          title: const Text(
            'Transport og Parkering',
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
                  "Parkering kan gøres på Gymnasiets eller Idrætscenterets Parkeringsplads."),
              Text("Hobro Togstation er ca. 2,5 km fra Fastaval."),
              Text("Hobro Taxa: +45 98 51 23 00"),
              Text("Krone Taxa: +45 98 52 11 11"),
            ],
          ),
        ),
      ),
    ),
  );
}
