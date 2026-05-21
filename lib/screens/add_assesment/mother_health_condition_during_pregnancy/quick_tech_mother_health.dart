import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/controllers/assessment_controller/mother_health_condition_during_pregnancy/quick_tech_mother_health_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/add_assesment/widgets/quick_tech_assessment_widgets.dart';
import 'package:e_prescription/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

Widget MotherHealthCondition() {
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechMotherHealthController c = locator.get<QuickTechMotherHealthController>();

  return Obx(() {
    final isDay = themeController.isDay.value;
    final mainColor = isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor;

    final fields = [
      assessmentDropdown(label: 'Blood pressure', items: c.bloodPressureOptions, value: c.bloodPressure.value, onChanged: c.updateBloodPressure, icon: Icons.favorite, isDay: isDay, enableOthers: true, dialogTitle: "Add Blood Pressure", dialogHint: "Enter Blood Pressure"),
      assessmentDropdown(label: 'Diabetes mellitus', items: c.diabetesOptions, value: c.diabetes.value, onChanged: (v) => c.updateDiabetes(v!), icon: Icons.accessibility, isDay: isDay),
      assessmentDropdown(label: 'Gestational Diabetes', items: c.diabetesOptions, value: c.gestationalDiabetes.value, onChanged: (v) => c.updateGestationalDiabetes(v!), icon: Icons.sick_outlined, isDay: isDay),
      assessmentDropdown(label: 'Preeclampsia', items: c.preeclampsiaOptions, value: c.preeclampsia.value, onChanged: (v) => c.updatePreeclampsia(v!), icon: Icons.warning, isDay: isDay),
      assessmentDropdown(label: 'Infection', items: c.infectionOptions, value: c.infection.value, onChanged: (v) => c.updateInfection(v!), icon: Icons.medical_services, isDay: isDay),
      assessmentDropdown(label: 'Bleeding', items: c.bleedingOptions, value: c.bleeding.value, onChanged: (v) => c.updateBleeding(v!), icon: Icons.bloodtype, isDay: isDay),
      assessmentDropdown(label: 'Anxiety or stress', items: c.anxietyOptions, value: c.anxiety.value, onChanged: (v) => c.updateAnxiety(v!), icon: Icons.sentiment_very_dissatisfied, isDay: isDay),
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
            title: 'Mother Health..',
            icon: Icons.pregnant_woman,
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
            title: 'Mother Health During Pregnancy',
            icon: Icons.pregnant_woman,
          ),
          const SizedBox(height: 20),
          assessmentCard(
            color: mainColor,
            title: 'Health Conditions',
            icon: Icons.pregnant_woman,
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
            title: 'Mother Health During Pregnancy',
            icon: Icons.pregnant_woman,
          ),
          const SizedBox(height: 24),
          assessmentCard(
            color: mainColor,
            title: 'Health Conditions',
            icon: Icons.pregnant_woman,
            child: assessmentGrid(fields: fields, cols: 3),
          ),
        ],
      ),
    );

    return Responsive(mobile: mobile(), tablet: tablet(), desktop: desktop());
  });
}