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

const kCardMargin = EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0);
const kCardPadding = EdgeInsets.all(16.0);

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
