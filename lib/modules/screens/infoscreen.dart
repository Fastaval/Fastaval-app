import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/constants/styleconstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildSideBySideText(String left, String right,
    [bool selectable = false]) {
  return Row(
    children: <Widget>[
      Expanded(
        flex: 4,
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
        flex: 6,
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

Widget buildSideBySideTextWithUrlAction(String title, String link, Uri url) {
  return Row(
    children: <Widget>[
      Expanded(
        flex: 11,
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
        flex: 9,
        child: GestureDetector(
          onTap: () {
            canLaunchUrl(url).then((bool result) async {
              if (result) {
                await launchUrl(url);
              }
            });
          },
          child: Text(
            url.path,
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

Widget _buildFastaWaer() {
  return SizedBox(
    width: double.infinity,
    child: Card(
      margin: kCardMargin,
      elevation: 5,
      child: Padding(
        padding: kCardPadding,
        child: ListTile(
          trailing: const Icon(Icons.person),
          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
          title: Text(
            tr('info.fastaWear.title'),
            style: const TextStyle(
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
              children: <Widget>[
                Text(
                  tr('info.fastaWear.text'),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'OpenSans',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildLostFound() {
  return SizedBox(
    width: double.infinity,
    child: Card(
      margin: kCardMargin,
      elevation: 5,
      child: Padding(
        padding: kCardPadding,
        child: ListTile(
          trailing: const Icon(Icons.move_to_inbox),
          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
          title: Text(
            tr('info.lostAndFound.title'),
            style: const TextStyle(
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
              children: <Widget>[
                Text(
                  tr('info.lostAndFound.text'),
                  style: const TextStyle(
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

Widget _buildOpenHours() {
  return SizedBox(
    width: double.infinity,
    child: Card(
      margin: kCardMargin,
      elevation: 5,
      child: Padding(
        padding: kCardPadding,
        child: ListTile(
          trailing: const Icon(Icons.access_time),
          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
          title: Text(
            tr('info.openHours.title'),
            style: const TextStyle(
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
                Text(
                  tr('info.openHours.information.title'),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: <Widget>[
                    buildSideBySideText(
                        tr('info.openHours.information.day1'), "15.00 - 20.30"),
                    buildSideBySideText(
                        tr('info.openHours.information.day2'), "09.30 - 20.30"),
                    buildSideBySideText(
                        tr('info.openHours.information.day3'), "09.30 - 17.00"),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  tr('info.openHours.coffeeCafe.title'),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: <Widget>[
                    buildSideBySideText(
                        tr('info.openHours.coffeeCafe.day1'), "11.30 - 01.00"),
                    buildSideBySideText(
                        tr('info.openHours.coffeeCafe.day2'), "09.00 - 01.00"),
                    buildSideBySideText(
                        tr('info.openHours.coffeeCafe.day3'), "09.00 - 15.00"),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  tr('info.openHours.boardGames.title'),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: <Widget>[
                    buildSideBySideText(
                        tr('info.openHours.boardGames.day1'), "09.00 - 02.00"),
                    buildSideBySideText(
                        tr('info.openHours.boardGames.day2'), "09.00 - 15.00"),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  tr('info.openHours.kiosk.title'),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: <Widget>[
                    buildSideBySideText(
                        tr('info.openHours.kiosk.day1'), "08.00 - 00.00"),
                    buildSideBySideText(
                        tr('info.openHours.kiosk.day2'), "08.00 - 16.00"),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  tr('info.openHours.bar.title'),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: <Widget>[
                    buildSideBySideText(
                        tr('info.openHours.bar.day1'), "17.00 - 02.00"),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  tr('info.openHours.oasis.title'),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: <Widget>[
                    buildSideBySideText(
                        tr('info.openHours.oasis.day1'), "15.00 - 02.00"),
                    buildSideBySideText(
                        tr('info.openHours.oasis.day2'), "12.00 - 02.00"),
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

Widget _buildSafeFastaval() {
  return SizedBox(
    width: double.infinity,
    child: Card(
      margin: kCardMargin,
      elevation: 5,
      child: Padding(
        padding: kCardPadding,
        child: ListTile(
          trailing: const Icon(Icons.phone),
          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
          title: Text(
            tr('info.safe.title'),
            style: const TextStyle(
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
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                buildSideBySideTextWithUrlAction(
                    tr('info.safe.dutyGeneral'),
                    "+4561409065",
                    Uri(
                      scheme: 'tel',
                      path: "+4561409065",
                    )),
                const SizedBox(
                  height: 10,
                ),
                buildSideBySideTextWithUrlAction(
                    tr('info.safe.heroForce'),
                    "+4561409263",
                    Uri(
                      scheme: 'tel',
                      path: "+4561409263",
                    )),
                const SizedBox(
                  height: 10,
                ),
                buildSideBySideTextWithUrlAction(
                    tr('info.safe.safetyHost'),
                    "+4561409264",
                    Uri(
                      scheme: 'tel',
                      path: "+4561409264",
                    )),
                const SizedBox(
                  height: 10,
                ),
                buildSideBySideTextWithUrlAction(
                    tr('info.safe.safetyMail'),
                    "safe@fastaval.dk",
                    Uri(
                      scheme: 'mailto',
                      path: "safe@fastaval.dk",
                    )),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildStores() {
  return SizedBox(
    width: double.infinity,
    child: Card(
      margin: kCardMargin,
      elevation: 5,
      child: Padding(
        padding: kCardPadding,
        child: ListTile(
          trailing: const Icon(Icons.store),
          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
          title: Text(
            tr('info.stores.title'),
            style: const TextStyle(
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
              children: <Widget>[
                Text(
                  tr('info.stores.store1.title'),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: <Widget>[
                    buildSideBySideText(tr('info.stores.store1.day1.text'),
                        tr('info.stores.store1.day1.value')),
                    buildSideBySideText(tr('info.stores.store1.day2.text'),
                        tr('info.stores.store1.day2.value')),
                    buildSideBySideText(tr('info.stores.store1.day3.text'),
                        tr('info.stores.store1.day3.value')),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  tr('info.stores.store2.title'),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: <Widget>[
                    buildSideBySideText(tr('info.stores.store2.day1.text'),
                        tr('info.stores.store2.day1.value')),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  tr('info.stores.store3.title'),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: <Widget>[
                    buildSideBySideText(tr('info.stores.store3.day1.text'),
                        tr('info.stores.store3.day1.value')),
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

Widget _buildTransport() {
  return SizedBox(
    width: double.infinity,
    child: Card(
      margin: kCardMargin,
      elevation: 5,
      child: Padding(
        padding: kCardPadding,
        child: ListTile(
          trailing: const Icon(Icons.local_parking),
          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
          title: Text(
            tr('info.transportAndParking.title'),
            style: const TextStyle(
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
              children: <Widget>[
                const SizedBox(height: 5),
                Text(tr('info.transportAndParking.text'),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                    )),
                buildSideBySideTextWithUrlAction(
                    tr('info.transportAndParking.taxi1.text'),
                    tr('info.transportAndParking.taxi1.value'),
                    Uri(
                      scheme: 'tel',
                      path: tr('info.transportAndParking.taxi1.value'),
                    )),
                const SizedBox(height: 10),
                buildSideBySideTextWithUrlAction(
                    tr('info.transportAndParking.taxi2.text'),
                    tr('info.transportAndParking.taxi2.value'),
                    Uri(
                      scheme: 'tel',
                      path: tr('info.transportAndParking.taxi2.value'),
                    )),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildWiFi() {
  return SizedBox(
    width: double.infinity,
    child: Card(
      margin: kCardMargin,
      elevation: 5,
      child: Padding(
        padding: kCardPadding,
        child: ListTile(
          trailing: const Icon(Icons.wifi),
          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
          title: Text(
            tr('info.wifi.title'),
            style: const TextStyle(
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
              children: <Widget>[
                buildSideBySideText(
                    tr('info.wifi.networkName'), 'Undervisning'),
                const SizedBox(
                  height: 10,
                ),
                buildSideBySideText(
                    tr('info.wifi.networkUser'), 'mfg-guest@mf-gym.dk', true),
                const SizedBox(
                  height: 10,
                ),
                buildSideBySideText(
                    tr('info.wifi.networkCode'), 'Teleskop2022', true),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

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
                      _buildWiFi(),
                      _buildOpenHours(),
                      _buildStores(),
                      _buildFastaWaer(),
                      _buildLostFound(),
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
