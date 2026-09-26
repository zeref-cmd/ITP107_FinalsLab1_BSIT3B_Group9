import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();
  static const purple = Color(0xFF6B3FE7);
  static const purple2 = Color(0xFF8A54F4);
  static const purpleDeep = Color(0xFF352080);
  static const purpleDark = purpleDeep;
  static const cream2 = white;
  static const lavender = Color(0xFFE6DCFF);
  static const lavenderSoft = Color(0xFFF1ECFF);
  static const purpleGradient = buttonGradient;
  static const purpleText = Color(0xFF29206B);
  static const cream = Color(0xFFFFF8E9);
  static const white = Color(0xFFFFFEFC);
  static const border = Color(0xFFE8E0F1);
  static const muted = Color(0xFF8A82A5);
  static const success = Color(0xFF8C91A8);
  static const error = Color(0xFFD64C62);

  static const headerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF3D218F), Color(0xFF6E42DF), Color(0xFF8650F0)],
  );
  static const buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF7B43F1), Color(0xFF5D2DCE)],
  );
}

class AppText {
  AppText._();
  static TextStyle get logo => GoogleFonts.baloo2(fontSize: 46, height: .9, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -1.2);
  static TextStyle get topSubtitle => GoogleFonts.nunito(fontSize: 12.5, fontWeight: FontWeight.w800, color: Colors.white.withOpacity(.95));
  static TextStyle get heading => GoogleFonts.baloo2(fontSize: 27, height: 1, fontWeight: FontWeight.w900, color: AppColors.purpleText);
  static TextStyle get subheading => GoogleFonts.nunito(fontSize: 13.5, height: 1.25, fontWeight: FontWeight.w600, color: AppColors.muted);
  static TextStyle get label => GoogleFonts.nunito(fontSize: 11.5, fontWeight: FontWeight.w900, color: AppColors.purpleText);
  static TextStyle get input => GoogleFonts.nunito(fontSize: 13.5, fontWeight: FontWeight.w700, color: AppColors.purpleText);
  static TextStyle get hint => GoogleFonts.nunito(fontSize: 13.5, fontWeight: FontWeight.w600, color: AppColors.muted);
  static TextStyle get button => GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white);
  static TextStyle get footer => GoogleFonts.nunito(fontSize: 10.5, height: 1.3, fontWeight: FontWeight.w700, color: AppColors.muted);
  static TextStyle get footerLink => GoogleFonts.nunito(fontSize: 10.5, fontWeight: FontWeight.w900, color: AppColors.purple);
  static TextStyle get requirement => GoogleFonts.nunito(fontSize: 10.5, fontWeight: FontWeight.w700, color: AppColors.muted);
  static TextStyle get error => GoogleFonts.nunito(fontSize: 10.5, fontWeight: FontWeight.w800, color: AppColors.error);
}

ThemeData buildWorlyTheme() => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.cream,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.purple),
  fontFamily: GoogleFonts.nunito().fontFamily,
);
