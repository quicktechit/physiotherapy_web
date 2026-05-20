import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/diagnosis_controller.dart';
import 'package:e_prescription/widgets/quick_tech_add_multiple_items_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

final DiagnosisController diagnosisController = locator.get<DiagnosisController>();
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

class DiagnosisSection extends StatelessWidget {
  const DiagnosisSection({super.key});

  @override
  Widget build(BuildContext context) {
  diagnosisController.fetchDiagnosis();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DiagnosisDropdown(),
        const SizedBox(height: 10),
        // Selected Diagnosis Chips
        Obx(
          () => Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children:
                diagnosisController.selectedDiagnosis.map((diagnosis) {
                  return Chip(
                    deleteIconColor:
                        themeController.isDay.value
                            ? QuickTechAppColors.bkdarktxtfld
                            : QuickTechAppColors.whiteOpacity,
                    backgroundColor:
                        themeController.isDay.value
                            ? QuickTechAppColors.whiteOpacity
                            : QuickTechAppColors.bkdarktxtfld,
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
                    onDeleted:
                        () => diagnosisController.removeDiagnosis(diagnosis),
                  );
                }).toList(),
          ),
        ),
        // Sub-diagnosis for each diagnosis
        Obx(() {
          if (diagnosisController.error.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                diagnosisController.error.value,
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          return Column(
            children:
                diagnosisController.selectedDiagnosis.map((diagnosis) {
                  final subcategoryData =
                      diagnosisController.diagnosisMap[diagnosis];
                  final subList =
                      subcategoryData != null
                          ? (subcategoryData['children'] as List<dynamic>)
                          : [];
                  if (subList.isNotEmpty) {
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
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                         children: subList.map<Widget>((subHistoryData) {
                          final subHistoryName = subHistoryData['name'] as String;
                          bool isSelected = diagnosisController.selectedsubDiagnosis[diagnosis]?.contains(subHistoryName) ?? false;
                                return ChoiceChip(
                                  checkmarkColor:
                                      themeController.isDay.value
                                          ? QuickTechAppColors
                                              .lightmaintextcolor
                                              .withValues(alpha: 0.5)
                                          : QuickTechAppColors
                                              .darkmaintextcolor,
                                  side: BorderSide(
                                    color:
                                        isSelected
                                            ? QuickTechAppColors.lightmaincolor
                                            : QuickTechAppColors.darkmaincolor,
                                    width: isSelected ? 2 : 0,
                                  ),
                                  selectedColor:
                                      themeController.isDay.value
                                          ? QuickTechAppColors.greyOpacity2
                                          : QuickTechAppColors.bkdarktxtfld
                                              .withValues(alpha: 0.9),
                                  backgroundColor:
                                      themeController.isDay.value
                                          ? QuickTechAppColors.whiteOpacity
                                          : QuickTechAppColors.bkdarktxtfld,
                                  label: Text(
                                    subHistoryName,
                                    style: myStyle(
                                      12,
                                      isSelected
                                          ? (themeController.isDay.value
                                              ? QuickTechAppColors
                                                  .lightmaintextcolor
                                              : QuickTechAppColors
                                                  .darkmaintextcolor)
                                          : (themeController.isDay.value
                                              ? QuickTechAppColors
                                                  .lightmaintextcolor
                                              : QuickTechAppColors
                                                  .darkmaintextcolor),
                                    ),
                                  ),
                                  selected: isSelected,
                                  onSelected: (selected) {
                                    if (selected) {
                                      diagnosisController.addSubDiagnosis(
                                        diagnosis,
                                        subHistoryName,
                                      );
                                    } else {
                                      diagnosisController.removeSubDiagnosis(
                                        diagnosis,
                                        subHistoryName,
                                      );
                                    }
                                  },
                                );
                              }).toList(),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                }).toList(),
          );
        }),
        // Other diagnosis details field
        if (diagnosisController.selectedDiagnosis.contains('Other'))
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextField(
              style: myStyle(
                14,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
                FontWeight.normal,
              ),
              decoration: const InputDecoration(
                labelText: 'Other Diagnosis Details',
              ),
              onChanged:
                  (value) => diagnosisController.otherDiagnosis.value = value,
            ),
          ),
     
      ],
    );
  }
}

// Diagnosis Dropdown Widget
class DiagnosisDropdown extends StatelessWidget {
  const DiagnosisDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => diagnosisController.toggleDiagnosisDropdown(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color:
                    themeController.isDay.value
                        ? QuickTechAppColors.white
                        : QuickTechAppColors.darktxtfieldcolor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: QuickTechAppColors.lightmaincolor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Diagnosis',
                    style: myStyle(
                      14,
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaintextcolor
                          : QuickTechAppColors.darkmaintextcolor,
                      FontWeight.normal,
                    ),
                  ),
                  Icon(
                    diagnosisController.isDiagnosisDropdownOpen.value
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: QuickTechAppColors.lightmaincolor,
                  ),
                ],
              ),
            ),
          ),
          if (diagnosisController.isDiagnosisDropdownOpen.value)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color:
                    themeController.isDay.value
                        ? QuickTechAppColors.white
                        : QuickTechAppColors.darktxtfieldcolor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: QuickTechAppColors.lightmaincolor),
              ),
              child: Column(
                children: [
                  // Search field
                  TextField(
                    style: myStyle(
                      14,
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaintextcolor
                          : QuickTechAppColors.darkmaintextcolor,
                      FontWeight.normal,
                    ),
                    controller: diagnosisController.diagnosisSearchController,
                    onChanged: (value) {
                      diagnosisController.diagnosisText.value = value;
                      diagnosisController.searchDiagnosis(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search diagnosis...',
                      hintStyle: myStyle(
                        14,
                        themeController.isDay.value
                            ? QuickTechAppColors.lightmaintextcolor.withValues(alpha:
                              0.5,
                            )
                            : QuickTechAppColors.darkmaintextcolor.withValues(alpha:
                              0.5,
                            ),
                        FontWeight.normal,
                      ),
                      border: InputBorder.none,
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search,
                            color: QuickTechAppColors.lightmaincolor,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              color: themeController.isDay.value
                                  ? QuickTechAppColors.lightmaincolor
                                  : QuickTechAppColors.darkmaincolor,
                            ),
                            onPressed: () {
                              showAddMultipleItemsDialog(
                                context: context,
                                title: 'Add Multiple Diagnoses',
                                hintText: 'Enter diagnosis name',
                                addButtonLabel: 'Add Diagnosis',
                                addAllButtonLabel: 'Add All Diagnoses',
                                onItemsAdded: (items) {
                                  for (var diagnosis in items) {
                                    diagnosisController.addDiagnosis(diagnosis);
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  // Diagnosis list with loading/empty/error state
                  Obx(() {
                    if (diagnosisController.isLoading.value) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final searchText = diagnosisController.diagnosisText.value;
                    if (diagnosisController.error.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          diagnosisController.error.value,
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    if (diagnosisController.filteredDiagnosis.isEmpty) {
                      return Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: Text('No diagnosis found.')),
                          ),
                          if (searchText.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Add "${searchText}"',
                                      style: myStyle(
                                        12,
                                        QuickTechAppColors.lightmaintextcolor,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color:
                                          QuickTechAppColors.lightmaintextcolor,
                                    ),
                                    onPressed: () {
                                      diagnosisController.addDiagnosis(
                                        searchText,
                                      );
                                      diagnosisController
                                          .diagnosisSearchController
                                          .clear();
                                      diagnosisController.diagnosisText.value =
                                          '';
                                    },
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                diagnosisController.filteredDiagnosis.length,
                            itemBuilder: (context, index) {
                              final diagnosis =
                                  diagnosisController.filteredDiagnosis[index];
                              return ListTile(
                                title: Text(
                                  diagnosis,
                                  style: myStyle(
                                    14,
                                    themeController.isDay.value
                                        ? QuickTechAppColors.lightmaintextcolor
                                        : QuickTechAppColors.darkmaintextcolor,
                                    FontWeight.normal,
                                  ),
                                ),
                                onTap: () {
                                  diagnosisController.addDiagnosis(diagnosis);
                                  diagnosisController.diagnosisSearchController
                                      .clear();
                                  diagnosisController.diagnosisText.value = '';
                                },
                              );
                            },
                          ),
                        ),
                        if (searchText.isNotEmpty &&
                            !diagnosisController.filteredDiagnosis.contains(
                              searchText,
                            ))
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Add "${searchText}"',
                                    style: myStyle(
                                      12,
                                      QuickTechAppColors.lightmaintextcolor,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color:
                                        QuickTechAppColors.lightmaintextcolor,
                                  ),
                                  onPressed: () {
                                    diagnosisController.addDiagnosis(
                                      searchText,
                                    );
                                    diagnosisController
                                        .diagnosisSearchController
                                        .clear();
                                    diagnosisController.diagnosisText.value =
                                        '';
                                  },
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  }),
                ],
              ),
            ),
        ],
      );
    });
  }
}
