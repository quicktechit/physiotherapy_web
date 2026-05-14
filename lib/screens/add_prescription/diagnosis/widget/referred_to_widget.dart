import 'package:e_prescription/const/quick_tech_app_colors.dart';

import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/referred_to_controller.dart';
import 'package:e_prescription/widgets/quick_tech_add_multiple_items_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:e_prescription/locator.dart';

final ReferredToController referredToController = locator.get<ReferredToController>();
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

class ReferredToSection extends StatelessWidget {
  const ReferredToSection({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (referredToController.filteredReferredTo.isEmpty && !referredToController.isLoading.value) {
        referredToController.fetchReferredTo();
      }
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReferredToDropdown(),
        const SizedBox(height: 10),
        // Selected Referred To Chips
        Obx(
          () => Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: referredToController.selectedReferredTo.map((referred) {
              return Chip(
                deleteIconColor: themeController.isDay.value
                    ? QuickTechAppColors.bkdarktxtfld
                    : QuickTechAppColors.whiteOpacity,
                backgroundColor: themeController.isDay.value
                    ? QuickTechAppColors.whiteOpacity
                    : QuickTechAppColors.bkdarktxtfld,
                label: Text(
                  referred,
                  style: myStyle(
                    14,
                    themeController.isDay.value
                        ? QuickTechAppColors.lightmaintextcolor
                        : QuickTechAppColors.darkmaintextcolor,
                    FontWeight.bold,
                  ),
                ),
                onDeleted: () => referredToController.removeReferredTo(referred),
              );
            }).toList(),
          ),
        ),
        // Sub-referred to for each referred
        Obx(() {
          return Column(
            children: referredToController.selectedReferredTo.map((referred) {
            final subcategoryData = referredToController.referredToMap[referred];
              final subList = subcategoryData != null ? (subcategoryData['children'] as List<dynamic>) : [];
              if (subList.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sub-Referred To for $referred',
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
                          bool isSelected = referredToController.selectedsubReferredTo[referred]?.contains(subHistoryName) ?? false;
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
                              referredToController.addSubReferredTo(referred, subHistoryName);
                            } else {
                              referredToController.removeSubReferredTo(referred, subHistoryName);
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
        // Other referred to details field
        if (referredToController.selectedReferredTo.contains('Other'))
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
                labelText: 'Other Referred To Details',
              ),
              onChanged: (value) => referredToController.otherreferredTo.value = value,
            ),
          ),
      
      ],
    );
  }
}

// Referred To Dropdown Widget
class ReferredToDropdown extends StatelessWidget {
  const ReferredToDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (referredToController.error.value.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            referredToController.error.value,
            style: myStyle(14, Colors.red, FontWeight.bold),
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => referredToController.toggleReferredToDropdown(),
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
                    'Referred To',
                    style: myStyle(
                      14,
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaintextcolor
                          : QuickTechAppColors.darkmaintextcolor,
                      FontWeight.normal,
                    ),
                  ),
                  Icon(
                    referredToController.isReferredDropdownOpen.value
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
          if (referredToController.isReferredDropdownOpen.value)
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
                    controller: referredToController.referredToSearchController,
                    onChanged: (value) {
                      referredToController.referredToText.value = value;
                      referredToController.searchReferredTo(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search referred to...',
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
                                title: 'Add Multiple Referrals',
                                hintText: 'Enter referred to name',
                                addButtonLabel: 'Add Referral',
                                addAllButtonLabel: 'Add All Referrals',
                                onItemsAdded: (items) {
                                  for (var referred in items) {
                                    referredToController.addReferredTo(referred);
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
                  // Referred to list
                  Obx(() {
                    if (referredToController.isLoading.value) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final searchText = referredToController.referredToText.value;
                    if (referredToController.filteredReferredTo.isEmpty) {
                      return Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: Text('No referred to found.')),
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
                                      referredToController.addReferredTo(searchText);
                                      referredToController.referredToSearchController.clear();
                                      referredToController.referredToText.value = '';
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
                            itemCount: referredToController.filteredReferredTo.length,
                            itemBuilder: (context, index) {
                              final referred = referredToController.filteredReferredTo[index];
                              return ListTile(
                                title: Text(
                                  referred,
                                  style: myStyle(
                                    14,
                                    themeController.isDay.value
                                        ? QuickTechAppColors.lightmaintextcolor
                                        : QuickTechAppColors.darkmaintextcolor,
                                    FontWeight.normal,
                                  ),
                                ),
                                onTap: () {
                                  referredToController.addReferredTo(referred);
                                  referredToController.referredToSearchController.clear();
                                  referredToController.referredToText.value = '';
                                },
                              );
                            },
                          ),
                        ),
                        if (searchText.isNotEmpty &&
                            !referredToController.filteredReferredTo.contains(searchText))
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
                                    referredToController.addReferredTo(searchText);
                                    referredToController.referredToSearchController.clear();
                                    referredToController.referredToText.value = '';
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
