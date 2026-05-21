import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/controllers/assessment_controller/occupation_history/quick_tech_occupation_history_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/add_assesment/widgets/quick_tech_assessment_widgets.dart';
import 'package:e_prescription/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

Widget OccupationHistory() {
  final QuickTechThemeController themeController =
      locator.get<QuickTechThemeController>();
  final QuickTechOccupationHistoryController c =
      locator.get<QuickTechOccupationHistoryController>();

  return Obx(() {
    final isDay = themeController.isDay.value;
    final mainColor =
        isDay
            ? QuickTechAppColors.lightmaincolor
            : QuickTechAppColors.darkmaincolor;

    final fields = [
      assessmentDropdown(
        label: 'Type of work',
        items: c.typesofworkoptions,
        value: c.typeOfWork.value,
        onChanged: c.updateTypesofWork,
        icon: Icons.work_outline,
        isDay: isDay,
        enableOthers: true,
        dialogTitle: "Add New Type of Work",
        dialogHint: "Enter New Type of Work",
      ),
      assessmentDropdown(
        label: 'Stair moving',
        items: c.stairMOvingoptions,
        value: c.stairMoving.value,
        onChanged: (v) => c.updateStairMoving(v!),
        icon: Icons.stairs,
        isDay: isDay,
      ),
      assessmentDropdown(
        label: 'Lumbar involvement',
        items: c.lumbarInvolvementoptions,
        value: c.lumbarInvolvement.value,
        onChanged: (v) => c.updatelumberInvolvemnt(v!),
        icon: Icons.accessibility_new,
        isDay: isDay,
      ),
      assessmentDropdown(
        label: 'Brain work',
        items: c.brainWorkoption,
        value: c.brainWork.value,
        onChanged: (v) => c.updatebrainWork(v!),
        icon: Icons.psychology,
        isDay: isDay,
      ),
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
            title: 'Occupation History',
            icon: Icons.work,
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
            title: 'Occupation History',
            icon: Icons.work,
          ),
          const SizedBox(height: 20),
          assessmentCard(
            color: mainColor,
            title: 'Occupation History',
            icon: Icons.work,
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
            title: 'Occupation History',
            icon: Icons.work,
          ),
          const SizedBox(height: 24),
          assessmentCard(
            color: mainColor,
            title: 'Occupation History',
            icon: Icons.work,
            child: assessmentGrid(fields: fields, cols: 2),
          ),
        ],
      ),
    );

    return Responsive(mobile: mobile(), tablet: tablet(), desktop: desktop());
  });
}
