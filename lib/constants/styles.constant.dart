import 'package:flutter/material.dart';

BoxDecoration kTextBoxDecorationStyle = BoxDecoration(
  color: colorOrangeDark,
  border: Border.all(color: Colors.black12, width: 2),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(color: Colors.black12, blurRadius: 6.0, offset: Offset(0, 2))
  ],
);
BoxDecoration backgroundBoxDecorationStyle = BoxDecoration(
  image: DecorationImage(
      image: AssetImage('assets/images/background.jpg'), fit: BoxFit.cover),
);

double kCardElevation = 5;

EdgeInsets kCardMargin = EdgeInsets.fromLTRB(16, 8, 16, 0);
EdgeInsets kMenuCardMargin = EdgeInsets.fromLTRB(16, 16, 16, 0);
EdgeInsets kCardPadding = EdgeInsets.all(16.0);
EdgeInsets kCardContentPadding = EdgeInsets.fromLTRB(16, 0, 16, 16);

TextStyle kHintTextStyle = TextStyle(color: colorWhite);
TextStyle kTabBarTextStyle = TextStyle(color: colorWhite, fontSize: 16);
TextStyle kNormalTextStyle = TextStyle(color: Colors.black, fontSize: 16.0);
TextStyle kNormalTextDisabled = TextStyle(color: Colors.black26, fontSize: 16);
TextStyle kLabelStyle =
    TextStyle(color: colorBlack, fontWeight: FontWeight.bold);
TextStyle kAppBarTextStyle =
    TextStyle(color: colorWhite, fontSize: 16, fontWeight: FontWeight.bold);
TextStyle kNormalTextBoldStyle =
    TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold);
TextStyle kCardHeaderStyle =
    TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold);
TextStyle kMenuCardHeaderStyle =
    TextStyle(color: colorBlack, fontWeight: FontWeight.bold);
TextStyle kNormalTextSubdued =
    TextStyle(color: colorBlack, fontSize: 10, fontWeight: FontWeight.normal);
TextStyle kNormalTextSubduedExpired = TextStyle(
    color: Colors.black26, fontSize: 10, fontWeight: FontWeight.normal);
TextStyle kNormalTextClickableStyle = TextStyle(
  color: colorBlack,
  fontSize: 16.0,
  decoration: TextDecoration.underline,
  decorationColor: Colors.black45,
);

Color colorBlack = Color(0xFF000000);
Color colorWhite = Color(0xFFFFFFFF);
Color colorOrangeLight = Color(0xFFFFD391);
Color colorOrange = Color(0xFFF9AD1B);
Color colorOrangeDark = Color(0xFFFF9700);
Color colorLightBlue = Color(0xFFC9ECFF);
Color colorGrey = Color(0xFFDFE0DF);
