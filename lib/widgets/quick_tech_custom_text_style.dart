
import 'dart:ui';

import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:flutter/src/painting/text_style.dart' ;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';



class QuickTechAppTextStyle {
  static TextStyle headline1() {
    return GoogleFonts.merriweather(
      textStyle: TextStyle(
        fontWeight: FontWeight.w900,
        color: QuickTechAppColors.black,
        fontSize: 30.w,
      ),
    );
  }
  static TextStyle headline2() {
    return GoogleFonts.merriweather(
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: QuickTechAppColors.black,
        fontSize: 24,
      ),
    );
  }
  static TextStyle headline3() {
    return GoogleFonts.merriweather(
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: QuickTechAppColors.black,
        fontSize: 18,
      ),
    );
  }
  static TextStyle headline4() {
    return GoogleFonts.merriweather(
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: QuickTechAppColors.black,
        fontSize: 15,
      ),
    );
  }
  static TextStyle bodyText1() {
    return GoogleFonts.merriweather(
      textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: QuickTechAppColors.black,
        fontSize: 15,
      ),
    );
  }
  static TextStyle bodyText2() {
    return GoogleFonts.merriweather(
      textStyle: TextStyle(
        fontWeight: FontWeight.normal,
        color: QuickTechAppColors.grey,
        fontSize: 15,
      ),
    );
  }
  static TextStyle bodyText3() {
    return GoogleFonts.merriweather(
      textStyle: TextStyle(
        fontWeight: FontWeight.normal,
        color: QuickTechAppColors.grey,
        fontSize: 14,
      ),
    );
  }
  static TextStyle buttonText() {
    return GoogleFonts.merriweather(
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: QuickTechAppColors.white,
        fontSize: 16,
      ),
    );
  }
}