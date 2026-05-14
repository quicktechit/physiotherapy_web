import 'dart:math';
import 'package:flutter/material.dart';

class QuickTechAppColors {
  QuickTechAppColors._(); // Private constructor to prevent instantiation
//light theme
  //static Color get lightmaincolor => const Color(0xff2E8B57);
  static Color get lightmaincolor => const Color(0xffa389bf);
  static Color get lightsecondarycolor =>
      const Color.fromARGB(255, 67, 54, 27);
  static Color get lightmaintextcolor => const Color(0xff212121);
  static Color get lightsecondarytextcolor => const Color(0xff757575);
  static Color get lightScaffoldColor => Colors.white;
  static Color get lightaccentColor => const Color(0xffF16969);
static Color get lighttextcolor =>Colors.black;
  static Color get bktxtfld => Colors.white;
//Dark theme
//static Color get darkmaincolor => const Color(0xff2E8B57); 
static Color get darkmaincolor => const Color(0xff75559E); 
static Color get darksecondarycolor =>  Colors.white.withValues(alpha: 0.1);
static Color get darkmaintextcolor => const Color(0xffE0E0E0); 
static Color get darksecondarytextcolor => const Color(0xffB0B0B0); 
static Color get darkScaffoldColor => const Color(0xff121212); 
static Color get darkaccentColor => const Color.fromARGB(255, 166, 68, 68);
static Color get darktextcolor => Colors.white; 
  //static Color get bkdarktxtfld => Colors.grey.shade800.withValues(alpha: )(0.3);
  static Color get bkdarktxtfld => Color(0xff1F1F1F);





  // Basic Colors
  static Color get black => Colors.black;
  static Color get white => Colors.white;
  static Color get red => Colors.redAccent;
  static Color get grey => Colors.grey;
  static Color get orange => const Color.fromRGBO(246, 165, 48, 1);
  static Color get yellow => const Color.fromRGBO(221, 239, 117, 1);
  static Color get black2 => const Color.fromRGBO(51, 51, 49, 1);

  /*
  static Color get scaffoldColor => Colors.white; 
  static Color get scaffoldDarkColor => Colors.grey.shade900; */




  static Color get greyOpacity5 => Colors.grey.withValues(alpha: 0.6);
  static Color get greyOpacity2 => Colors.grey.withValues(alpha: 0.2);
  static Color get whiteOpacity => Colors.white.withValues(alpha: 0.6);
  //static Color get darkscaffoldcolor => Color(0xff282828);
  //static Color get scaffoldcolor => Colors.white;
  static Color get darktxtfieldcolor => Color(0xff1F1F1F);
  static Color get txtfieldcolor => Colors.white.withValues(alpha: 0.8);

  static Color custom(String code) {
    final color = code.replaceAll('#', '');
    return Color(int.parse('0xFF$color'));
  }

  // Generate Random Color
  static Color get random {
    return Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
  }
}
