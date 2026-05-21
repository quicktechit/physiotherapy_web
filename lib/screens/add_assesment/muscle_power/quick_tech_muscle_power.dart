import 'package:e_prescription/const/quick_tech_app_colors.dart';

import 'package:e_prescription/controllers/assessment_controller/muscle_power/quick_tech_muscle_power_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/add_assesment/muscle_power/widgets/quick_tech_muscle_power_widgets.dart';
import 'package:e_prescription/screens/add_assesment/widgets/quick_tech_assessment_widgets.dart'; // Added for responsive cards
import 'package:e_prescription/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

class MusclePower extends StatelessWidget {
  final String? patientId;

  MusclePower({Key? key, this.patientId}) : super(key: key) {
    // Fetch data once upon widget creation
    locator.get<QuickTechMusclePowerController>().fetchOxfordMuscleGrades();
  }

  @override
  Widget build(BuildContext context) {
    final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
    final QuickTechMusclePowerController musclePowerController = locator.get<QuickTechMusclePowerController>();

    return Obx(() {
      final isDay = themeController.isDay.value;
      final mainColor = isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor;

      // ─────────────────────────────────────────────
      // Reusable Limb Section Widgets
      // ─────────────────────────────────────────────
      Widget upperLimb = LimbSectionCard(
        title: 'Upper Limb',
        movementController: musclePowerController.uppermovementController,
        muscleNameController: musclePowerController.uppermusclenameController,
        leftInitialController: musclePowerController.upperleftInitialController,
        rightInitialController: musclePowerController.upperrightInitialController,
        leftDischargeController: musclePowerController.upperleftDischargeController,
        rightDischargeController: musclePowerController.upperrightDischargeController,
        commentController: musclePowerController.upperCommentController,
      );

      Widget lowerLimb = LimbSectionCard(
        title: 'Lower Limb',
        movementController: musclePowerController.lowermovementController,
        muscleNameController: musclePowerController.lowermusclenameController,
        leftInitialController: musclePowerController.lowerleftInitialController,
        rightInitialController: musclePowerController.lowerrightInitialController,
        leftDischargeController: musclePowerController.lowerleftDischargeController,
        rightDischargeController: musclePowerController.lowerrightDischargeController,
        commentController: musclePowerController.lowerCommentController,
      );

      Widget oxfordScaleSection = OxfordMuscleScaleWidget();

      // Mobile Layout
      Widget mobile() => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                assessmentHeader(mainColor: mainColor, title: 'Muscle Power: Limb', icon: Icons.fitness_center),
                const SizedBox(height: 16),
                upperLimb,
                const SizedBox(height: 16),
                oxfordScaleSection,
                const SizedBox(height: 16),
                lowerLimb,
              ],
            ),
          );

      // Tablet Layout
      Widget tablet() => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                assessmentHeader(mainColor: mainColor, title: 'Muscle Power: Limb', icon: Icons.fitness_center),
                const SizedBox(height: 20),
                upperLimb,
                const SizedBox(height: 16),
                oxfordScaleSection,
                const SizedBox(height: 16),
                lowerLimb,
              ],
            ),
          );

      // Desktop Layout
      Widget desktop() => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                assessmentHeader(mainColor: mainColor, title: 'Muscle Power: Limb', icon: Icons.fitness_center),
                const SizedBox(height: 24),
                // On Desktop, place Upper and Lower limbs side-by-side
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: upperLimb),
                    const SizedBox(width: 16),
                    Expanded(child: lowerLimb),
                  ],
                ),
                const SizedBox(height: 16),
                oxfordScaleSection,
              ],
            ),
          );

      return Responsive(mobile: mobile(), tablet: tablet(), desktop: desktop());
    });
  }
}