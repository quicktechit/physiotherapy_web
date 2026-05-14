import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/family_history/quick_tech_family_history_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';

import 'package:e_prescription/widgets/quick_tech_custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:e_prescription/locator.dart';

Widget FamilyHistory() {
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechFamilyHistoryController familyHistoryController = locator.get<QuickTechFamilyHistoryController>();
  
  return Column(
    children: [
      Text(
        'Family History',
        style: myStyle(
          20,
          themeController.isDay.value
              ? QuickTechAppColors.lightmaincolor
              : QuickTechAppColors.darkmaincolor,
          FontWeight.bold,
        ),
      ),
      SizedBox(height: 15),
      QuickTechCustomDropDown(
        label: 'Home environment',
        items: familyHistoryController.homeEnvironmentOptions,
        value: familyHistoryController.homeEnvironment.value,
        onChanged: (value) => familyHistoryController.updateHomeEnvironment(value!),
        icon: Icons.home,
        isDay: themeController.isDay.value,
      ),SizedBox(height: 10,),
      QuickTechCustomDropDown(
        label: 'No of children',
        items: familyHistoryController.noofChildrenoptions,
        value: familyHistoryController.noofChildren.value,
        onChanged: (value) => familyHistoryController.updatenoofchildren(value!),
        icon: Icons.child_friendly_outlined,
        isDay: themeController.isDay.value,
      ),SizedBox(height: 10,),
      QuickTechCustomDropDown(
        label: 'Lactate condition',
        items: familyHistoryController.lactateOptions,
        value: familyHistoryController.lactateCondition.value,
        onChanged: (value) => familyHistoryController.updateLactate(value!),
        icon: Icons.sick_outlined,
        isDay: themeController.isDay.value,
      ),SizedBox(height: 10,),
      QuickTechCustomDropDown(
        label: 'Any other disabled person',
        items: familyHistoryController.disbaledpersonoptions,
        value: familyHistoryController.anydisableperson.value,
        onChanged: (value) => familyHistoryController.updateDisabaled(value!),
        icon: Icons.wheelchair_pickup_outlined,
        isDay: themeController.isDay.value,
      ),SizedBox(height: 10,),
      QuickTechCustomDropDown(
        label: 'Psychological condition',
        items: familyHistoryController.psycologyOptions,
        value: familyHistoryController.psychologicalCondition.value,
        onChanged:  familyHistoryController.updatedPsychologicalCondition,
        icon: Icons.psychology,
        isDay: themeController.isDay.value,
          enableOthersOption: true,
            dialogTitle: "Add New Psychological Condition",
            dialogHint: "Enter New Psychological Condition",
      ),SizedBox(height: 10,),
      QuickTechCustomDropDown(
        label: '1st cousine marriage',
        items: familyHistoryController.cousinMarriageOptions,
        value: familyHistoryController.firstcousinMarriage.value,
        onChanged: (value) =>familyHistoryController.updateCousinMarriage(value!),
        icon: Icons.family_restroom,
        isDay: themeController.isDay.value,
      ),SizedBox(height: 10,),
      
    ],
    crossAxisAlignment: CrossAxisAlignment.start,
  );
}
