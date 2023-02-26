import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/constants/app_constants.dart';
import 'package:fastaval_app/constants/style_constants.dart';
import 'package:fastaval_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

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

Widget _buildOpenHoursCard() {
  return textAndIconCard(
      tr('info.openHours.title'),
      Icons.access_time,
      Column(
        children: [
          textRowHeader(tr('info.openHours.bar.title')),
          sideBySideTextRow(tr('info.openHours.bar.day1'),
              kServiceOpeningHours["bar"]!["day1"]!,
              sidePadding: true),
          const SizedBox(height: 10),
          textRowHeader(tr('info.openHours.boardGames.title')),
          sideBySideTextRow(tr('info.openHours.boardGames.day1'),
              kServiceOpeningHours["boardGames"]!["day1"]!,
              sidePadding: true),
          sideBySideTextRow(tr('info.openHours.boardGames.day2'),
              kServiceOpeningHours["boardGames"]!["day2"]!,
              sidePadding: true),
          const SizedBox(height: 10),
          textRowHeader(tr('info.openHours.kiosk.title')),
          sideBySideTextRow(tr('info.openHours.kiosk.day1'),
              kServiceOpeningHours["kiosk"]!["day1"]!,
              sidePadding: true),
          sideBySideTextRow(tr('info.openHours.kiosk.day2'),
              kServiceOpeningHours["kiosk"]!["day2"]!,
              sidePadding: true),
          const SizedBox(height: 10),
          textRowHeader(tr('info.openHours.oasis.title')),
          sideBySideTextRow(tr('info.openHours.oasis.day1'),
              kServiceOpeningHours["oasis"]!["day1"]!,
              sidePadding: true),
          sideBySideTextRow(tr('info.openHours.oasis.day2'),
              kServiceOpeningHours["oasis"]!["day2"]!,
              sidePadding: true),
          const SizedBox(height: 10),
          textRowHeader(tr('info.openHours.information.title')),
          sideBySideTextRow(tr('info.openHours.information.day1'),
              kServiceOpeningHours["information"]!["day1"]!,
              sidePadding: true),
          sideBySideTextRow(tr('info.openHours.information.day2'),
              kServiceOpeningHours["information"]!["day2"]!,
              sidePadding: true),
          sideBySideTextRow(tr('info.openHours.information.day3'),
              kServiceOpeningHours["information"]!["day3"]!,
              sidePadding: true),
          const SizedBox(height: 10),
          textRowHeader(tr('info.openHours.coffeeCafe.title')),
          sideBySideTextRow(tr('info.openHours.coffeeCafe.day1'),
              kServiceOpeningHours["coffeeCafe"]!["day1"]!,
              sidePadding: true),
          sideBySideTextRow(tr('info.openHours.coffeeCafe.day2'),
              kServiceOpeningHours["coffeeCafe"]!["day2"]!,
              sidePadding: true),
          sideBySideTextRow(tr('info.openHours.coffeeCafe.day3'),
              kServiceOpeningHours["coffeeCafe"]!["day3"]!,
              sidePadding: true),
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
          sideBySideTextRow(tr('info.stores.store1.day1'),
              kStoreOpeningHours["store1"]!["day1"]!,
              sidePadding: true),
          sideBySideTextRow(tr('info.stores.store1.day2'),
              kStoreOpeningHours["store1"]!["day2"]!,
              sidePadding: true),
          sideBySideTextRow(tr('info.stores.store1.day3'),
              kStoreOpeningHours["store1"]!["day3"]!,
              sidePadding: true),
          const SizedBox(height: 10),
          textRowHeader(tr('info.stores.store2.title')),
          sideBySideTextRow(tr('info.stores.store2.day1'),
              kStoreOpeningHours["store2"]!["day1"]!,
              sidePadding: true),
          const SizedBox(height: 10),
          textRowHeader(tr('info.stores.store3.title')),
          sideBySideTextRow(tr('info.stores.store3.day1'),
              kStoreOpeningHours["store3"]!["day1"]!,
              sidePadding: true)
        ],
      ));
}

Widget _buildFastaWearCard() {
  return textAndIconCard(
    tr('info.fastaWear.title'),
    Icons.person,
    Text(tr('info.fastaWear.text'), style: kNormalTextStyle),
  );
}

Widget _buildLostFoundCard() {
  return textAndIconCard(
    tr('info.lostAndFound.title'),
    Icons.move_to_inbox,
    Text(tr('info.lostAndFound.text'), style: kNormalTextStyle),
  );
}

Widget _buildTransportCard() {
  return textAndIconCard(
      tr('info.transportAndParking.title'),
      Icons.local_parking,
      Column(
        children: [
          Text(tr('info.transportAndParking.text'), style: kNormalTextStyle),
          const SizedBox(height: 20),
          buildSideBySideTextWithUrlAction(tr('info.transportAndParking.taxi1'),
              kTaxi1PhoneNumber, Uri(scheme: 'tel', path: kTaxi1PhoneNumber)),
          const SizedBox(height: 20),
          buildSideBySideTextWithUrlAction(tr('info.transportAndParking.taxi2'),
              kTaxi2PhoneNumber, Uri(scheme: 'tel', path: kTaxi2PhoneNumber))
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
                decoration: backgroundBoxDecorationStyle,
              ),
              SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
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
