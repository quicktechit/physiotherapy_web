import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';

import 'package:e_prescription/controllers/assessment_controller/problem_summary/quick_tech_problem_summary_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';

import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_prescription/locator.dart';

Widget ProblemSummary({String? patientId}) {
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechProblemSummaryController problemSummaryController = locator.get<QuickTechProblemSummaryController>();
  
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Problem Summary,Goal,Plan',
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
        height: 80,
        icon: Icons.sick,
        iconcolor:
            themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.8)
                : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.8),
        lebelcolor:
            themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.8)
                : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.8),
        label: 'Problem List',
        controller: problemSummaryController.problemListController,
        maxline: 4,
        backcolor:
            themeController.isDay.value
                ? QuickTechAppColors.bktxtfld
                : QuickTechAppColors.bkdarktxtfld,
      ),SizedBox(height: 10,),
      QuickTechCustomTextField(
        height: 80,
        icon: Icons.flag,
        iconcolor:
            themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.8)
                : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.8),
        lebelcolor:
            themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.8)
                : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.8),
        label: 'Goal',
        controller: problemSummaryController.goalListController,
        maxline: 4,
        backcolor:
            themeController.isDay.value
                ? QuickTechAppColors.bktxtfld
                : QuickTechAppColors.bkdarktxtfld,
      ),SizedBox(height: 10,),
      QuickTechCustomTextField(
        height: 80,
        icon:FontAwesomeIcons.kitMedical,
        iconcolor:
            themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.8)
                : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.8),
        lebelcolor:
            themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.8)
                : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.8),
        label: 'Treatment Plan',
        controller: problemSummaryController.treatmentPlanController,
        maxline: 4,
        backcolor:
            themeController.isDay.value
                ? QuickTechAppColors.bktxtfld
                : QuickTechAppColors.bkdarktxtfld,
      ),SizedBox(height: 10,),

    ],
  );
}
