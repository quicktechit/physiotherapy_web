import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/past_medical_history/quick_tech_past_medical_history_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/quick_tech_assessment_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

Widget PastMedicalHistory() {
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechPastMedicalHistoryController pastMedicalHistoryController = locator.get<QuickTechPastMedicalHistoryController>();
  final QuickTechAssessmentController assessmentController = locator.get<QuickTechAssessmentController>();
  pastMedicalHistoryController.fetchMedicalHistories();
  return Obx(() {
    if (pastMedicalHistoryController.isLoading.value) {
      return Center(child: CircularProgressIndicator());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Past Medical History',
          style: myStyle(
            20,
            themeController.isDay.value
                ? QuickTechAppColors.lightmaincolor
                : QuickTechAppColors.darkmaincolor,
            FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        ...pastMedicalHistoryController.medicalHistories.map((item) {
          // Don't show 'Others' as a checkbox, show as a ListTile below
          if (item.name == 'Others') return SizedBox.shrink();
          return CheckboxListTile(
            title: Text(
              item.name,
              style: myStyle(
                16,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
              ),
            ),
            value:
                pastMedicalHistoryController.selectedMedicalHistories[item
                    .id] ??
                false,
            onChanged: (value) {
              pastMedicalHistoryController.updateMedicalHistory(
                item.id,
                value!,
              );
            },
          );
        }).toList(),
        SizedBox(height: 20),
        ListTile(
          title: Text(
            'Others',
            style: myStyle(
              16,
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
            ),
          ),
          onTap: () {
            assessmentController.showOthersDialog(
              Get.context!,
              label: 'Past Medical History',
              onChanged: (value) {
                pastMedicalHistoryController.addOtherItem(value);
              },
            );
          },
        ),
        SizedBox(height: 10),
        // Show selected items
        if (pastMedicalHistoryController.getSelectedItems().isNotEmpty) ...[
          Text(
            'Selected:',
            style: myStyle(
              16,
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
              FontWeight.bold,
            ),
          ),
          ...pastMedicalHistoryController.getSelectedItems().map(
            (name) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Text(
                name,
                style: myStyle(
                  15,
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor
                      : QuickTechAppColors.darkmaintextcolor,
                ),
              ),
            ),
          ),
        ],
        SizedBox(height: 20),
     
      ],
    );
  });
}
