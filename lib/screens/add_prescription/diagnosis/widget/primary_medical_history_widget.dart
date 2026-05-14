import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/primary_medical_history_controller.dart';
import 'package:e_prescription/widgets/quick_tech_add_multiple_items_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:e_prescription/locator.dart';

final PrimaryMedicalHistoryController primaryMedicalHistoryController = locator.get<PrimaryMedicalHistoryController>();
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

class PrimaryMedicalHistorySection extends StatelessWidget {
  const PrimaryMedicalHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
      primaryMedicalHistoryController.fetchMedicalHistory();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryMedicalHistoryDropdown(),
        const SizedBox(height: 10),
        // Selected Medical History Chips
        Obx(
          () => Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: primaryMedicalHistoryController.selectedMedicalHistory.map((history) {
              return Chip(
                deleteIconColor: themeController.isDay.value
                    ? QuickTechAppColors.bkdarktxtfld
                    : QuickTechAppColors.whiteOpacity,
                backgroundColor: themeController.isDay.value
                    ? QuickTechAppColors.whiteOpacity
                    : QuickTechAppColors.bkdarktxtfld,
                label: Text(
                  history,
                  style: myStyle(
                    14,
                    themeController.isDay.value
                        ? QuickTechAppColors.lightmaintextcolor
                        : QuickTechAppColors.darkmaintextcolor,
                    FontWeight.bold,
                  ),
                ),
                onDeleted: () => primaryMedicalHistoryController.removeMedicalHistory(history),
              );
            }).toList(),
          ),
        ),
        // Sub-medical history for each medical history
        Obx(() {
          return Column(
            children: primaryMedicalHistoryController.selectedMedicalHistory.map((history) {
              final subcategoryData = primaryMedicalHistoryController.medicalHistoryMap[history];
              final subList = subcategoryData != null ? (subcategoryData['children'] as List<dynamic>) : [];
              if (subList.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sub-Medical History for $history',
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
                        children: subList.map<Widget>((subHistoryData) {
                          final subHistoryName = subHistoryData['name'] as String;
                          bool isSelected = primaryMedicalHistoryController.selectedsubMedicalHistory[history]?.contains(subHistoryName) ?? false;
                          return ChoiceChip(
                            checkmarkColor: themeController.isDay.value
                                ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.5)
                                : QuickTechAppColors.darkmaintextcolor,
                            side: BorderSide(
                              color: isSelected
                                  ? QuickTechAppColors.lightmaincolor
                                  : QuickTechAppColors.darkmaincolor,
                              width: isSelected ? 2 : 0,
                            ),
                            selectedColor: themeController.isDay.value
                                ? QuickTechAppColors.greyOpacity2
                                : QuickTechAppColors.bkdarktxtfld.withValues(alpha: 0.9),
                            backgroundColor: themeController.isDay.value
                                ? QuickTechAppColors.whiteOpacity
                                : QuickTechAppColors.bkdarktxtfld,
                            label: Text(
                              subHistoryName,
                              style: myStyle(
                                12,
                                isSelected
                                    ? (themeController.isDay.value
                                        ? QuickTechAppColors.lightmaintextcolor
                                        : QuickTechAppColors.darkmaintextcolor)
                                    : (themeController.isDay.value
                                        ? QuickTechAppColors.lightmaintextcolor
                                        : QuickTechAppColors.darkmaintextcolor),
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                primaryMedicalHistoryController.addSubMedicalHistory(history, subHistoryName);
                              } else {
                                primaryMedicalHistoryController.removeSubMedicalHistory(history, subHistoryName);
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
            }).toList(),
          );
        }),
        // Other medical history details field
        if (primaryMedicalHistoryController.selectedMedicalHistory.contains('Other'))
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
                labelText: 'Other Medical History Details',
              ),
              onChanged: (value) => primaryMedicalHistoryController.otherMedicalHistory.value = value,
            ),
          ),
 
      ],
    );
  }
}

// Primary Medical History Dropdown Widget
class PrimaryMedicalHistoryDropdown extends StatelessWidget {
  const PrimaryMedicalHistoryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => primaryMedicalHistoryController.toggleMedicalHistoryDropdown(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: themeController.isDay.value
                    ? QuickTechAppColors.white
                    : QuickTechAppColors.bkdarktxtfld,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: themeController.isDay.value
                      ? QuickTechAppColors.lightmaincolor
                      : QuickTechAppColors.darkmaincolor,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Primary Medical History',
                    style: myStyle(
                      14,
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaintextcolor
                          : QuickTechAppColors.darkmaintextcolor,
                      FontWeight.normal,
                    ),
                  ),
                  Icon(
                    primaryMedicalHistoryController.isMedicalHistoryDropdownOpen.value
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: themeController.isDay.value
                        ? QuickTechAppColors.lightmaincolor
                        : QuickTechAppColors.darkmaincolor
                  ),
                ],
              ),
            ),
          ),
          if (primaryMedicalHistoryController.isMedicalHistoryDropdownOpen.value)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: themeController.isDay.value
                    ? QuickTechAppColors.white
                    : QuickTechAppColors.bkdarktxtfld,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: themeController.isDay.value
                      ? QuickTechAppColors.lightmaincolor
                      : QuickTechAppColors.darkmaincolor,
                ),
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
                    controller: primaryMedicalHistoryController.medicalHistorySearchController,
                    onChanged: (value) {
                      primaryMedicalHistoryController.medicalhistorySearchText.value = value;
                      primaryMedicalHistoryController.searchMedicalHistory(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search medical history...',
                      hintStyle: myStyle(
                        14,
                        themeController.isDay.value
                            ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.5)
                            : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.5),
                        FontWeight.normal,
                      ),
                      border: InputBorder.none,
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search,
                            color: themeController.isDay.value
                                ? QuickTechAppColors.lightmaincolor
                                : QuickTechAppColors.darkmaincolor,
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
                                title: 'Add Multiple Medical Histories',
                                hintText: 'Enter medical history name',
                                addButtonLabel: 'Add History',
                                addAllButtonLabel: 'Add All Histories',
                                onItemsAdded: (items) {
                                  for (var history in items) {
                                    primaryMedicalHistoryController.addMedicalHistory(history);
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
                  // Medical history list
                  Obx(() {
                    if (primaryMedicalHistoryController.isLoadingMedicalHistory.value) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final searchText = primaryMedicalHistoryController.medicalhistorySearchText.value;
                    if (primaryMedicalHistoryController.filteredMedicalHistory.isEmpty) {
                      return Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: Text('No medical history found.')),
                          ),
                          if (searchText.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Add "$searchText"',
                                      style: myStyle(
                                        12,
                                        themeController.isDay.value
                                            ? QuickTechAppColors.lightmaintextcolor
                                            : QuickTechAppColors.darkmaintextcolor,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: themeController.isDay.value
                                          ? QuickTechAppColors.lightmaintextcolor
                                          : QuickTechAppColors.darkmaintextcolor,
                                    ),
                                    onPressed: () {
                                      primaryMedicalHistoryController.addMedicalHistory(searchText);
                                      primaryMedicalHistoryController.medicalHistorySearchController.clear();
                                      primaryMedicalHistoryController.medicalhistorySearchText.value = '';
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
                            itemCount: primaryMedicalHistoryController.filteredMedicalHistory.length,
                            itemBuilder: (context, index) {
                              final history = primaryMedicalHistoryController.filteredMedicalHistory[index];
                              return ListTile(
                                title: Text(
                                  history,
                                  style: myStyle(
                                    14,
                                    themeController.isDay.value
                                        ? QuickTechAppColors.lightmaintextcolor
                                        : QuickTechAppColors.darkmaintextcolor,
                                    FontWeight.normal,
                                  ),
                                ),
                                onTap: () {
                                  primaryMedicalHistoryController.addMedicalHistory(history);
                                  primaryMedicalHistoryController.medicalHistorySearchController.clear();
                                  primaryMedicalHistoryController.medicalhistorySearchText.value = '';
                                },
                              );
                            },
                          ),
                        ),
                        if (searchText.isNotEmpty &&
                            !primaryMedicalHistoryController.filteredMedicalHistory.contains(searchText))
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Add "$searchText"',
                                    style: myStyle(
                                      12,
                                      themeController.isDay.value
                                          ? QuickTechAppColors.lightmaintextcolor
                                          : QuickTechAppColors.darkmaintextcolor,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: themeController.isDay.value
                                        ? QuickTechAppColors.lightmaintextcolor
                                        : QuickTechAppColors.darkmaintextcolor,
                                  ),
                                  onPressed: () {
                                    primaryMedicalHistoryController.addMedicalHistory(searchText);
                                    primaryMedicalHistoryController.medicalHistorySearchController.clear();
                                    primaryMedicalHistoryController.medicalhistorySearchText.value = '';
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
