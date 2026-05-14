import 'package:e_prescription/const/quick_tech_app_colors.dart';

import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/disability_types_controller.dart';
import 'package:e_prescription/widgets/quick_tech_add_multiple_items_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:e_prescription/locator.dart';

final DisabilityTypesController disabilityTypesController = locator.get<DisabilityTypesController>();
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

class DisabilityTypesSection extends StatelessWidget {
  const DisabilityTypesSection({super.key});

  @override
  Widget build(BuildContext context) {
         disabilityTypesController.fetchDisabilityTypes();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DisabilityTypesDropdown(),
        const SizedBox(height: 10),
        // Selected Disability Types Chips
        Obx(
          () => Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: disabilityTypesController.selecteddisabilityTypes.map((disability) {
              return Chip(
                deleteIconColor: themeController.isDay.value
                    ? QuickTechAppColors.bkdarktxtfld
                    : QuickTechAppColors.whiteOpacity,
                backgroundColor: themeController.isDay.value
                    ? QuickTechAppColors.whiteOpacity
                    : QuickTechAppColors.bkdarktxtfld,
                label: Text(
                  disability,
                  style: myStyle(
                    14,
                    themeController.isDay.value
                        ? QuickTechAppColors.lightmaintextcolor
                        : QuickTechAppColors.darkmaintextcolor,
                    FontWeight.bold,
                  ),
                ),
                onDeleted: () => disabilityTypesController.removeDisabilityType(disability),
              );
            }).toList(),
          ),
        ),
        // Sub-types for each disability type
        Obx(() {
          return Column(
            children: disabilityTypesController.selecteddisabilityTypes.map((disability) {
              final subcategoryData = disabilityTypesController.disabilityTypesMap[disability];
              final subList = subcategoryData != null ? (subcategoryData['children'] as List<dynamic>) : [];
              if (subList.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sub-Types for $disability',
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
                          bool isSelected = disabilityTypesController.selectedSubDisabilityTypes[disability]?.contains(subHistoryName) ?? false;
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
                              disabilityTypesController.addSubDisabilityType(disability, subHistoryName);
                            } else {
                              disabilityTypesController.removeSubDisabilityType(disability, subHistoryName);
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
        // Other disability type details field
        if (disabilityTypesController.selecteddisabilityTypes.contains('Other'))
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
                labelText: 'Other Disability Type Details',
              ),
              onChanged: (value) => disabilityTypesController.otherDisabilitytypes.value = value,
            ),
          ),
        
      ],
    );
  }
}

// Disability Types Dropdown Widget
class DisabilityTypesDropdown extends StatelessWidget {
  const DisabilityTypesDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (disabilityTypesController.error.value.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            disabilityTypesController.error.value,
            style: myStyle(14, Colors.red, FontWeight.bold),
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => disabilityTypesController.toggleDisabilityTypesDropdown(),
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
                    'Types of Disabilities',
                    style: myStyle(
                      14,
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaintextcolor
                          : QuickTechAppColors.darkmaintextcolor,
                      FontWeight.normal,
                    ),
                  ),
                  Icon(
                    disabilityTypesController.isDisabilityTypesDropdownOpen.value
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
          if (disabilityTypesController.isDisabilityTypesDropdownOpen.value)
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
                    controller: disabilityTypesController.typesofDisabilitiesSearchController,
                    onChanged: (value) {
                      disabilityTypesController.disabilityTypeText.value = value;
                      disabilityTypesController.searchDisabilityTypes(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search types of disabilities...',
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
                                title: 'Add Multiple Disability Types',
                                hintText: 'Enter disability type name',
                                addButtonLabel: 'Add Type',
                                addAllButtonLabel: 'Add All Types',
                                onItemsAdded: (items) {
                                  for (var disability in items) {
                                    disabilityTypesController.addDisabilityType(disability);
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
                  // Disability types list with loading/empty state
                  Obx(() {
                    if (disabilityTypesController.isLoading.value) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final searchText = disabilityTypesController.disabilityTypeText.value;
                    if (disabilityTypesController.filteredDisabilityTypes.isEmpty) {
                      return Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: Text('No disability types found.')),
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
                                      disabilityTypesController.addDisabilityType(searchText);
                                      disabilityTypesController.typesofDisabilitiesSearchController.clear();
                                      disabilityTypesController.disabilityTypeText.value = '';
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
                            itemCount: disabilityTypesController.filteredDisabilityTypes.length,
                            itemBuilder: (context, index) {
                              final disability = disabilityTypesController.filteredDisabilityTypes[index];
                              return ListTile(
                                title: Text(
                                  disability,
                                  style: myStyle(
                                    14,
                                    themeController.isDay.value
                                        ? QuickTechAppColors.lightmaintextcolor
                                        : QuickTechAppColors.darkmaintextcolor,
                                    FontWeight.normal,
                                  ),
                                ),
                                onTap: () {
                                  disabilityTypesController.addDisabilityType(disability);
                                  disabilityTypesController.typesofDisabilitiesSearchController.clear();
                                  disabilityTypesController.disabilityTypeText.value = '';
                                },
                              );
                            },
                          ),
                        ),
                        if (searchText.isNotEmpty &&
                            !disabilityTypesController.filteredDisabilityTypes.contains(searchText))
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
                                    disabilityTypesController.addDisabilityType(searchText);
                                    disabilityTypesController.typesofDisabilitiesSearchController.clear();
                                    disabilityTypesController.disabilityTypeText.value = '';
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
