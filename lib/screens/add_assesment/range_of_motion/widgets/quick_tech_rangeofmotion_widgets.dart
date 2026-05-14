import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/range_of_motion/quick_tech_range0f_motion_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_prescription/locator.dart';
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
final QuickTechRange0fMotionController range0fMotionController = locator.get<QuickTechRange0fMotionController>();

Widget RangeofMotionLimbSection({
  required String title,
  required TextEditingController movementController,
  required TextEditingController muscleNameController,
  required TextEditingController leftInitialController,
  required TextEditingController rightInitialController,
  required TextEditingController leftDischargeController,
  required TextEditingController rightDischargeController,
  required TextEditingController commentController,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Section Title
      Text(
        title,
        style: myStyle(
          17,
          themeController.isDay.value
              ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.8)
              : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.8),
          FontWeight.bold,
        ),
      ),
      SizedBox(height: 15),

      // Movement
      QuickTechCustomTextField(
        label: 'Movement',
        controller: movementController,
        height: 50,
        backcolor:
            themeController.isDay.value
                ? QuickTechAppColors.bktxtfld
                : QuickTechAppColors.darktxtfieldcolor,
        icon: FontAwesomeIcons.arrowsRotate,
        lebelcolor:
            themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.8)
                : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.8),
        iconcolor:
            themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor
                : QuickTechAppColors.darkmaintextcolor,
        txtcolor:
            themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor
                : QuickTechAppColors.darkmaintextcolor,
      ),
      SizedBox(height: 10),

      // Muscle Name
      QuickTechCustomTextField(
        label: 'Muscle Name',
        controller: muscleNameController,
        height: 50,
        backcolor:
            themeController.isDay.value
                ? QuickTechAppColors.bktxtfld
                : QuickTechAppColors.darktxtfieldcolor,
        icon: Icons.fitness_center,
        lebelcolor:
            themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.8)
                : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.8),
        iconcolor:
            themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor
                : QuickTechAppColors.darkmaintextcolor,
        txtcolor:
            themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor
                : QuickTechAppColors.darkmaintextcolor,
      ),
      SizedBox(height: 15),

      // Initial Assessment Row
      Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Initial ROM',
              style: myStyle(
                16,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
                FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 4,
            child: QuickTechCustomTextField(
              label: 'Left',
              lebelcolor:
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.8)
                      : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.8),
              controller: leftInitialController,
              height: 50,
              backcolor:
                  themeController.isDay.value
                      ? QuickTechAppColors.bktxtfld
                      : QuickTechAppColors.darktxtfieldcolor,
              txtcolor:
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor
                      : QuickTechAppColors.darkmaintextcolor,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 4,
            child: QuickTechCustomTextField(
              lebelcolor:
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.8)
                      : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.8),
              maxline: 1,
              label: 'Right',
              controller: rightInitialController,
              height: 50,
              backcolor:
                  themeController.isDay.value
                      ? QuickTechAppColors.bktxtfld
                      : QuickTechAppColors.darktxtfieldcolor,
              txtcolor:
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor
                      : QuickTechAppColors.darkmaintextcolor,
            ),
          ),
        ],
      ),
      SizedBox(height: 10),

      // Discharge Assessment Row
      Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Discharge ROM',
              style: myStyle(
                16,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
                FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 4,
            child: QuickTechCustomTextField(
              lebelcolor:
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.8)
                      : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.8),
              label: 'Left',
              controller: leftDischargeController,
              height: 50,
              backcolor:
                  themeController.isDay.value
                      ? QuickTechAppColors.bktxtfld
                      : QuickTechAppColors.darktxtfieldcolor,
              txtcolor:
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor
                      : QuickTechAppColors.darkmaintextcolor,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 4,
            child: QuickTechCustomTextField(
              lebelcolor:
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.8)
                      : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.8),
              label: 'Right',
              controller: rightDischargeController,
              height: 50,
              backcolor:
                  themeController.isDay.value
                      ? QuickTechAppColors.bktxtfld
                      : QuickTechAppColors.darktxtfieldcolor,
              txtcolor:
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor
                      : QuickTechAppColors.darkmaintextcolor,
            ),
          ),
        ],
      ),

      SizedBox(height: 15),

      // Comments Section
      QuickTechCustomTextField(
        maxline: 3,
        label: 'Comments',
        controller: commentController,
        height: 80,

        backcolor:
            themeController.isDay.value
                ? QuickTechAppColors.bktxtfld
                : QuickTechAppColors.darktxtfieldcolor,
        icon: FontAwesomeIcons.comment,
        lebelcolor:
            themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.8)
                : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.8),
        iconcolor:
            themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor
                : QuickTechAppColors.darkmaintextcolor,
        txtcolor:
            themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor
                : QuickTechAppColors.darkmaintextcolor,
      ),
      SizedBox(height: 15),


    ],
  );
}
