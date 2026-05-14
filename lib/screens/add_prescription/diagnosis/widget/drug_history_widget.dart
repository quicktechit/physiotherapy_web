import 'package:e_prescription/const/quick_tech_app_colors.dart';

import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/drug_history_controller.dart';
import 'package:e_prescription/widgets/quick_tech_add_multiple_items_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:e_prescription/locator.dart';

final DrugHistoryController drugHistoryController = locator.get<DrugHistoryController>();
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

class DrugHistorySection extends StatelessWidget {
  const DrugHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    drugHistoryController.fetchDrugHistory();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrugHistoryDropdown(),
    
        // Selected Drug History Chips
        Obx(
          () => Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: drugHistoryController.selectedDrugHistory.map((history) {
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
                onDeleted: () => drugHistoryController.removeDrugHistory(history),
              );
            }).toList(),
          ),
        ),
        // Sub-drug history for each drug history
        Obx(() {
          return Column(
            children: drugHistoryController.selectedDrugHistory.map((history) {
         final subcategoryData = drugHistoryController.drugHistoryMap[history];
              final subList = subcategoryData != null ? (subcategoryData['children'] as List<dynamic>) : [];
              if (subList.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sub-Drug History for $history',
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
                          bool isSelected = drugHistoryController.selectedsubDrugHistory[history]?.contains(subHistoryName) ?? false;
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
                                drugHistoryController.addSubDrugHistory(history, subHistoryName);
                              } else {
                                drugHistoryController.removeSubDrugHistory(history, subHistoryName);
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
        // Other drug history details field
        if (drugHistoryController.selectedDrugHistory.contains('Other'))
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
                labelText: 'Other Drug History Details',
              ),
              onChanged: (value) => drugHistoryController.otherDrugHistory.value = value,
            ),
          ),
       
      ],
    );
  }
}

// Drug History Dropdown Widget
class DrugHistoryDropdown extends StatelessWidget {
  const DrugHistoryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => drugHistoryController.toggleDrugHistoryDropdown(),
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
                    'Drug History',
                    style: myStyle(
                      14,
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaintextcolor
                          : QuickTechAppColors.darkmaintextcolor,
                      FontWeight.normal,
                    ),
                  ),
                  Icon(
                    drugHistoryController.isDrugHistoryDropdownOpen.value
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: themeController.isDay.value
                        ? QuickTechAppColors.lightmaincolor
                        : QuickTechAppColors.darkmaincolor,
                  ),
                ],
              ),
            ),
          ),
          if (drugHistoryController.isDrugHistoryDropdownOpen.value)
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
                    controller: drugHistoryController.drugHistorySearchController,
                    onChanged: (value) {
                      drugHistoryController.drughistorySearchText.value = value;
                      drugHistoryController.searchDrugHistory(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search drug history...',
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
                                title: 'Add Multiple Drug Histories',
                                hintText: 'Enter drug history name',
                                addButtonLabel: 'Add History',
                                addAllButtonLabel: 'Add All Histories',
                                onItemsAdded: (items) {
                                  for (var history in items) {
                                    drugHistoryController.addDrugHistory(history);
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
                  // Drug history list
                  Obx(() {
                    if (drugHistoryController.isLoadingDrugHistory.value) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final searchText = drugHistoryController.drughistorySearchText.value;
                    if (drugHistoryController.filteredDrugHistory.isEmpty) {
                      return Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: Text('No drug history found.')),
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
                                      drugHistoryController.addDrugHistory(searchText);
                                      drugHistoryController.drugHistorySearchController.clear();
                                      drugHistoryController.drughistorySearchText.value = '';
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
                            itemCount: drugHistoryController.filteredDrugHistory.length,
                            itemBuilder: (context, index) {
                              final history = drugHistoryController.filteredDrugHistory[index];
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
                                  drugHistoryController.addDrugHistory(history);
                                  drugHistoryController.drugHistorySearchController.clear();
                                  drugHistoryController.drughistorySearchText.value = '';
                                },
                              );
                            },
                          ),
                        ),
                        if (searchText.isNotEmpty &&
                            !drugHistoryController.filteredDrugHistory.contains(searchText))
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
                                    drugHistoryController.addDrugHistory(searchText);
                                    drugHistoryController.drugHistorySearchController.clear();
                                    drugHistoryController.drughistorySearchText.value = '';
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
