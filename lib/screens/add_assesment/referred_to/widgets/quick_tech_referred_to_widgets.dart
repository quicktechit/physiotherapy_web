import 'package:e_prescription/const/quick_tech_app_colors.dart';

import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/referred_to/quick_tech_referred_to_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
final QuickTechReferredToController referredToController = locator.get<QuickTechReferredToController>();
//Referred To
Widget ReferredToDropdown() {
  return Obx(() {
    return Column(
      children: [
        OutlinedButton(
          onPressed: referredToController.togglereferredToDropdown,
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
                'Referred To',
                style: myStyle(
                  15,
                  themeController.isDay.value
                      ? QuickTechAppColors.black2
                      : QuickTechAppColors.whiteOpacity,
                ),
              ),
              Icon(
                referredToController.isReferredDropdownOpen.value
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

        if (referredToController.isReferredDropdownOpen.value)
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
                      label: 'Search Referred To',
                      controller:
                          referredToController.referredToSearchController,
                      onchanged:
                          (value) =>
                              referredToController.referredToText.value =
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

                  // List of Referred To
                  Container(
                    constraints: BoxConstraints(maxHeight: 200),
                    child: SingleChildScrollView(
                      child: Column(
                        children:
                            referredToController.filteredreferredTo.map((
                              referredTo,
                            ) {
                              return ListTile(
                                title: Text(
                                  referredTo,
                                  style: myStyle(
                                    14,
                                    themeController.isDay.value
                                        ? QuickTechAppColors.lightmaintextcolor
                                        : QuickTechAppColors.darkmaintextcolor,
                                  ),
                                ),
                                onTap: () {
                                  referredToController.addReferredTo(
                                    referredTo,
                                  );
                                  /*   prescrptionController
                                      .isReferredDropdownOpen
                                      .value = false;*/
                                  referredToController.referredToText.value =
                                      '';
                                },
                              );
                            }).toList(),
                      ),
                    ),
                  ),

                  // Option to add new Referred to if searching
                  if (referredToController.referredToText.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Add "${referredToController.referredToText.value}"',
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
                              final newReferredTo =
                                  referredToController.referredToText.value;
                              if (newReferredTo.isNotEmpty) {
                         
                                referredToController.addReferredTo(
                                  newReferredTo,
                                );
                                referredToController
                                    .isReferredDropdownOpen
                                    .value = false;
                                referredToController.referredToText.value = '';
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