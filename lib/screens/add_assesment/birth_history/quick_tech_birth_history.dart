import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/birth_history/quick_tech_birth_history_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/widgets/quick_tech_custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

Widget BirthHistory() {
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechBirthHistoryController birthHistoryController = locator.get<QuickTechBirthHistoryController>();
  
  return Column(
    children: [
      Text(
        'Birth History',
        style: myStyle(
          20,
          themeController.isDay.value
              ? QuickTechAppColors.lightmaincolor
              : QuickTechAppColors.darkmaincolor,
          FontWeight.bold,
        ),
      ),
      SizedBox(height: 15),
      
      // Birth Injury Dropdown
      QuickTechCustomDropDown(
        label: 'Birth injury',
        items: birthHistoryController.birthInjuryOptions,
        value: birthHistoryController.birthInjury.value,
        onChanged: (value) => birthHistoryController.updateBirthInjury(value!),
        icon: Icons.healing,
        isDay: themeController.isDay.value,
      ),
      SizedBox(height: 10),

      // Birth Weight Dropdown
      QuickTechCustomDropDown(
        label: 'Birth weight',
        items: birthHistoryController.birthWeightOptions,
        value: birthHistoryController.birthWeight.value,
        onChanged: birthHistoryController.updateBirthWeight,
        icon: Icons.scale,
        isDay: themeController.isDay.value,
         enableOthersOption: true,
            dialogTitle: "Add Weight",
            dialogHint: "Enter Weight",
      ),
      SizedBox(height: 10),

      // Complication Dropdown
      QuickTechCustomDropDown(
        label: 'Any complication during delivery',
        items: birthHistoryController.complicationOptions,
        value: birthHistoryController.complication.value,
        onChanged: (value) => birthHistoryController.updateComplication(value!),
        icon: Icons.warning,
        isDay: themeController.isDay.value,
      ),
      SizedBox(height: 10),

      // Pregnancy Maturity Dropdown
      QuickTechCustomDropDown(
        label: 'Pregnancy maturity',
        items: birthHistoryController.pregnancyMaturityOptions,
        value: birthHistoryController.pregnancyMaturity.value,
        onChanged: (value) => birthHistoryController.updatePregnancyMaturity(value!),
        icon: Icons.today,
        isDay: themeController.isDay.value,
      ),
      SizedBox(height: 10),

      // Delivery Type Dropdown
      QuickTechCustomDropDown(
        label: 'Delivery type',
        items: birthHistoryController.deliveryTypeOptions,
        value: birthHistoryController.deliveryType.value,
        onChanged: (value) => birthHistoryController.updateDeliveryType(value!),
        icon: Icons.delivery_dining,
        isDay: themeController.isDay.value,
      ),
      SizedBox(height: 10),

      // Delivery Place Dropdown
      QuickTechCustomDropDown(
        label: 'Delivery place',
        items: birthHistoryController.deliveryPlaceOptions,
        value: birthHistoryController.deliveryPlace.value,
        onChanged: (value) => birthHistoryController.updateDeliveryPlace(value!),
        icon: Icons.local_hospital,
        isDay: themeController.isDay.value,
      ),
      SizedBox(height: 10),

      // No of Labor Dropdown
      QuickTechCustomDropDown(
        label: 'No of labor',
        items: ['1', '2', '3', '4', '5'].obs,  
        value: birthHistoryController.noOfLabor.value,
        onChanged: (value) => birthHistoryController.updateNoOfLabor(value!),
        icon: Icons.numbers,
        isDay: themeController.isDay.value,
      ),
      SizedBox(height: 10),

      // Labor Duration Dropdown
      QuickTechCustomDropDown(
        label: 'Duration of labor (in hours)',
        items: birthHistoryController.laborDurationOptions,
        value: birthHistoryController.laborDuration.value,
        onChanged: birthHistoryController.updateLaborDuration,
        icon: Icons.timer,
        isDay: themeController.isDay.value,
             enableOthersOption: true,
            dialogTitle: "Add Duration in Labour(Hours)",
            dialogHint: "Enter Duration in Labour(Hours)",
      ),
      SizedBox(height: 10),

      // Child Position Dropdown
      QuickTechCustomDropDown(
        label: 'Child position',
        items: birthHistoryController.childPositionOptions,
        value: birthHistoryController.childPosition.value,
        onChanged: (value) => birthHistoryController.updateChildPosition(value!),
        icon: Icons.accessibility,
        isDay: themeController.isDay.value,
      ),
      SizedBox(height: 10),

      // After Birth Problem Dropdown
      QuickTechCustomDropDown(
        label: 'After birth problem',
        items: birthHistoryController.afterBirthProblemOptions,
        value: birthHistoryController.afterBirthProblem.value,
        onChanged: birthHistoryController.updateAfterBirthProblem,
        icon: Icons.health_and_safety,
        isDay: themeController.isDay.value,
               enableOthersOption: true,
            dialogTitle: "Add After Birth Problem",
            dialogHint: "Enter After Birth Problem",
      ),
      SizedBox(height: 10),

    ],
    crossAxisAlignment: CrossAxisAlignment.start,
  );
}
