import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/muscle_power/quick_tech_muscle_power_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/add_assesment/muscle_power/widgets/quick_tech_muscle_power_widgets.dart';
import 'package:e_prescription/widgets/quick_tech_custom_drop_down.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

Widget MusclePower({String? patientId}) {
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechMusclePowerController musclePowerController = locator.get<QuickTechMusclePowerController>();
  musclePowerController.fetchOxfordMuscleGrades();
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          'Muscle Power: Limb',
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
    LimbSections(
      title: 'Upper Limb',
      movementController: musclePowerController.uppermovementController,
      muscleNameController: musclePowerController.uppermusclenameController,
      leftInitialController:
        musclePowerController.upperleftInitialController,
      rightInitialController:
        musclePowerController.upperrightInitialController,
      leftDischargeController:
        musclePowerController.upperleftDischargeController,
      rightDischargeController:
        musclePowerController.upperrightDischargeController,
      commentController: musclePowerController.upperCommentController,
    ),

        SizedBox(height: 15),
        //Oxford Muscle Power
Column(
  children: [
    Row(
      children: [
        Expanded(
          child: Obx(() {
            if (musclePowerController.isLoadingOxford.value) {
              return Center(child: CircularProgressIndicator());
            }

            return QuickTechCustomDropDown(
              label: 'Oxford muscle grading scale',
              items: musclePowerController.oxfordMuscleGrades
                  .map((e) => e.numericValue)
                  .toList(),
              value: musclePowerController.oxfordMuscle.value,
              onChanged: (value) =>
                  musclePowerController.updateOxfordMuscle(value!),
              icon: Icons.work,
              isDay: themeController.isDay.value,
            );
          }),
        ),
        IconButton(
          onPressed: () {
            musclePowerController.toggleOxfordMuscle();
            
          },
          icon: Obx(() => Icon(
                musclePowerController.oxfordMuscleVisible.value
                    ? FontAwesomeIcons.circleInfo
                    : FontAwesomeIcons.circleInfo,
                size: 20,
              )),
        ),
      ],
    ),

    /// Info Card
    Obx(
      () => AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: musclePowerController.oxfordMuscleVisible.value
            ? Card(
                color: themeController.isDay.value
                    ? QuickTechAppColors.lightScaffoldColor
                    : QuickTechAppColors.darkScaffoldColor,
                elevation: themeController.isDay.value ? 5 : 2,
                shadowColor: themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Obx(() {
                    if (musclePowerController.isLoadingOxford.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: musclePowerController.oxfordMuscleGrades
                          .map((e) => Text(
                                "${e.numericValue} = ${e.textValue}",
                                style: myStyle(
                                  12,
                                  themeController.isDay.value
                                      ? QuickTechAppColors.lightmaintextcolor
                                      : QuickTechAppColors.darkmaintextcolor,
                                ),
                              ))
                          .toList(),
                    );
                  }),
                ),
              )
            : const SizedBox.shrink(),
      ),
    ),
  ],
)
,

        SizedBox(height: 15),
        // Lower Limb Section
    LimbSections(
      title: 'Lower Limb',
      movementController: musclePowerController.lowermovementController,
      muscleNameController: musclePowerController.lowermusclenameController,
      leftInitialController:
        musclePowerController.lowerleftInitialController,
      rightInitialController:
        musclePowerController.lowerrightInitialController,
      leftDischargeController:
        musclePowerController.lowerleftDischargeController,
      rightDischargeController:
        musclePowerController.lowerrightDischargeController,
      commentController: musclePowerController.lowerCommentController,
    ),
         
      ],
    ),
  );
}
