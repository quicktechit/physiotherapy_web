import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';

import 'package:e_prescription/controllers/assessment_controller/range_of_motion/quick_tech_range0f_motion_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';

import 'package:e_prescription/screens/add_assesment/range_of_motion/widgets/quick_tech_rangeofmotion_widgets.dart';


import 'package:flutter/material.dart';


Widget RangeofMotion({String? patientId}) {
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechRange0fMotionController range0fMotionController = locator.get<QuickTechRange0fMotionController>();
  
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          'Range of Motion: Limb',
          style: myStyle(
            20,
            themeController.isDay.value
                ? QuickTechAppColors.lightmaincolor
                : QuickTechAppColors.darkmaincolor,
            FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),

        // Upper Limb Section
        RangeofMotionLimbSection(
          title: 'Upper Limb',
          movementController: range0fMotionController.uppermovementController,
          muscleNameController: range0fMotionController.uppermusclenameController,
          leftInitialController:
              range0fMotionController.upperleftInitialROMController,
          rightInitialController:
              range0fMotionController.upperrightInitialROMController,
          leftDischargeController:
              range0fMotionController.upperleftDischargeROMController,
          rightDischargeController:
              range0fMotionController.upperrightDischargeROMController,
          commentController:     range0fMotionController.upperCommentController,
        ),

        SizedBox(height: 30),

        // Lower Limb Section
        RangeofMotionLimbSection(
          title: 'Lower Limb',
          movementController: range0fMotionController.lowermovementController,
          muscleNameController: range0fMotionController.lowermusclenameController,
          leftInitialController:
              range0fMotionController.lowerleftInitialROMController,
          rightInitialController:
              range0fMotionController.lowerrightInitialROMController,
          leftDischargeController:
              range0fMotionController.lowerleftDischargeROMController,
          rightDischargeController:
              range0fMotionController.lowerrightDischargeROMController,
              commentController: range0fMotionController.lowerCommentController,
        ),
   
     
      ],
    ),
  );
}
