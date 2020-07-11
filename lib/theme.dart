import 'dart:ui';

import 'package:flutter/material.dart';

const kAppBarShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
);

const kDark = Color(0xFF333333);
const kLight = Color(0xFFFDFDFD);
const kOrange = Color(0xFFFB8C00);

const kBackgroundLight = Color(0xFFF2F3F7);
const kBackgroundDark = Color(0xFF2A2A2A);

const kIconDark = Color(0xFF666666);
const kIconLight = Color(0xFFFBFBFB);

const kDividerDark = Color(0xFF444444);
const kDividerLight = Color(0xFFFFFFFF);

const kTextDark = Color(0xFF333333);
const kTextDarker = Color(0xFF17262A);

const kTextLight = Color(0xFFEEEEEE);
const kTextLighter = Color(0xFFFBFBFB);

ThemeData get theme {
  final base = ThemeData.light();
  return base.copyWith(
    primaryColor: kDark,
    primaryColorLight: kLight,
    accentColor: kOrange,
    appBarTheme: base.appBarTheme.copyWith(
      brightness: Brightness.light,
      color: kLight,
      elevation: 4,
    ),
    buttonColor: kOrange,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kOrange,
    ),
    cardColor: kLight,
    cardTheme: base.cardTheme.copyWith(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    scaffoldBackgroundColor: kBackgroundLight,
    primaryIconTheme: base.iconTheme.copyWith(
      color: kIconDark,
    ),
    toggleableActiveColor: kOrange,
    dividerColor: kDividerDark,
    textTheme: _buildTextTheme(base.textTheme, kTextDark, kTextDarker),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme, kTextDark, kTextDarker),
    accentTextTheme: _buildTextTheme(base.accentTextTheme, kTextDark, kTextDarker),
    snackBarTheme: base.snackBarTheme.copyWith(
      backgroundColor: kLight,
      contentTextStyle: base.textTheme.bodyText1.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 15,
        fontFamily: 'Rubik',
        color: kTextDark,
      ),
    ),
  );
}

ThemeData get darkTheme {
  final base = ThemeData.dark();
  return base.copyWith(
    primaryColor: kLight,
    primaryColorLight: kDark,
    accentColor: kOrange,
    appBarTheme: base.appBarTheme.copyWith(
      brightness: Brightness.dark,
      color: kDark,
      elevation: 4,
    ),
    buttonColor: kOrange,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kOrange,
    ),
    cardColor: kDark,
    cardTheme: base.cardTheme.copyWith(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    scaffoldBackgroundColor: kBackgroundDark,
    primaryIconTheme: base.iconTheme.copyWith(
      color: kIconDark,
    ),
    toggleableActiveColor: kOrange,
    dividerColor: kDividerLight,
    textTheme: _buildTextTheme(base.textTheme, kTextLight, kTextLighter),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme, kTextLight, kTextLighter),
    accentTextTheme: _buildTextTheme(base.accentTextTheme, kTextLight, kTextLighter),
    snackBarTheme: base.snackBarTheme.copyWith(
      backgroundColor: kDark,
      contentTextStyle: base.textTheme.bodyText1.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 15,
        fontFamily: 'Rubik',
        color: kTextLight,
      ),
    ),
  );
}

TextTheme _buildTextTheme(TextTheme base, Color displayColor, Color bodyColor) {
  return base
      .copyWith(
        headline5: base.headline5.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          fontSize: 20,
        ),
        headline6: base.headline6.copyWith(
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          fontSize: 20,
        ),
        bodyText1: base.bodyText1.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
        subtitle1: base.bodyText1.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: displayColor,
        bodyColor: bodyColor,
      );
}
