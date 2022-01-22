import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const darkBackgroundColor = Color(0xff1F1D2C);
  static const darkSecondaryBackgroundColor = Color(0xff262837);

  static Color lightBackgroundColor = Colors.blue.shade50;
  static Color lightSecondaryBackgroundColor = Colors.blue.shade50;
  var darkTheme = ThemeData(
      backgroundColor: darkSecondaryBackgroundColor,
      primaryColor: Colors.green,
      scaffoldBackgroundColor: darkSecondaryBackgroundColor,
      canvasColor: darkSecondaryBackgroundColor,
     textTheme:darkTextTheme,
      cardColor: darkBackgroundColor,

      appBarTheme: const AppBarTheme(
        backgroundColor: darkSecondaryBackgroundColor,
        elevation: 1,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white, opacity: .9),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4),
      ));

  var lightTheme = ThemeData(
      backgroundColor: lightSecondaryBackgroundColor,
      primaryColor: Colors.green,
      scaffoldBackgroundColor: lightSecondaryBackgroundColor,
      canvasColor: lightSecondaryBackgroundColor,
      textTheme:lightTextTheme,
      cardColor: lightSecondaryBackgroundColor,
      appBarTheme:  AppBarTheme(
        backgroundColor: lightBackgroundColor,
        elevation: 1,
        shadowColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black, opacity: .9),
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4),
      ));
}

var lightTextTheme =   TextTheme(
  headline1: GoogleFonts.jetBrainsMono(
      fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5,color: Colors.black),
  headline2: GoogleFonts.jetBrainsMono(
      fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5,color: Colors.black87),
  headline3: GoogleFonts.jetBrainsMono(fontSize: 48, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.jetBrainsMono(
      fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.jetBrainsMono(fontSize: 24, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.jetBrainsMono(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.jetBrainsMono(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.jetBrainsMono(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.jetBrainsMono(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5,color: Colors.black),
  bodyText2: GoogleFonts.jetBrainsMono(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25,color: Colors.black),
  button: GoogleFonts.jetBrainsMono(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.jetBrainsMono(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.jetBrainsMono(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

var darkTextTheme = TextTheme(
  headline1: GoogleFonts.jetBrainsMono(
    fontSize: 97,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    color: Colors.white,
  ),
  headline2: GoogleFonts.jetBrainsMono(
      fontSize: 61,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: Colors.white70),
  headline3: GoogleFonts.jetBrainsMono(
      fontSize: 48, fontWeight: FontWeight.w400, color: Colors.black),
  headline4: GoogleFonts.jetBrainsMono(
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.black87),
  headline5:
      GoogleFonts.jetBrainsMono(fontSize: 24, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.jetBrainsMono(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.jetBrainsMono(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.jetBrainsMono(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.jetBrainsMono(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Colors.white),
  bodyText2: GoogleFonts.jetBrainsMono(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.white70),
  button: GoogleFonts.jetBrainsMono(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25,color: Colors.white,),
  caption: GoogleFonts.jetBrainsMono(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4,),
  overline: GoogleFonts.jetBrainsMono(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
