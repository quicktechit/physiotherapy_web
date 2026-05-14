import 'package:e_prescription/const/quick_tech_app_colors.dart';
// import 'package:e_prescription/const/quick_tech_static_data.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/assestive_device_controller.dart';
import 'package:e_prescription/widgets/quick_tech_add_multiple_items_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';


final AssestiveDeviceController assestiveDeviceController = locator.get<AssestiveDeviceController>();
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

class AssestiveDeviceSection extends StatelessWidget {
  const AssestiveDeviceSection({super.key});

  @override
  Widget build(BuildContext context) {
    assestiveDeviceController.fetchAssestiveDevices();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AssestiveDeviceDropdown(),
        const SizedBox(height: 10),
        // Selected Assestive Device Chips
        Obx(
          () => Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: assestiveDeviceController.selectedAssestiveDevice.map((device) {
              return Chip(
                deleteIconColor: themeController.isDay.value
                    ? QuickTechAppColors.bkdarktxtfld
                    : QuickTechAppColors.whiteOpacity,
                backgroundColor: themeController.isDay.value
                    ? QuickTechAppColors.whiteOpacity
                    : QuickTechAppColors.bkdarktxtfld,
                label: Text(
                  device,
                  style: myStyle(
                    14,
                    themeController.isDay.value
                        ? QuickTechAppColors.lightmaintextcolor
                        : QuickTechAppColors.darkmaintextcolor,
                    FontWeight.bold,
                  ),
                ),
                onDeleted: () => assestiveDeviceController.removeAssestiveDevice(device),
              );
            }).toList(),
          ),
        ),
        // Sub-assestive device for each device
        Obx(() {
          return Column(
            children: assestiveDeviceController.selectedAssestiveDevice.map((device) {
              final subcategoryData = assestiveDeviceController.assestiveDeviceMap[device];
              final subList = subcategoryData != null ? (subcategoryData['children'] as List<dynamic>) : [];
              if (subList.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sub-Assestive Device for $device',
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
                          bool isSelected = assestiveDeviceController.selectedsubAssestiveDevice[device]?.contains(subHistoryName) ?? false;
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
                              assestiveDeviceController.addSubAssestiveDevice(device, subHistoryName);
                            } else {
                              assestiveDeviceController.removeSubAssestiveDevice(device, subHistoryName);
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
        // Other assestive device details field
        if (assestiveDeviceController.selectedAssestiveDevice.contains('Other'))
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
                labelText: 'Other Assestive Device Details',
              ),
              onChanged: (value) => assestiveDeviceController.otherSuggestiveDevice.value = value,
            ),
          ),
         
      ],
    );
  }
}

// Assestive Device Dropdown Widget
class AssestiveDeviceDropdown extends StatelessWidget {
  const AssestiveDeviceDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (assestiveDeviceController.error.value.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            assestiveDeviceController.error.value,
            style: myStyle(14, Colors.red, FontWeight.bold),
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => assestiveDeviceController.toggleAssestiveDeviceDropdown(),
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
                    'Assestive Device',
                    style: myStyle(
                      14,
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaintextcolor
                          : QuickTechAppColors.darkmaintextcolor,
                      FontWeight.normal,
                    ),
                  ),
                  Icon(
                    assestiveDeviceController.isAssestiveDeviceDropdownOpen.value
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
          if (assestiveDeviceController.isAssestiveDeviceDropdownOpen.value)
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
                    controller: assestiveDeviceController.assestiveDeviceSearchController,
                    onChanged: (value) {
                      assestiveDeviceController.assestiveDeviceText.value = value;
                      assestiveDeviceController.searchAssestiveDevice(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search assestive device...',
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
                                title: 'Add Multiple Assistive Devices',
                                hintText: 'Enter device name',
                                addButtonLabel: 'Add Device',
                                addAllButtonLabel: 'Add All Devices',
                                onItemsAdded: (items) {
                                  for (var device in items) {
                                    assestiveDeviceController.addAssestiveDevice(device);
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
                  // Assestive device list
                  Obx(() {
                    if (assestiveDeviceController.isLoading.value) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final searchText = assestiveDeviceController.assestiveDeviceText.value;
                    if (assestiveDeviceController.filteredAssestiveDevice.isEmpty) {
                      return Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: Text('No assestive device found.')),
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
                                      assestiveDeviceController.addAssestiveDevice(searchText);
                                      assestiveDeviceController.assestiveDeviceSearchController.clear();
                                      assestiveDeviceController.assestiveDeviceText.value = '';
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
                            itemCount: assestiveDeviceController.filteredAssestiveDevice.length,
                            itemBuilder: (context, index) {
                              final device = assestiveDeviceController.filteredAssestiveDevice[index];
                              return ListTile(
                                title: Text(
                                  device,
                                  style: myStyle(
                                    14,
                                    themeController.isDay.value
                                        ? QuickTechAppColors.lightmaintextcolor
                                        : QuickTechAppColors.darkmaintextcolor,
                                    FontWeight.normal,
                                  ),
                                ),
                                onTap: () {
                                  assestiveDeviceController.addAssestiveDevice(device);
                                  assestiveDeviceController.assestiveDeviceSearchController.clear();
                                  assestiveDeviceController.assestiveDeviceText.value = '';
                                },
                              );
                            },
                          ),
                        ),
                        if (searchText.isNotEmpty &&
                            !assestiveDeviceController.filteredAssestiveDevice.contains(searchText))
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
                                    assestiveDeviceController.addAssestiveDevice(searchText);
                                    assestiveDeviceController.assestiveDeviceSearchController.clear();
                                    assestiveDeviceController.assestiveDeviceText.value = '';
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
