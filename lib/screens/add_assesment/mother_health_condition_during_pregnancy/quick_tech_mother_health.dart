import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/mother_health_condition_during_pregnancy/quick_tech_mother_health_controller.dart';

import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/widgets/quick_tech_custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:e_prescription/locator.dart';

Widget MotherHealthCondition() {
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechMotherHealthController healthConditionController = locator.get<QuickTechMotherHealthController>();
  
  return Column(
    children: [
      Text(
        'Mother Health Condition During Pregnancy',
        style: myStyle(
          20,
          themeController.isDay.value
              ? QuickTechAppColors.lightmaincolor
              : QuickTechAppColors.darkmaincolor,
          FontWeight.bold,
        ),
      ),
      SizedBox(height: 15),
      
      // Blood Pressure Dropdown
      QuickTechCustomDropDown(
        label: 'Blood pressure',
        items: healthConditionController.bloodPressureOptions,
        value: healthConditionController.bloodPressure.value,
        onChanged: healthConditionController.updateBloodPressure,
        icon: Icons.favorite,
        isDay: themeController.isDay.value,
              enableOthersOption: true,
            dialogTitle: "Add Blood Pressure",
            dialogHint: "Enter Blood Pressure",
      ),
      SizedBox(height: 10),

      // Diabetes Dropdown
      QuickTechCustomDropDown(
        label: 'Diabetes mellitus',
        items: healthConditionController.diabetesOptions,
        value: healthConditionController.diabetes.value,
        onChanged: (value) => healthConditionController.updateDiabetes(value!),
        icon: Icons.accessibility,
        isDay: themeController.isDay.value,
      ),
      SizedBox(height: 10),

      // Gestational Diabetes Dropdown
      QuickTechCustomDropDown(
        label: 'Gestational Diabetes',
        items: healthConditionController.diabetesOptions, // Reusing diabetesOptions as for gestational
        value: healthConditionController.gestationalDiabetes.value,
        onChanged: (value) => healthConditionController.updateGestationalDiabetes(value!),
        icon: Icons.sick_outlined,
        isDay: themeController.isDay.value,
      ),
      SizedBox(height: 10),

      // Preeclampsia Dropdown
      QuickTechCustomDropDown(
        label: 'Preeclampsia',
        items: healthConditionController.preeclampsiaOptions,
        value: healthConditionController.preeclampsia.value,
        onChanged: (value) => healthConditionController.updatePreeclampsia(value!),
        icon: Icons.warning,
        isDay: themeController.isDay.value,
      ),
      SizedBox(height: 10),

      // Infection Dropdown
      QuickTechCustomDropDown(
        label: 'Infection',
        items: healthConditionController.infectionOptions,
        value: healthConditionController.infection.value,
        onChanged: (value) => healthConditionController.updateInfection(value!),
        icon: Icons.medical_services,
        isDay: themeController.isDay.value,
      ),
      SizedBox(height: 10),

      // Bleeding Dropdown
      QuickTechCustomDropDown(
        label: 'Bleeding',
        items: healthConditionController.bleedingOptions,
        value: healthConditionController.bleeding.value,
        onChanged: (value) => healthConditionController.updateBleeding(value!),
        icon: Icons.bloodtype,
        isDay: themeController.isDay.value,
      ),
      SizedBox(height: 10),

      // Anxiety or Stress Dropdown
      QuickTechCustomDropDown(
        label: 'Anxiety or stress',
        items: healthConditionController.anxietyOptions,
        value: healthConditionController.anxiety.value,
        onChanged: (value) => healthConditionController.updateAnxiety(value!),
        icon: Icons.sentiment_very_dissatisfied,
        isDay: themeController.isDay.value,
      ),
      SizedBox(height: 10),
       
    ],
    crossAxisAlignment: CrossAxisAlignment.start,
  );
}
