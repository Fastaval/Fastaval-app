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
              buildSideBySideTextWithUrlAction('Vagthavende General:', '+45 61 40 90 65', Uri(
                scheme: 'tel',
                path: '+4561409065',
              )),
              const SizedBox(
                height: 10,
              ),
              buildSideBySideTextWithUrlAction('GDS:', '+45 61 40 92 63', Uri(
                scheme: 'tel',
                path: '+4561409263',
              )),
              const SizedBox(
                height: 10,
              ),
              buildSideBySideTextWithUrlAction('Tryghedsvært:', '+45 61 40 92 64', Uri(
                scheme: 'tel',
                path: '+4561409264',
              )),
              const SizedBox(
                height: 10,
              ),
              buildSideBySideTextWithUrlAction('Safemail:', 'safe@fastaval.dk', Uri(
                scheme: 'mailto',
                path: 'safe@fastaval.dk',
              )),
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
                children: <Widget>[
                  buildSideBySideText('Netværk:', 'Undervisning'),
                  buildSideBySideText('Brugernavn:', 'mfg-guest@mf-gym.dk', true),
                  buildSideBySideText('Kode:', 'Teleskop2022', true),
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
                    buildSideBySideText('Onsdag:', 'kl. 15:00 - 21:00'),
                    buildSideBySideText('Tor-lør:', 'kl. 09:00 - 21:00'),
                    buildSideBySideText('Søndag:', 'kl. 09:00 - 17:00'),
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
                    buildSideBySideText('Ons-søn:', 'kl. 09:00 - 23:00'),
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
                    buildSideBySideText('Ons-lør:', 'kl. 09:00 - 02:00'),
                    buildSideBySideText('søndag:', 'kl. 09:00 - 15:00'),
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
                    buildSideBySideText('Ons-lør:', 'kl. 09:00 - 00:00'),
                    buildSideBySideText('Søndag:', 'kl. 09:00 - 17:00'),
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
                    buildSideBySideText('Ons-søn:', 'kl. 17:00 - 02:00'),
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
                    buildSideBySideText('Onsdag:', 'kl. 16:00 - 02:00'),
                    buildSideBySideText('Tor-søn:', 'kl. 12:00 - 02:00'),
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
                  children: <Widget>[
                    buildSideBySideText('Onsdag:', 'kl. 16.00 - 23.00'),
                    buildSideBySideText('Tors-lør:', 'kl. 10.00 - 23.00'),
                    buildSideBySideText('Søndag:', 'kl. 10.00 - 15.00'),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                const Text(
                  'Tier1MTG i A07',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'OpenSans',
                  ),
                ),
                Column(
                  children: <Widget>[
                    buildSideBySideText('Ons-søn:', 'kl. 10.00 - 22.00'),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                const Text(
                  'Corra Design i fællesområdet',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'OpenSans',
                  ),
                ),
                Column(
                  children: <Widget>[
                    buildSideBySideText('Fre-søn:', 'kl. 10.00 - 16.00'),
                  ],
                ),
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
            children: <Widget>[
              const SizedBox(height: 5),
              const Text(
                  "Parkering kan gøres på Gymnasiets eller Idrætscenterets Parkeringsplads.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: 'OpenSans',
                )
              ),
              const SizedBox(height: 10),
              const Text("Hobro Togstation er ca. 2,5 km fra Fastaval.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'OpenSans',
                  )),
              const SizedBox(height: 10),
              buildSideBySideTextWithUrlAction('Hobro Taxa:', '+45 98 51 23 00', Uri(
                scheme: 'tel',
                path: '+4598512300',
              )),
              const SizedBox(height: 10),
              buildSideBySideTextWithUrlAction('Krone Taxa:', '+45 98 52 11 11', Uri(
                scheme: 'tel',
                path: '+4598521111',
              )),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildSideBySideTextWithUrlAction(String title, String link, Uri launchUrl) {
  return Row(
    children: <Widget>[
      Expanded(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
      Expanded(
        child: GestureDetector(
          onTap: () {
            canLaunch(launchUrl.toString()).then((bool result) async {
              if (result) {
                await launch(launchUrl.toString());
              }
            });
          },
          child: Text(
            launchUrl.path,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildSideBySideText(String left, String right, [bool? selectable]) {
  selectable = selectable ?? false;
  return Row(
    children: <Widget>[
      Expanded(
        child: Text(
          left,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
      Expanded(
        child: selectable
            ? SelectableText(
                right,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: 'OpenSans',
                ),
              )
            : Text(
                right,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: 'OpenSans',
              ),
        ),
      ),
    ],
  );
}