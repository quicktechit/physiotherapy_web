import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';

import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/on_examination_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/screens/add_prescription/widgets/quick_tech_prescription_widgets.dart';
import 'package:e_prescription/widgets/quick_tech_add_multiple_items_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


final OnExaminationController examinationController = locator.get<OnExaminationController>();
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

class OnExaminationSection extends StatelessWidget {
  const OnExaminationSection({super.key});

  @override
  Widget build(BuildContext context) {
    examinationController.fetchOnExaminations();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OnExaminationDropdown(),
        const SizedBox(height: 10),
        // Selected Examinations Chips
        Obx(
          () => Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: examinationController.selectedExaminations.map((examination) {
              return Chip(
                deleteIconColor: themeController.isDay.value
                    ? QuickTechAppColors.bkdarktxtfld
                    : QuickTechAppColors.whiteOpacity,
                backgroundColor: themeController.isDay.value
                    ? QuickTechAppColors.whiteOpacity
                    : QuickTechAppColors.bkdarktxtfld,
                label: Text(
                  examination,
                  style: myStyle(
                    14,
                    themeController.isDay.value
                        ? QuickTechAppColors.lightmaintextcolor
                        : QuickTechAppColors.darkmaintextcolor,
                    FontWeight.bold,
                  ),
                ),
                onDeleted: () => examinationController.removeExamination(examination),
              );
            }).toList(),
          ),
        ),
        // Sub-examinations for each examination
        Obx(() {
          return Column(
            children: examinationController.selectedExaminations.map((examination) {
              final subcategoryData = examinationController.onExaminationMap[examination];
              final subList = subcategoryData != null ? (subcategoryData['children'] as List<dynamic>) : [];
              if (subList.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sub-examinations for $examination',
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
                        children: subList.map<Widget>((subExaminationData) {
                          final subExaminationName = subExaminationData['name'] as String;
                          bool isSelected = examinationController
                                  .selectedSubExaminations[examination]
                                  ?.contains(subExaminationName) ??
                              false;
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
                              subExaminationName,
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
                                examinationController.addSubExamination(
                                  examination,
                                  subExaminationName,
                                );
                              } else {
                                examinationController.removeSubExamination(
                                  examination,
                                  subExaminationName,
                                );
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
     
        Obx(() {
          return Column(
            children: examinationController.selectedExaminations.map((examination) {
              if (examinationController.showDetailsField(examination)) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, right: 100),
                  child: customTextField(
                    keyboardType: TextInputType.number,
                    icon: Icons.input,
                    ' $examination ',
                    examinationController.getDetailsController(examination),
                  ),
                );
              }
              return const SizedBox();
            }).toList(),
          );
        }),
    
      ],
    );
  }
}

// On Examination Dropdown Widget
class OnExaminationDropdown extends StatelessWidget {
  const OnExaminationDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => examinationController.toggleDropdown(),
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
                    'On Examinations',
                    style: myStyle(
                      14,
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaintextcolor
                          : QuickTechAppColors.darkmaintextcolor,
                      FontWeight.normal,
                    ),
                  ),
                  Icon(
                    examinationController.isDropdownOpen.value
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
          if (examinationController.isDropdownOpen.value)
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
                    controller: examinationController.searchController,
                    onChanged: (value) {
                      examinationController.searchText.value = value;
                      examinationController.searchOnExaminations(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search examinations...',
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
                                title: 'Add Multiple Examinations',
                                hintText: 'Enter examination name',
                                addButtonLabel: 'Add Examination',
                                addAllButtonLabel: 'Add All Examinations',
                                onItemsAdded: (items) {
                                  for (var examination in items) {
                                    examinationController.addExamination(examination);
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
                  // Examinations list
                  Obx(() {
                    if (examinationController.isLoadingOnExaminations.value) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final searchText = examinationController.searchText.value;
                    if (examinationController.filteredExaminations.isEmpty) {
                      return Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: Text('No examinations found.')),
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
                                      examinationController.addExamination(searchText);
                                      examinationController.searchController.clear();
                                      examinationController.searchText.value = '';
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
                            itemCount: examinationController.filteredExaminations.length,
                            itemBuilder: (context, index) {
                              final examination = examinationController.filteredExaminations[index];
                              return ListTile(
                                title: Text(
                                  examination,
                                  style: myStyle(
                                    14,
                                    themeController.isDay.value
                                        ? QuickTechAppColors.lightmaintextcolor
                                        : QuickTechAppColors.darkmaintextcolor,
                                    FontWeight.normal,
                                  ),
                                ),
                                onTap: () {
                                  examinationController.addExamination(examination);
                                  examinationController.searchController.clear();
                                  examinationController.searchText.value = '';
                                },
                              );
                            },
                          ),
                        ),
                        if (searchText.isNotEmpty &&
                            !examinationController.filteredExaminations.contains(searchText))
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
                                    examinationController.addExamination(searchText);
                                    examinationController.searchController.clear();
                                    examinationController.searchText.value = '';
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