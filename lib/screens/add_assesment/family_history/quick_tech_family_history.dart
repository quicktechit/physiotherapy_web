import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/controllers/assessment_controller/family_history/quick_tech_family_history_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/add_assesment/widgets/quick_tech_assessment_widgets.dart';
import 'package:e_prescription/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

Widget FamilyHistory() {
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechFamilyHistoryController c = locator.get<QuickTechFamilyHistoryController>();

  return Obx(() {
    final isDay = themeController.isDay.value;
    final mainColor = isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor;

    final fields = [
      assessmentDropdown(label: 'Home environment', items: c.homeEnvironmentOptions, value: c.homeEnvironment.value, onChanged: (v) => c.updateHomeEnvironment(v!), icon: Icons.home, isDay: isDay),
      assessmentDropdown(label: 'No of children', items: c.noofChildrenoptions, value: c.noofChildren.value, onChanged: (v) => c.updatenoofchildren(v!), icon: Icons.child_friendly_outlined, isDay: isDay),
      assessmentDropdown(label: 'Lactate condition', items: c.lactateOptions, value: c.lactateCondition.value, onChanged: (v) => c.updateLactate(v!), icon: Icons.sick_outlined, isDay: isDay),
      assessmentDropdown(label: 'Any other disabled person', items: c.disbaledpersonoptions, value: c.anydisableperson.value, onChanged: (v) => c.updateDisabaled(v!), icon: Icons.wheelchair_pickup_outlined, isDay: isDay),
      assessmentDropdown(label: 'Psychological condition', items: c.psycologyOptions, value: c.psychologicalCondition.value, onChanged: c.updatedPsychologicalCondition, icon: Icons.psychology, isDay: isDay, enableOthers: true, dialogTitle: "Add New Psychological Condition", dialogHint: "Enter New Psychological Condition"),
      assessmentDropdown(label: '1st cousin marriage', items: c.cousinMarriageOptions, value: c.firstcousinMarriage.value, onChanged: (v) => c.updateCousinMarriage(v!), icon: Icons.family_restroom, isDay: isDay),
    ];

  

    // Mobile
    Widget mobile() => SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          assessmentHeader(
            mainColor: mainColor,
            title: 'Family History',
            icon: Icons.family_restroom,
          ),
          const SizedBox(height: 16),
          assessmentGrid(fields: fields, cols: 1),
        ],
      ),
    );

    // Tablet
    Widget tablet() => SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          assessmentHeader(
            mainColor: mainColor,
            title: 'Family History',
            icon: Icons.family_restroom,
          ),
          const SizedBox(height: 20),
          assessmentCard(
            color: mainColor,
            title: 'Family Details',
            icon: Icons.family_restroom,
            child: assessmentGrid(fields: fields, cols: 2),
          ),
        ],
      ),
    );

    // Desktop
    Widget desktop() => SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          assessmentHeader(
            mainColor: mainColor,
            title: 'Family History',
            icon: Icons.family_restroom,
          ),
          const SizedBox(height: 24),
          assessmentCard(
                  color: mainColor,
                  title: 'Family Details',
                  icon: Icons.family_restroom,
                  child: assessmentGrid(fields: fields, cols: 2),
                ),
        ],
      ),
    );

    return Responsive(mobile: mobile(), tablet: tablet(), desktop: desktop());
  });
}