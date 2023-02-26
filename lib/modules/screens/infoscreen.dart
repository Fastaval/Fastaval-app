import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/constants/app_constants.dart';
import 'package:fastaval_app/constants/style_constants.dart';
import 'package:fastaval_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

Widget textRowHeader(String text) {
  return Row(children: [Text(text, style: kNormalTextBoldStyle)]);
}

Widget sideBySideTextRow(String textLeft, String textRight,
    {bool selectable = false, bool sidePadding = false}) {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: sidePadding ? 16 : 0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(textLeft, style: kNormalTextStyle),
          ),
          Expanded(
            flex: 6,
            child: selectable
                ? SelectableText(textRight,
                    textAlign: TextAlign.right, style: kNormalTextStyle)
                : Text(textRight,
                    textAlign: TextAlign.right, style: kNormalTextStyle),
          ),
        ],
      ));
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

Widget _buildFastaWearCard() {
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

Widget _buildLostFoundCard() {
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

Widget _buildOpenHoursCard() {
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
                    sideBySideTextRow(
                        tr('info.openHours.information.day1'), "15.00 - 20.30"),
                    sideBySideTextRow(
                        tr('info.openHours.information.day2'), "09.30 - 20.30"),
                    sideBySideTextRow(
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
                    sideBySideTextRow(
                        tr('info.openHours.coffeeCafe.day1'), "11.30 - 01.00"),
                    sideBySideTextRow(
                        tr('info.openHours.coffeeCafe.day2'), "09.00 - 01.00"),
                    sideBySideTextRow(
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
                    sideBySideTextRow(
                        tr('info.openHours.boardGames.day1'), "09.00 - 02.00"),
                    sideBySideTextRow(
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
                    sideBySideTextRow(
                        tr('info.openHours.kiosk.day1'), "08.00 - 00.00"),
                    sideBySideTextRow(
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
                    sideBySideTextRow(
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
                    sideBySideTextRow(
                        tr('info.openHours.oasis.day1'), "15.00 - 02.00"),
                    sideBySideTextRow(
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

Widget _buildSafeFastavalCard() {
  return textAndIconCard(
      tr('info.safe.title'),
      Icons.phone,
      Column(
        children: [
          buildSideBySideTextWithUrlAction(
              tr('info.safe.dutyGeneral'),
              kDutyGeneralPhoneNumber,
              Uri(scheme: 'tel', path: kDutyGeneralPhoneNumber)),
          const SizedBox(height: 10),
          buildSideBySideTextWithUrlAction(
              tr('info.safe.heroForce'),
              kHeroForcePhoneNumber,
              Uri(scheme: 'tel', path: kHeroForcePhoneNumber)),
          const SizedBox(height: 10),
          buildSideBySideTextWithUrlAction(
              tr('info.safe.safetyHost'),
              kSafetyHostPhoneNumber,
              Uri(scheme: 'tel', path: kSafetyHostPhoneNumber)),
          const SizedBox(height: 10),
          buildSideBySideTextWithUrlAction(
              tr('info.safe.safetyMail'),
              kSafeFastavalMail,
              Uri(scheme: 'mailto', path: kSafeFastavalMail)),
        ],
      ));
}

Widget _buildStoresCard() {
  return textAndIconCard(
      tr('info.stores.title'),
      Icons.store,
      Column(
        children: [
          textRowHeader(tr('info.stores.store1.title')),
          sideBySideTextRow(
              tr('info.stores.store1.day1'), kOpeningHours["store1"]!["day1"]!,
              sidePadding: true),
          sideBySideTextRow(
              tr('info.stores.store1.day2'), kOpeningHours["store1"]!["day2"]!,
              sidePadding: true),
          sideBySideTextRow(
              tr('info.stores.store1.day3'), kOpeningHours["store1"]!["day3"]!,
              sidePadding: true),
          const SizedBox(height: 10),
          textRowHeader(tr('info.stores.store2.title')),
          sideBySideTextRow(
              tr('info.stores.store2.day1'), kOpeningHours["store2"]!["day1"]!,
              sidePadding: true),
          const SizedBox(height: 10),
          textRowHeader(tr('info.stores.store3.title')),
          sideBySideTextRow(
              tr('info.stores.store3.day1'), kOpeningHours["store3"]!["day1"]!,
              sidePadding: true)
        ],
      ));
}

Widget _buildTransportCard() {
  return textAndIconCard(
      tr('info.transportAndParking.title'),
      Icons.local_parking,
      Column(
        children: [
          Text(tr('info.transportAndParking.text'), style: kNormalTextStyle),
          const SizedBox(height: 10),
          buildSideBySideTextWithUrlAction(tr('info.transportAndParking.taxi1'),
              kTaxi1PhoneNumber, Uri(scheme: 'tel', path: kTaxi1PhoneNumber)),
          const SizedBox(height: 20),
          buildSideBySideTextWithUrlAction(tr('info.transportAndParking.taxi2'),
              kTaxi2PhoneNumber, Uri(scheme: 'tel', path: kTaxi2PhoneNumber))
        ],
      ));
}

Widget _buildWifiCard() {
  return textAndIconCard(
      tr('info.wifi.title'),
      Icons.wifi,
      Column(
        children: [
          sideBySideTextRow(tr('info.wifi.networkName'), kWifiNetworkName),
          const SizedBox(height: 10),
          sideBySideTextRow(tr('info.wifi.networkUser'), kWifiUser,
              selectable: true),
          const SizedBox(height: 10),
          sideBySideTextRow(tr('info.wifi.networkCode'), kWifiPassword,
              selectable: true)
        ],
      ));
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
                      _buildSafeFastavalCard(),
                      _buildWifiCard(),
                      _buildOpenHoursCard(),
                      _buildStoresCard(),
                      _buildFastaWearCard(),
                      _buildLostFoundCard(),
                      _buildTransportCard(),
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
