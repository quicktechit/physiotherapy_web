import 'package:e_prescription/const/quick_tech_app_colors.dart';

import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/main_diagnosis_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/assestive_device_widget.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/cheif_complain_widget.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/diagnosis_widget.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/disability_types_widget.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/drug_history_widget.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/on_examination_widget.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/optimized_advice_widget.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/primary_medical_history_widget.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/radiological_findings_widget.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/referred_to_widget.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/previous_therapy_history.dart';


import 'package:flutter/material.dart';

import 'package:e_prescription/locator.dart';
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
final MainDiagnosisController mainDiagnosisController = locator.get<MainDiagnosisController>();
Widget customDiagnosisInfo() {
  return Padding(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Diagnosis',
          style: myStyle(
            20,
            themeController.isDay.value
                ? QuickTechAppColors.lightmaincolor
                : QuickTechAppColors.darkmaincolor,
            FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
      
        ChiefComplaintSection(),

        SizedBox(height: 10),

        //On Examination
        OnExaminationSection(),

        //radioLogical Findings
        RadiologicalFindingsSection(),
        //Primary Medical History
        PrimaryMedicalHistorySection(),

        //Drug History
        DrugHistorySection(),

        SizedBox(height: 16),
        //Previous Therapy History
        PreviousTherapyHIstorySection(themeController.isDay.value),
        SizedBox(height: 16),
        //Advice
        AdviceSection(themeController.isDay.value),
        SizedBox(height: 16),
        //Suggested Assestive Device
        AssestiveDeviceSection(),
        //Referred To
        ReferredToSection(),
        //Types of Disabilities
        DisabilityTypesSection(),

        //Differentia diagnosis/Diagnosis
        DiagnosisSection(),
      ],
    ),
  );
}

/*  void toggleComplaintDropdown() {
    isComplaintDropdownOpen.toggle();
    if (isComplaintDropdownOpen.value) {
      isOnExaminationsDropdownOpen.value = false;
      isradiologicalFindingsDropdownOpen.value = false;
      isMedicalHistoryDropdownOpen.value = false;
      previoustherapyController.showMainDropdown.value = false;
      adviceController.showMainDropdown.value = false;
      isDrugHistoryDropdownOpen.value = false;
      isAssestiveDeviceDropdownOpen.value = false;
      isReferredDropdownOpen.value = false;
      isDisabilityTypesDropdownOpen.value = false;
      isDiagnosisDropdownOpen.value = false;
    }
    if (!isComplaintDropdownOpen.value) {
      complaintSearchText.value = '';
    }
  } */