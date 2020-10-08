import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TileColors{
  static Color lightPink = Color(0xfffba8ac);
  static Color magicMint = Color(0xffabf7e0);
  static Color maximumBluePurple = Color(0xff99abfb);
  static Color celeste = Color(0xffb6f6fc);
  static Color maximumYellowRed = Color(0xfff6bd60); 
}

class MainColors{
  static Color fieryRose = Color(0xfffb5d64);
  static Color zomp = Color(0xff43aa8b);
  static Color neonBlue = Color(0xff4d6cfa);
  static Color lavendarBlush = Color(0xfffde8e9);
  static Color richBlackFogra = Color(0xff161925);
  static MaterialColor fieryRoseMaterialColor  = MaterialColor(
    0xfffb5d64,
    {
      50 : Color(0xfffff0f1),
      100 : Color(0xfffedcdd),
      200 : Color(0xfffdbfc1),
      300 : Color(0xfffc9c9f),
      400 : Color(0xfffc7e84),
      500 : Color(0xfffb5d64),
      600 : Color(0xfffa3842),
      700 : Color(0xfff91a25),
      800 : Color(0xffea0611),
      900 : Color(0xffc7050f),
    }
  );
}

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: MainColors.fieryRoseMaterialColor,
    // backgroundColor: MainColors.lavendarBlush,
    // scaffoldBackgroundColor: MainColors.lavendarBlush,
    // dialogBackgroundColor: MainColors.lavendarBlush,
    textTheme: GoogleFonts.ptSansTextTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}