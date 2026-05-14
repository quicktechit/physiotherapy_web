import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/radiological_findings_controller.dart';
import 'package:e_prescription/widgets/quick_tech_add_multiple_items_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:e_prescription/locator.dart';

final RadiologicalFindingsController radiologicalFindingsController = locator.get<RadiologicalFindingsController>();
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

class RadiologicalFindingsSection extends StatelessWidget {
  const RadiologicalFindingsSection({super.key});

  @override
  Widget build(BuildContext context) {
   radiologicalFindingsController.fetchRadiologicalFindings();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadiologicalFindingsDropdown(),
        const SizedBox(height: 10),
        // Selected Radiological Findings Chips
        Obx(
          () => Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: radiologicalFindingsController.selectedRadioLogicalFindings.map((finding) {
              return Chip(
                deleteIconColor: themeController.isDay.value
                    ? QuickTechAppColors.bkdarktxtfld
                    : QuickTechAppColors.whiteOpacity,
                backgroundColor: themeController.isDay.value
                    ? QuickTechAppColors.whiteOpacity
                    : QuickTechAppColors.bkdarktxtfld,
                label: Text(
                  finding,
                  style: myStyle(
                    14,
                    themeController.isDay.value
                        ? QuickTechAppColors.lightmaintextcolor
                        : QuickTechAppColors.darkmaintextcolor,
                    FontWeight.bold,
                  ),
                ),
                onDeleted: () => radiologicalFindingsController.removeRadiologicalFinding(finding),
              );
            }).toList(),
          ),
        ),
        // Sub-findings for each radiological finding
        Obx(() {
          return Column(
            children: radiologicalFindingsController.selectedRadioLogicalFindings.map((finding) {
              final subcategoryData = radiologicalFindingsController.radiologicalFindingsMap[finding];
              final subList = subcategoryData != null ? (subcategoryData['children'] as List<dynamic>) : [];
              if (subList.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sub-findings for $finding',
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
                        children: subList.map<Widget>((subFindingData) {
                          final subFindingName = subFindingData['name'] as String;
                          bool isSelected = radiologicalFindingsController.selectedsubRadiologicalFindings[finding]?.contains(subFindingName) ?? false;
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
                              subFindingName,
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
                                radiologicalFindingsController.addSubRadiologicalFinding(finding, subFindingName);
                              } else {
                                radiologicalFindingsController.removeSubRadiologicalFinding(finding, subFindingName);
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
        // Other radiological finding details field
        if (radiologicalFindingsController.selectedRadioLogicalFindings.contains('Other'))
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
                labelText: 'Other Radiological Finding Details',
              ),
              onChanged: (value) => radiologicalFindingsController.otherRadiologicalFindings.value = value,
            ),
          ),

      ],
    );
  }
}

// Radiological Findings Dropdown Widget
class RadiologicalFindingsDropdown extends StatelessWidget {
  const RadiologicalFindingsDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => radiologicalFindingsController.toggleRadiologicalFindingsDropdown(),
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
                    'Radiological Findings',
                    style: myStyle(
                      14,
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaintextcolor
                          : QuickTechAppColors.darkmaintextcolor,
                      FontWeight.normal,
                    ),
                  ),
                  Icon(
                    radiologicalFindingsController.isRadiologicalFindingsDropdownOpen.value
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
          if (radiologicalFindingsController.isRadiologicalFindingsDropdownOpen.value)
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
                    controller: radiologicalFindingsController.radiologicalFindingsearchController,
                    onChanged: (value) {
                      radiologicalFindingsController.radiologicalfindingSearchText.value = value;
                      radiologicalFindingsController.searchRadiologicalFindings(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search radiological findings...',
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
                                title: 'Add Multiple Radiological Findings',
                                hintText: 'Enter finding name',
                                addButtonLabel: 'Add Finding',
                                addAllButtonLabel: 'Add All Findings',
                                onItemsAdded: (items) {
                                  for (var finding in items) {
                                    radiologicalFindingsController.addRadiologicalFinding(finding);
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
                  // Findings list
                  Obx(() {
                    if (radiologicalFindingsController.isLoadingRadiologicalFindings.value) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final searchText = radiologicalFindingsController.radiologicalfindingSearchText.value;
                    if (radiologicalFindingsController.filteredRadiologicalFindings.isEmpty) {
                      return Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: Text('No radiological findings found.')),
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
                                      radiologicalFindingsController.addRadiologicalFinding(searchText);
                                      radiologicalFindingsController.radiologicalFindingsearchController.clear();
                                      radiologicalFindingsController.radiologicalfindingSearchText.value = '';
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
                            itemCount: radiologicalFindingsController.filteredRadiologicalFindings.length,
                            itemBuilder: (context, index) {
                              final finding = radiologicalFindingsController.filteredRadiologicalFindings[index];
                              return ListTile(
                                title: Text(
                                  finding,
                                  style: myStyle(
                                    14,
                                    themeController.isDay.value
                                        ? QuickTechAppColors.lightmaintextcolor
                                        : QuickTechAppColors.darkmaintextcolor,
                                    FontWeight.normal,
                                  ),
                                ),
                                onTap: () {
                                  radiologicalFindingsController.addRadiologicalFinding(finding);
                                  radiologicalFindingsController.radiologicalFindingsearchController.clear();
                                  radiologicalFindingsController.radiologicalfindingSearchText.value = '';
                                },
                              );
                            },
                          ),
                        ),
                        if (searchText.isNotEmpty &&
                            !radiologicalFindingsController.filteredRadiologicalFindings.contains(searchText))
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
                                    radiologicalFindingsController.addRadiologicalFinding(searchText);
                                    radiologicalFindingsController.radiologicalFindingsearchController.clear();
                                    radiologicalFindingsController.radiologicalfindingSearchText.value = '';
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
