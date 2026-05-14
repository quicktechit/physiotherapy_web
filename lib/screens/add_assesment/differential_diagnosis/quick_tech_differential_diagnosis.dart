import 'package:e_prescription/const/quick_tech_app_colors.dart';

import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/differential_diagnosis/quick_tech_differential_diagnosis_controller.dart';


import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/add_assesment/differential_diagnosis/widgets/quick_tech_diagnosis_dropdown.dart';
import 'package:e_prescription/screens/add_prescription/widgets/quick_tech_prescription_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

Widget DifferentialDiagnosis() {
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechDifferentialDiagnosisController diagnosisController = locator.get<QuickTechDifferentialDiagnosisController>();
  // Idempotent: safe to call from build; it won't refetch once loaded.
  diagnosisController.ensureCategoryLoaded();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Differential Diagnosis',
        style: myStyle(
          20,
          themeController.isDay.value
              ? QuickTechAppColors.lightmaincolor
              : QuickTechAppColors.darkmaincolor,
          FontWeight.bold,
        ),
      ),
      DiagnosisDropdown(),
      SizedBox(height: 16),
      Obx(
        () => Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: diagnosisController.selectedDiagnosis.map((diagnosis) {
            return Chip(
              deleteIconColor: themeController.isDay.value
                  ? QuickTechAppColors.bkdarktxtfld
                  : QuickTechAppColors.whiteOpacity,
              backgroundColor: themeController.isDay.value
                  ? QuickTechAppColors.whiteOpacity
                  : QuickTechAppColors.darktxtfieldcolor,
              label: Text(
                diagnosis,
                style: myStyle(
                  14,
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor
                      : QuickTechAppColors.darkmaintextcolor,
                  FontWeight.bold,
                ),
              ),
              onDeleted: () => diagnosisController.removeDiagnosis(diagnosis),
            );
          }).toList(),
        ),
      ),
      // Show Textfield For Selected ones
      Obx(() {
        return Column(
          children: diagnosisController.selectedDiagnosis.map((diagnosis) {
            if (diagnosisController.showDetailsField(diagnosis)) {
              return Padding(
                padding: EdgeInsets.only(top: 10),
                child: Padding(
                  padding: const EdgeInsets.only(right: 100),
                  child: customTextField(
                    icon: Icons.input,
                    ' $diagnosis Details',
                    diagnosisController.getDetailsController(diagnosis),
                  ),
                ),
              );
            }
            return SizedBox();
          }).toList(),
        );
      }),
      Obx(() {
        final category = diagnosisController.diagnosisCategory.value;
        if (category == null) return SizedBox();
        return Column(
          children: diagnosisController.selectedDiagnosis.map((diagnosis) {
            final sub = category.subCategories.firstWhereOrNull((s) => s.name == diagnosis);
            if (sub != null && sub.childCategories.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sub-Diagnosis for $diagnosis',
                    style: myStyle(
                      15,
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaintextcolor
                          : QuickTechAppColors.darkmaintextcolor,
                      FontWeight.w500,
                    ),
                  ),
                  Obx(
                    () => Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: sub.childCategories.map((child) {
                        return ChoiceChip(
                          backgroundColor: themeController.isDay.value
                              ? QuickTechAppColors.whiteOpacity
                              : QuickTechAppColors.darktxtfieldcolor,
                          label: Text(
                            child.name,
                            style: myStyle(
                              12,
                              themeController.isDay.value
                                  ? (diagnosisController.selectedsubDiagnosis[diagnosis]?.contains(child.name) ?? false
                                      ? QuickTechAppColors.lightmaintextcolor
                                      : QuickTechAppColors.lightmaintextcolor)
                                  : (diagnosisController.selectedsubDiagnosis[diagnosis]?.contains(child.name) ?? false
                                      ? QuickTechAppColors.lightmaintextcolor
                                      : QuickTechAppColors.darkmaintextcolor),
                            ),
                          ),
                          selected: diagnosisController.selectedsubDiagnosis[diagnosis]?.contains(child.name) ?? false,
                          onSelected: (selected) {
                            if (selected) {
                              diagnosisController.addSubDiagnosis(diagnosis, child.name);
                            } else {
                              diagnosisController.removeSubDiagnosis(diagnosis, child.name);
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            }
            return SizedBox();
          }).toList(),
        );
      }),

    ],
  );
}
