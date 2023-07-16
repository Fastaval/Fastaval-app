import 'package:easy_localization/easy_localization.dart';
import 'package:fastaval_app/constants/app.constant.dart';
import 'package:fastaval_app/constants/styles.constant.dart';
import 'package:fastaval_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget _buildFastaWearCard() {
  return textAndIconCard(tr('info.fastaWear.title'), Icons.person,
      Text(tr('info.fastaWear.text'), style: kNormalTextStyle));
}

Widget _buildLostFoundCard() {
  return textAndIconCard(tr('info.lostAndFound.title'), Icons.move_to_inbox,
      Text(tr('info.lostAndFound.text'), style: kNormalTextStyle));
}

Widget _buildOpenHoursCard() {
  return textAndIconCard(
      tr('info.openHours.title'),
      Icons.access_time,
      Column(children: [
        textRowHeader(tr('info.openHours.bar.title')),
        twoTextRow(tr('info.openHours.bar.day1'),
            kServiceOpeningHours["bar"]!["day1"]!,
            sidePadding: true),
        const SizedBox(height: 10),
        textRowHeader(tr('info.openHours.boardGames.title')),
        twoTextRow(tr('info.openHours.boardGames.day1'),
            kServiceOpeningHours["boardGames"]!["day1"]!,
            sidePadding: true),
        twoTextRow(tr('info.openHours.boardGames.day2'),
            kServiceOpeningHours["boardGames"]!["day2"]!,
            sidePadding: true),
        const SizedBox(height: 10),
        textRowHeader(tr('info.openHours.kiosk.title')),
        twoTextRow(tr('info.openHours.kiosk.day1'),
            kServiceOpeningHours["kiosk"]!["day1"]!,
            sidePadding: true),
        twoTextRow(tr('info.openHours.kiosk.day2'),
            kServiceOpeningHours["kiosk"]!["day2"]!,
            sidePadding: true),
        const SizedBox(height: 10),
        textRowHeader(tr('info.openHours.oasis.title')),
        twoTextRow(tr('info.openHours.oasis.day1'),
            kServiceOpeningHours["oasis"]!["day1"]!,
            sidePadding: true),
        twoTextRow(tr('info.openHours.oasis.day2'),
            kServiceOpeningHours["oasis"]!["day2"]!,
            sidePadding: true),
        const SizedBox(height: 10),
        textRowHeader(tr('info.openHours.information.title')),
        twoTextRow(tr('info.openHours.information.day1'),
            kServiceOpeningHours["information"]!["day1"]!,
            sidePadding: true),
        twoTextRow(tr('info.openHours.information.day2'),
            kServiceOpeningHours["information"]!["day2"]!,
            sidePadding: true),
        twoTextRow(tr('info.openHours.information.day3'),
            kServiceOpeningHours["information"]!["day3"]!,
            sidePadding: true),
        const SizedBox(height: 10),
        textRowHeader(tr('info.openHours.coffeeCafe.title')),
        twoTextRow(tr('info.openHours.coffeeCafe.day1'),
            kServiceOpeningHours["coffeeCafe"]!["day1"]!,
            sidePadding: true),
        twoTextRow(tr('info.openHours.coffeeCafe.day2'),
            kServiceOpeningHours["coffeeCafe"]!["day2"]!,
            sidePadding: true),
        twoTextRow(tr('info.openHours.coffeeCafe.day3'),
            kServiceOpeningHours["coffeeCafe"]!["day3"]!,
            sidePadding: true),
      ]));
}

Widget _buildSafeFastavalCard() {
  return textAndIconCard(
      tr('info.safe.title'),
      Icons.phone,
      Column(children: [
        twoTextRowWithTapAction(
            tr('info.safe.dutyGeneral'),
            kDutyGeneralPhoneNumber,
            Uri(scheme: 'tel', path: kDutyGeneralPhoneNumber)),
        const SizedBox(height: 10),
        twoTextRowWithTapAction(
            tr('info.safe.heroForce'),
            kHeroForcePhoneNumber,
            Uri(scheme: 'tel', path: kHeroForcePhoneNumber)),
        const SizedBox(height: 10),
        twoTextRowWithTapAction(
            tr('info.safe.safetyHost'),
            kSafetyHostPhoneNumber,
            Uri(scheme: 'tel', path: kSafetyHostPhoneNumber)),
        const SizedBox(height: 10),
        twoTextRowWithTapAction(tr('info.safe.safetyMail'), kSafeFastavalMail,
            Uri(scheme: 'mailto', path: kSafeFastavalMail)),
      ]));
}

Widget _buildStoresCard() {
  return textAndIconCard(
      tr('info.stores.title'),
      Icons.store,
      Column(children: [
        textRowHeader(tr('info.stores.store1.title')),
        twoTextRow(tr('info.stores.store1.day1'),
            kStoreOpeningHours["store1"]!["day1"]!,
            sidePadding: true),
        const SizedBox(height: 10),
        textRowHeader(tr('info.stores.store2.title')),
        twoTextRow(tr('info.stores.store2.day1'),
            kStoreOpeningHours["store2"]!["day1"]!,
            sidePadding: true),
        const SizedBox(height: 10),
        textRowHeader(tr('info.stores.store3.title')),
        twoTextRow(tr('info.stores.store3.day1'),
            kStoreOpeningHours["store3"]!["day1"]!,
            sidePadding: true),
      ]));
}

Widget _buildTransportCard() {
  return textAndIconCard(
      tr('info.transportAndParking.title'),
      Icons.local_parking,
      Column(
        children: [
          Text(tr('info.transportAndParking.text'), style: kNormalTextStyle),
          const SizedBox(height: 20),
          twoTextRowWithTapAction(tr('info.transportAndParking.taxi1'),
              kTaxi1PhoneNumber, Uri(scheme: 'tel', path: kTaxi1PhoneNumber)),
          const SizedBox(height: 20),
          twoTextRowWithTapAction(tr('info.transportAndParking.taxi2'),
              kTaxi2PhoneNumber, Uri(scheme: 'tel', path: kTaxi2PhoneNumber))
        ],
      ));
}

Widget _buildWifiCard() {
  return textAndIconCard(
      tr('info.wifi.title'),
      Icons.wifi,
      Column(children: [
        twoTextRow(tr('info.wifi.networkName'), kWifiNetworkName),
        const SizedBox(height: 10),
        twoTextRow(tr('info.wifi.networkUser'), kWifiUser, selectable: true),
        const SizedBox(height: 10),
        twoTextRow(tr('info.wifi.networkCode'), kWifiPassword, selectable: true)
      ]));
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
    ));
  }
}
