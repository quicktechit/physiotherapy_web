import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/pdf_prescription_controller/quick_tech_pdf_controller.dart';


import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_electrotherapy_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_manual_therapy_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_miscellaneous_therapy_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_speech_language_therapy_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/assestive_device_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/cheif_complain_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/diagnosis_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/disability_types_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/drug_history_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/on_examination_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/optimized_advice_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/primary_medical_history_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/radiological_findings_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/referred_to_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/previous_therapy_Controller.dart';
import 'package:e_prescription/controllers/prescription_controller/patient_info_controller/patient_info_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/screens/add_prescription/preview_screen/summary_info/widgets/quick_tech_custom_summary_widgets.dart';
import 'package:e_prescription/widgets/quick_tech_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customSummaryInfo(bool? isPreview) {
  final PatientInfoController patientInfoController = locator.get<PatientInfoController>();
  final CheifComplainController cheifComplainController = locator.get<CheifComplainController>();
  final OnExaminationController onExaminationController = locator.get<OnExaminationController>();
  final RadiologicalFindingsController radiologicalFindingsController = locator.get<RadiologicalFindingsController>();
  final PrimaryMedicalHistoryController primaryMedicalHistoryController = locator.get<PrimaryMedicalHistoryController>();
  final DrugHistoryController drugHistoryController = locator.get<DrugHistoryController>();
  final AssestiveDeviceController assestiveDeviceController = locator.get<AssestiveDeviceController>();
  final ReferredToController referredToController = locator.get<ReferredToController>();
  final DisabilityTypesController disabilityTypesController = locator.get<DisabilityTypesController>();
  final DiagnosisController diagnosisController = locator.get<DiagnosisController>();
  final PreviousTherapyHistoryController previousTherapyHistoryController = locator.get<PreviousTherapyHistoryController>();
  final OptimizedAdviceController optimizedAdviceController = locator.get<OptimizedAdviceController>();








  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechManualTherapyController manualtherapyController = locator.get<QuickTechManualTherapyController>();
  final QuickTechMiscellaneousTherapyController miscellaneousTherapyController = locator.get<QuickTechMiscellaneousTherapyController>();
  final QuickTechSpeechLanguageTherapyController SLTController = locator.get<QuickTechSpeechLanguageTherapyController>();
  final QuickTechElectrotherapyController electrotherapyController = locator.get<QuickTechElectrotherapyController>();
  final QuickTechPdfController pdfController = locator.get<QuickTechPdfController>();
  
  final Map<String, List<String>> onExamWithDetails = {};
  onExamWithDetails.addAll(onExaminationController.selectedSubExaminations);
  for (var examination in onExaminationController.selectedExaminations) {
    if (onExaminationController.showDetailsField(examination)) {
      final value = onExaminationController.getDetailsController(examination).value;
      if (value.isNotEmpty) {
        onExamWithDetails[examination] = [
          ...(onExaminationController.selectedSubExaminations[examination] ?? []),
          value,
        ];
      }
    }
  }
  return Obx(() {
    final isDay = themeController.isDay.value;
    final cardColor =
        isDay ? QuickTechAppColors.bktxtfld : QuickTechAppColors.bkdarktxtfld;
    final textColor =
        isDay
            ? QuickTechAppColors.lightmaintextcolor
            : QuickTechAppColors.white;
    final accentColor = QuickTechAppColors.lightmaincolor;
    // final dividerColor = accentColor.withOpacity(0.2);
    // Check Electrotherpy is selected or not
    bool hasElectrotherapySelection = electrotherapyController
        .selectedParameters
        .values
        .any((paramMap) {
          return paramMap.isNotEmpty &&
              paramMap.values.any((value) => value != null && value.isNotEmpty);
        });

    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: cardColor,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Patient Information Section
                  customRow(
                    'Name',
                    patientInfoController.patientName.value,
                    textColor,
                  ),
                  customRow('Age', patientInfoController.age.value, textColor),
                  customRow(
                    'Gender',
                    patientInfoController.gender.value,
                    textColor,
                  ),
                  customRow(
                    'Date',
                    patientInfoController.date.value != null
                        ? dateFormat(
                          patientInfoController.date.value!.toLocal(),
                        )
                        : dateFormat(DateTime.now()),
                    textColor,
                  ),

                  SizedBox(height: 20),

                  // Chief Complaints with Sub-Complaints
                  if (cheifComplainController.selectedComplaints.isNotEmpty)
                    customSection(
                      title: 'Chief Complaints',
                      items: cheifComplainController.selectedComplaints,
                      subItemsMap: cheifComplainController.selectedSubComplaints,
                      textColor: textColor,
                      accentColor: accentColor,
                    ),

                  // On Examinations
                  if (onExaminationController.selectedExaminations.isNotEmpty)
                    customSection(
                      title: 'On Examinations',
                      items: onExaminationController.selectedExaminations,
                      subItemsMap: onExamWithDetails,
                      textColor: textColor,
                      accentColor: accentColor,
                    ),
                  // Radiological Findings
                  if (radiologicalFindingsController
                      .selectedRadioLogicalFindings
                      .isNotEmpty)
                    customSection(
                      title: 'Radiological Findings',
                      items:
                          radiologicalFindingsController.selectedRadioLogicalFindings,
                      subItemsMap:
                          radiologicalFindingsController
                              .selectedsubRadiologicalFindings,
                      textColor: textColor,
                      accentColor: accentColor,
                    ),

                  // Primary Medical History
                  if (primaryMedicalHistoryController.selectedMedicalHistory.isNotEmpty)
                    customSection(
                      title: 'Primary Medical History',
                      items: primaryMedicalHistoryController.selectedMedicalHistory,
                      subItemsMap:
                          primaryMedicalHistoryController.selectedsubMedicalHistory,
                      textColor: textColor,
                      accentColor: accentColor,
                    ),

                  // Drug History
                  if (drugHistoryController.selectedDrugHistory.isNotEmpty)
                    customSection(
                      title: 'Drug History',
                      items: drugHistoryController.selectedDrugHistory,
                      subItemsMap:
                          drugHistoryController.selectedsubDrugHistory,
                      textColor: textColor,
                      accentColor: accentColor,
                    ),

                  // Suggested Assistive Device
                  if (assestiveDeviceController.selectedAssestiveDevice.isNotEmpty)
                    customSection(
                      title: 'Assistive Device',
                      items: assestiveDeviceController.selectedAssestiveDevice,
                      subItemsMap:
                          assestiveDeviceController.selectedsubAssestiveDevice,
                      textColor: textColor,
                      accentColor: accentColor,
                    ),

                  // Referred To
                  if (referredToController.selectedReferredTo.isNotEmpty)
                    customSectionList(
                      title: 'Referred To',
                      items: referredToController.selectedReferredTo,
                      textColor: textColor,
                    ),

                  // Types of Disabilities
                  if (disabilityTypesController.selecteddisabilityTypes.isNotEmpty)
                    customSectionList(
                      title: 'Types of Disabilities',
                      items: disabilityTypesController.selecteddisabilityTypes,
                      textColor: textColor,
                    ),

                  // Diagnosis
                  if (diagnosisController.selectedDiagnosis.isNotEmpty)
                    customSection(
                      title: 'Diagnosis',
                      items: diagnosisController.selectedDiagnosis,
                      subItemsMap: diagnosisController.selectedsubDiagnosis,
                      textColor: textColor,
                      accentColor: accentColor,
                    ),

                  // Previous Therapy History
                  if (previousTherapyHistoryController.therapyDetails.isNotEmpty||previousTherapyHistoryController.othersDetails.value.isNotEmpty)
                    customTherapyHIstory(
                      therapyController: previousTherapyHistoryController,
                      textColor: textColor,
                    ),

                  // Advice
                  if (optimizedAdviceController.selectedTests.isNotEmpty)
                    customSectionList(
                      title: 'Advice',
                      items: optimizedAdviceController.selectedTests,
                      textColor: textColor,
                    ),
                       // Electrotherapy Section (Added)
                  if (hasElectrotherapySelection)
                    customElectrotherapySection(
                      electrotherapyController: electrotherapyController,
                      textColor: textColor,
                      accentColor: accentColor,
                    ),
                  // Manual Therapy
                  if (manualtherapyController.selectedTherapies.isNotEmpty)
                    customSectionList(
                      title: 'Manual Therapy',
                      items: manualtherapyController.selectedTherapies,
                      textColor: textColor,
                    ),
                  // Miscellaneous Therapy
                  if (miscellaneousTherapyController
                      .selectedTherapies
                      .isNotEmpty)
                    customSectionList(
                      title: 'Miscellaneous Therapy',
                      items: miscellaneousTherapyController.selectedTherapies,
                      textColor: textColor,
                    ),
                  // Speech and Language Theory Therapy
                  if (SLTController.selectedTherapies.isNotEmpty)
                    customSectionList(
                      title: 'Speech and Language Therapy',
                      items: SLTController.selectedTherapies,
                      textColor: textColor,
                    ),
               
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          if (isPreview == false)
            QuickTechCustomButton(
              onTab: () {
                pdfController.generatePdf();
              },
              color:
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaincolor
                      : QuickTechAppColors.darkmaincolor,
              title: 'Submit',
              height: 50,
              width: double.infinity,
            ),
        ],
      ),
    );
  });
}
