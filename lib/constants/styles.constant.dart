import 'package:flutter/material.dart';

const kHintTextStyle = TextStyle(color: colorWhite, fontFamily: 'OpenSans');
const kLabelStyle = TextStyle(
    color: colorWhite, fontWeight: FontWeight.bold, fontFamily: 'OpenSans');
final kTextBoxDecorationStyle = BoxDecoration(
  color: colorOrangeDark,
  border: Border.all(color: Colors.black12, width: 2),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(color: Colors.black12, blurRadius: 6.0, offset: Offset(0, 2))
  ],
);
const kCardMargin = EdgeInsets.fromLTRB(16, 16, 16, 0);
const kCardPadding = EdgeInsets.all(16.0);
const kCardContentPadding = EdgeInsets.fromLTRB(16, 0, 16, 16);
const double kCardElevation = 5;
const kNormalTextStyle =
    TextStyle(color: Colors.black, fontSize: 16.0, fontFamily: 'OpenSans');
const kNormalTextClickableStyle = TextStyle(
  color: colorBlack,
  fontSize: 16.0,
  fontFamily: 'OpenSans',
  decoration: TextDecoration.underline,
  decorationColor: Colors.black45,
);
const kNormalTextBoldStyle = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold);
const kCardHeaderStyle = TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans');
const kNormalTextSubdued =
    TextStyle(color: Colors.black54, fontSize: 12, fontFamily: 'OpenSans');
const kNormalTextDisabled =
    TextStyle(color: Colors.black26, fontSize: 12, fontFamily: 'OpenSans');
const backgroundBoxDecorationStyle = BoxDecoration(
  image: DecorationImage(
    image: AssetImage('assets/images/backgrounds/background.jpg'),
    fit: BoxFit.cover,
  ),
);

const colorBlack = Color(0xFF000000);
const colorWhite = Color(0xFFFFFFFF);
const colorOrangeLight = Color(0xFFFFD391);
const colorOrange = Color(0xFFF9AD1B);
const colorOrangeDark = Color(0xFFFF9700);
const colorLightBlue = Color(0xFFC9ECFF);
const colorGrey = Color(0xFFDFE0DF);
