
import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/assestive_device/quick_tech_assestive_device_controller.dart';

import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/add_assesment/assestive_device/widgets/quick_tech_assestive_device_widgets.dart';
import 'package:e_prescription/screens/add_prescription/widgets/quick_tech_prescription_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

Widget AssestiveDevice() {
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechAssestiveDeviceController assestiveDeviceController = locator.get<QuickTechAssestiveDeviceController>();
  // Idempotent: safe to call from build; it won't refetch once loaded.
  assestiveDeviceController.ensureCategoryLoaded();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Assistive Device',
        style: myStyle(
          20,
          themeController.isDay.value
              ? QuickTechAppColors.lightmaincolor
              : QuickTechAppColors.darkmaincolor,
          FontWeight.bold,
        ),
      ),
      AssestiveDeviceDropdown(),
      SizedBox(height: 16),
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
                  : QuickTechAppColors.darktxtfieldcolor,
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
              onDeleted: () => assestiveDeviceController.removeSuggestiveDevice(device),
            );
          }).toList(),
        ),
      ),
      // Show Textfield For Selected ones
      Obx(() {
        return Column(
          children: assestiveDeviceController.selectedAssestiveDevice.map((device) {
            if (assestiveDeviceController.showDetailsField(device)) {
              return Padding(
                padding: EdgeInsets.only(top: 10),
                child: Padding(
                  padding: const EdgeInsets.only(right: 100),
                  child: customTextField(
                    icon: Icons.input,
                    ' $device Details',
                    assestiveDeviceController.getDetailsController(device),
                  ),
                ),
              );
            }
            return SizedBox();
          }).toList(),
        );
      }),
      Obx(() {
        final category = assestiveDeviceController.assestiveDeviceCategory.value;
        if (category == null) return SizedBox();
        return Column(
          children: assestiveDeviceController.selectedAssestiveDevice.map((device) {
            final sub = category.subCategories.firstWhereOrNull((s) => s.name == device);
            if (sub != null && sub.childCategories.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sub-Diagnosis for $device',
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
                      children: sub.childCategories.map((child) {
                        return ChoiceChip(
                          backgroundColor: themeController.isDay.value
                              ? QuickTechAppColors.whiteOpacity
                              : QuickTechAppColors.darktxtfieldcolor,
                          label: Text(
                            child.name,
                            style: myStyle(
                              12,
                              themeController.isDay.value
                                  ? (assestiveDeviceController.selectedsubAssestiveDevice[device]?.contains(child.name) ?? false
                                      ? QuickTechAppColors.lightmaintextcolor
                                      : QuickTechAppColors.lightmaintextcolor)
                                  : (assestiveDeviceController.selectedsubAssestiveDevice[device]?.contains(child.name) ?? false
                                      ? QuickTechAppColors.lightmaintextcolor
                                      : QuickTechAppColors.darkmaintextcolor),
                            ),
                          ),
                          selected: assestiveDeviceController.selectedsubAssestiveDevice[device]?.contains(child.name) ?? false,
                          onSelected: (selected) {
                            if (selected) {
                              assestiveDeviceController.addSubassestiveDevice(device, child.name);
                            } else {
                              assestiveDeviceController.removeSubAssestiveDevice(device, child.name);
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            }
            return SizedBox();
          }).toList(),
        );
      }),
   
    ],
  );
}
