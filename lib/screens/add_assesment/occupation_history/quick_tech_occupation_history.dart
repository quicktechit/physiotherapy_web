import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/occupation_history/quick_tech_occupation_history_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/patient_info/quick_tech_patient_info_controlle.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';

import 'package:e_prescription/widgets/quick_tech_custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:e_prescription/locator.dart';

Widget OccupationHistory() {
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechOccupationHistoryController occupationHistoryController = locator.get<QuickTechOccupationHistoryController>();
  locator.get<QuickTechPatientInfoController>();
  
  return Column(
    children: [
      Text(
        'Occupation History',
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
        label: 'Type of work',
        items: occupationHistoryController.typesofworkoptions,
        value: occupationHistoryController.typeOfWork.value,
        onChanged: occupationHistoryController.updateTypesofWork,
        icon: Icons.work,
        isDay: themeController.isDay.value,
             enableOthersOption: true,
            dialogTitle: "Add New Type of Work",
            dialogHint: "Enter New Type of Work",
      ),SizedBox(height: 10,),
      QuickTechCustomDropDown(
        label: 'Stair moving',
        items: occupationHistoryController.stairMOvingoptions,
        value: occupationHistoryController.stairMoving.value,
        onChanged: (value) => occupationHistoryController.updateStairMoving(value!),
        icon: Icons.work,
        isDay: themeController.isDay.value,
      ),SizedBox(height: 10,),
      QuickTechCustomDropDown(
        label: 'Lumbar involvement',
        items: occupationHistoryController.lumbarInvolvementoptions,
        value: occupationHistoryController.lumbarInvolvement.value,
        onChanged: (value) => occupationHistoryController.updatelumberInvolvemnt(value!),
        icon: Icons.work,
        isDay: themeController.isDay.value,
      ),SizedBox(height: 10,),
      QuickTechCustomDropDown(
        label: 'Brain work',
        items: occupationHistoryController.brainWorkoption,
        value: occupationHistoryController.brainWork.value,
        onChanged: (value) => occupationHistoryController.updatebrainWork(value!),
        icon: Icons.work,
        isDay: themeController.isDay.value,
      ),SizedBox(height: 10,),

  
    ],
    crossAxisAlignment: CrossAxisAlignment.start,
  );
}


//  occupationHistoryController.storeOccupationHistory(
//           patientId: patientInfoController.currentPatientId!,
//         );// use it for store occupation History