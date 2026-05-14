import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/home_advice/quick_tech_home_advice_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_prescription/locator.dart';

Widget HomeAdvice({String? patientId}) {
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechHomeAdviceController AdviceController = locator.get<QuickTechHomeAdviceController>();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Home Advice',
        style: myStyle(
          20,
          themeController.isDay.value
              ? QuickTechAppColors.lightmaincolor
              : QuickTechAppColors.darkmaincolor,
          FontWeight.bold,
        ),
      ),
      SizedBox(height: 15),
      QuickTechCustomTextField(
        backcolor:
            themeController.isDay.value
                ? QuickTechAppColors.bktxtfld
                : QuickTechAppColors.bkdarktxtfld,
        height: 80,
        maxline: 4,
        lebelcolor:
            themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.8)
                : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.8),
                icon: FontAwesomeIcons.houseMedical,
                iconcolor:   themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.8)
                : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.8),
                txtcolor:  themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor
                : QuickTechAppColors.darkmaintextcolor,
        label: 'Advice',
        controller: AdviceController.homeAdviceController,
      ),

    ],
  );
}
