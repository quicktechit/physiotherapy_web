import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/controllers/assessment_controller/range_of_motion/quick_tech_range0f_motion_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/add_assesment/range_of_motion/widgets/quick_tech_rangeofmotion_widgets.dart';
import 'package:e_prescription/screens/add_assesment/widgets/quick_tech_assessment_widgets.dart'; // Added for responsive layout
import 'package:e_prescription/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

class RangeofMotion extends StatelessWidget {
  final String? patientId;

  const RangeofMotion({Key? key, this.patientId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
    final QuickTechRange0fMotionController range0fMotionController = locator.get<QuickTechRange0fMotionController>();

    return Obx(() {
      final isDay = themeController.isDay.value;
      final mainColor = isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor;

      // ─────────────────────────────────────────────
      // Reusable Limb Section Widgets
      // ─────────────────────────────────────────────
      Widget upperLimb = RangeofMotionLimbSection(
        title: 'Upper Limb',
        movementController: range0fMotionController.uppermovementController,
        muscleNameController: range0fMotionController.uppermusclenameController,
        leftInitialController: range0fMotionController.upperleftInitialROMController,
        rightInitialController: range0fMotionController.upperrightInitialROMController,
        leftDischargeController: range0fMotionController.upperleftDischargeROMController,
        rightDischargeController: range0fMotionController.upperrightDischargeROMController,
        commentController: range0fMotionController.upperCommentController,
      );

      Widget lowerLimb = RangeofMotionLimbSection(
        title: 'Lower Limb',
        movementController: range0fMotionController.lowermovementController,
        muscleNameController: range0fMotionController.lowermusclenameController,
        leftInitialController: range0fMotionController.lowerleftInitialROMController,
        rightInitialController: range0fMotionController.lowerrightInitialROMController,
        leftDischargeController: range0fMotionController.lowerleftDischargeROMController,
        rightDischargeController: range0fMotionController.lowerrightDischargeROMController,
        commentController: range0fMotionController.lowerCommentController,
      );

      // Mobile Layout
      Widget mobile() => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                assessmentHeader(mainColor: mainColor, title: 'Range of Motion: Limb', icon: Icons.accessibility_new),
                const SizedBox(height: 16),
                upperLimb,
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
                assessmentHeader(mainColor: mainColor, title: 'Range of Motion: Limb', icon: Icons.accessibility_new),
                const SizedBox(height: 20),
                upperLimb,
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
                assessmentHeader(mainColor: mainColor, title: 'Range of Motion: Limb', icon: Icons.accessibility_new),
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
              ],
            ),
          );

      return Responsive(mobile: mobile(), tablet: tablet(), desktop: desktop());
    });
  }
}