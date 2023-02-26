import 'package:flutter/material.dart';

const kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

const kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kTextBoxDecorationStyle = BoxDecoration(
  color: const Color(0xFFFFA726),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

const kCardMargin = EdgeInsets.all(16);
const kCardPadding = EdgeInsets.all(16.0);
const kCardContentPadding = EdgeInsets.fromLTRB(16, 0, 16, 16);
const double kCardElevation = 10;
const kNormalTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 16.0,
  fontFamily: 'OpenSans',
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
const backgroundBoxDecorationStyle = BoxDecoration(
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
);
