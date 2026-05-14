
//Suggested Assestive Device
import 'package:e_prescription/const/quick_tech_app_colors.dart';

import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/assestive_device/quick_tech_assestive_device_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

final QuickTechAssestiveDeviceController assestiveDeviceController = locator.get<QuickTechAssestiveDeviceController>();
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
Widget AssestiveDeviceDropdown() {
  return Obx(() {
    return Column(
      children: [
        OutlinedButton(
          onPressed: assestiveDeviceController.toggleassestiveDeviceDropdown,
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightScaffoldColor
                    : QuickTechAppColors.darkScaffoldColor,
            shadowColor:
                themeController.isDay.value
                    ? QuickTechAppColors.black.withValues(alpha: 0.5)
                    : QuickTechAppColors.white.withValues(alpha: 0.3),
            elevation: 5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Assestive Device',
                style: myStyle(
                  15,
                  themeController.isDay.value
                      ? QuickTechAppColors.black2
                      : QuickTechAppColors.whiteOpacity,
                ),
              ),
              Icon(
                assestiveDeviceController.isAssestiveDeviceDropdownOpen.value
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down,
                color:
                    themeController.isDay.value
                        ? QuickTechAppColors.lightmaintextcolor
                        : QuickTechAppColors.darkmaintextcolor,
              ),
            ],
          ),
        ),

        if (assestiveDeviceController.isAssestiveDeviceDropdownOpen.value)
          Card(
            color:
                themeController.isDay.value
                    ? QuickTechAppColors.white
                    : QuickTechAppColors.bkdarktxtfld.withValues(alpha: 0.7),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QuickTechCustomTextField(
                      lebelcolor:
                          themeController.isDay.value
                              ? QuickTechAppColors.lightmaintextcolor
                              : QuickTechAppColors.darkmaintextcolor,
                      label: 'Search Suggested Assestive Device',
                      controller:
                          assestiveDeviceController.assestiveDeviceSearchController,
                      onchanged:
                          (value) =>
                              assestiveDeviceController.assestiveDeviceText.value =
                                  value,
                      backcolor:
                          themeController.isDay.value
                              ? QuickTechAppColors.white
                              : QuickTechAppColors.bkdarktxtfld,
                      icon: Icons.search,
                      iconcolor:
                          themeController.isDay.value
                              ? QuickTechAppColors.lightmaintextcolor
                              : QuickTechAppColors.darkmaintextcolor,
                      txtcolor:
                          themeController.isDay.value
                              ? QuickTechAppColors.lightmaintextcolor
                              : QuickTechAppColors.darkmaintextcolor,
                    ),
                  ),

                  // List of Assestive device
                  Container(
                    constraints: BoxConstraints(maxHeight: 200),
                    child: SingleChildScrollView(
                      child: Column(
                        children:
                            assestiveDeviceController.filteredassestiveDevice.map((
                              assestiveDevice,
                            ) {
                              return ListTile(
                                title: Text(
                                  assestiveDevice,
                                  style: myStyle(
                                    14,
                                    themeController.isDay.value
                                        ? QuickTechAppColors.lightmaintextcolor
                                        : QuickTechAppColors.darkmaintextcolor,
                                  ),
                                ),
                                onTap: () {
                                  assestiveDeviceController.addsuggestiveDevice(
                                    assestiveDevice,
                                  );
                                  /*  prescrptionController
                                      .isAssestiveDeviceDropdownOpen
                                      .value = false;*/
                                  assestiveDeviceController
                                      .assestiveDeviceText
                                      .value = '';
                                },
                              );
                            }).toList(),
                      ),
                    ),
                  ),

                  // Option to add new Assetive Device if searching
                  if (assestiveDeviceController.assestiveDeviceText.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Add "${assestiveDeviceController.assestiveDeviceText.value}"',
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
                              color:
                                  themeController.isDay.value
                                      ? QuickTechAppColors.lightmaintextcolor
                                      : QuickTechAppColors.darkmaintextcolor,
                            ),
                            onPressed: () {
                              final newAssestiveDevice =
                                  assestiveDeviceController
                                      .assestiveDeviceText
                                      .value;
                              if (newAssestiveDevice.isNotEmpty) {
                           
                                assestiveDeviceController.addsuggestiveDevice(
                                  newAssestiveDevice,
                                );
                                assestiveDeviceController
                                    .isAssestiveDeviceDropdownOpen
                                    .value = false;
                                assestiveDeviceController
                                    .assestiveDeviceText
                                    .value = '';
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  });
}
