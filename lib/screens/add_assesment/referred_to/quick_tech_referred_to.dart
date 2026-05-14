import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/referred_to/quick_tech_referred_to_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/screens/add_assesment/referred_to/widgets/quick_tech_referred_to_widgets.dart';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

Widget ReferredTo() {
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechReferredToController referredToController = locator.get<QuickTechReferredToController>();

  // Idempotent: safe to call from build; it won't refetch once loaded.
  referredToController.ensureCategoryLoaded();
  
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Referred To',
        style: myStyle(
          20,
          themeController.isDay.value
              ? QuickTechAppColors.lightmaincolor
              : QuickTechAppColors.darkmaincolor,
          FontWeight.bold,
        ),
      ),
      ReferredToDropdown(),
      SizedBox(height: 16),
      Obx(() {
        final category = referredToController.referredToCategory.value;
        if (category == null) return SizedBox();
        return Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children:
              referredToController.selectedReferredTo.map((referredTo) {
                return Chip(
                  deleteIconColor:
                      themeController.isDay.value
                          ? QuickTechAppColors.bkdarktxtfld
                          : QuickTechAppColors.whiteOpacity,
                  backgroundColor:
                      themeController.isDay.value
                          ? QuickTechAppColors.whiteOpacity
                          : QuickTechAppColors.bkdarktxtfld,
                  label: Text(
                    referredTo,
                    style: myStyle(
                      14,
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaintextcolor
                          : QuickTechAppColors.darkmaintextcolor,
                      FontWeight.bold,
                    ),
                  ),
                  onDeleted:
                      () => referredToController.removeReferredTo(referredTo),
                );
              }).toList(),
        );
      }),
 
    ],
  );
}
