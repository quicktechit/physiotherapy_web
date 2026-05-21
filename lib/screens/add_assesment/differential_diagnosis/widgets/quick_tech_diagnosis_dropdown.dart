import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/differential_diagnosis/quick_tech_differential_diagnosis_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

class DiagnosisDropdown extends StatelessWidget {
  const DiagnosisDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
    final QuickTechDifferentialDiagnosisController diagnosisController = locator.get<QuickTechDifferentialDiagnosisController>();

    return Obx(() {
      final isDay = themeController.isDay.value;
      final txtColor = isDay ? QuickTechAppColors.lightmaintextcolor : QuickTechAppColors.darkmaintextcolor;
      final bgColor = isDay ? QuickTechAppColors.white : QuickTechAppColors.bkdarktxtfld;
      final iconLabelColor = txtColor.withValues(alpha:0.8);

      return Column(
        children: [
          // Dropdown Toggle Button
          OutlinedButton(
            onPressed: diagnosisController.togglediagnosisDropdown,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), // Increased vertical padding for a taller button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: isDay ? QuickTechAppColors.bktxtfld : QuickTechAppColors.bkdarktxtfld,
              side: BorderSide(
                color: isDay ? Colors.grey.shade300 : Colors.grey.shade800,
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Search or Select Diagnosis',
                  style: myStyle(15, txtColor.withValues(alpha:0.8)),
                ),
                Icon(
                  diagnosisController.isDiagnosisDropdownOpen.value ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: txtColor,
                  size: 24,
                ),
              ],
            ),
          ),

          // Expanded Card Content
          if (diagnosisController.isDiagnosisDropdownOpen.value)
            Card(
              color: bgColor,
              elevation: isDay ? 4 : 0,
              margin: const EdgeInsets.only(top: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: isDay ? Colors.transparent : Colors.grey.shade800),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    // Search Field
                    QuickTechCustomTextField(
                      lebelcolor: iconLabelColor,
                      label: 'Type to search...',
                      controller: diagnosisController.diagnosisSearchController,
                      onchanged: (value) => diagnosisController.diagnosisText.value = value,
                      backcolor: isDay ? QuickTechAppColors.bktxtfld : QuickTechAppColors.darktxtfieldcolor,
                      icon: Icons.search,
                      iconcolor: iconLabelColor,
                      txtcolor: txtColor,
                    ),
                    const SizedBox(height: 8),

                    // Filtered List
                    Container(
                      constraints: const BoxConstraints(maxHeight: 220),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: diagnosisController.filtereddiagnosis.map((sub) {
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                              title: Text(
                                sub,
                                style: myStyle(14, txtColor),
                              ),
                              trailing: Icon(Icons.add_circle_outline, color: txtColor.withValues(alpha:0.5), size: 20),
                              onTap: () {
                                diagnosisController.addDiagnosis(sub);
                                diagnosisController.diagnosisText.value = '';
                                diagnosisController.diagnosisSearchController.clear();
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    // Add Custom Diagnosis Option
                    Obx(() {
                      if (diagnosisController.diagnosisText.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              final newDiagnosis = diagnosisController.diagnosisText.value;
                              if (newDiagnosis.isNotEmpty) {
                                diagnosisController.addDiagnosis(newDiagnosis);
                                diagnosisController.isDiagnosisDropdownOpen.value = false;
                                diagnosisController.diagnosisText.value = '';
                                diagnosisController.diagnosisSearchController.clear();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isDay ? QuickTechAppColors.lightmaincolor.withValues(alpha:0.1) : QuickTechAppColors.darkmaincolor.withValues(alpha:0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.add, color: isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor, size: 20),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Add Custom: "${diagnosisController.diagnosisText.value}"',
                                      style: myStyle(14, isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor, FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                  ],
                ),
              ),
            ),
        ],
      );
    });
  }
}