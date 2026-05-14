import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/prescription_controller/patient_info_controller/patient_info_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_electrotherapy_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_manual_therapy_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_miscellaneous_therapy_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_rx_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_speech_language_therapy_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';

import 'package:e_prescription/screens/add_prescription/rx_info/custom_RX_part/quick_tech_electrotherapy.dart';
import 'package:e_prescription/screens/add_prescription/rx_info/custom_RX_part/quick_tech_manual%20_therapy.dart';
import 'package:e_prescription/screens/add_prescription/rx_info/custom_RX_part/quick_tech_miscellaneous_therapy.dart';
import 'package:e_prescription/screens/add_prescription/rx_info/custom_RX_part/quick_tech_speech_language_therapy.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';

QuickTechManualTherapyController manualTherapyController = locator.get<QuickTechManualTherapyController>();
PatientInfoController patientInfoController = locator.get<PatientInfoController>();
QuickTechMiscellaneousTherapyController miscellaneousTherapyController =
  locator.get<QuickTechMiscellaneousTherapyController>();
QuickTechSpeechLanguageTherapyController speechLanguageTherapyController =
  locator.get<QuickTechSpeechLanguageTherapyController>();
QuickTechElectrotherapyController electrotherapyController = locator.get<QuickTechElectrotherapyController>();
QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

QuicktechmainPrescriptionControllr prescriptionController = locator.get<QuicktechmainPrescriptionControllr>();

Widget customRxPart() {
  return Obx(
    () => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Prescription',
          style: myStyle(
            20,
            themeController.isDay.value
                ? QuickTechAppColors.lightmaincolor
                : QuickTechAppColors.darkmaincolor,
            FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),

  
        SizedBox(height: 10),
        customElectrothrerapy(),

        SizedBox(height: 15),
        CustomManualTherapyInfo(),

        SizedBox(height: 15),
        CustomMiscalleneousTherapyInfo(),

        SizedBox(height: 15),
        CustomSpeechLanguageTherapyInfo(),

     
      ],
    ),
  );
}
