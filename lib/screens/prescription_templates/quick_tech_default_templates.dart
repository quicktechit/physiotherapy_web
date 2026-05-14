import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/pdf_prescription_controller/quick_tech_pdf_controller.dart';

import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_manual_therapy_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_miscellaneous_therapy_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_speech_language_therapy_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/assestive_device_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/cheif_complain_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/diagnosis_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/disability_types_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/drug_history_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/on_examination_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/optimized_advice_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/referred_to_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/primary_medical_history_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/radiological_findings_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/previous_therapy_Controller.dart';
import 'package:e_prescription/controllers/prescription_controller/patient_info_controller/patient_info_controller.dart';
import 'package:e_prescription/locator.dart';

import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;



pw.Page defaultPrescription() {

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
  // Access previous therapy/advice via locator on demand in sections below

/////
  final QuickTechManualTherapyController manualTherapyController = locator.get<QuickTechManualTherapyController>();
  final QuickTechMiscellaneousTherapyController miscellaneousTherapyController = locator.get<QuickTechMiscellaneousTherapyController>();
  final QuickTechSpeechLanguageTherapyController sltController = locator.get<QuickTechSpeechLanguageTherapyController>();
  final PreviousTherapyHistoryController prevTherapyCtrl = locator.get<PreviousTherapyHistoryController>();
  final OptimizedAdviceController optimizedAdviceCtrl = locator.get<OptimizedAdviceController>();

  final QuickTechPdfController pdfPrescriptionController = locator.get<QuickTechPdfController>();
  final patientName = patientInfoController.patientName.value;
  final age = patientInfoController.age.value;
  final gender = patientInfoController.gender.value;
  final date =
      patientInfoController.date.value != null
          ? dateFormat(patientInfoController.date.value!.toLocal())
          : dateFormat(DateTime.now());

  final selectedDrugHistory = drugHistoryController.selectedDrugHistory;

  final selectedReferredTo = referredToController.selectedReferredTo;
  final selecteddisabilityTypes =
      disabilityTypesController.selecteddisabilityTypes;
  //Map for on examinations with details to print on PDF
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
  // Electrotherapy
  return pw.Page(
    build: (pw.Context context) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          //Heading
          pw.Align(
            child: pw.Text(
              textAlign: pw.TextAlign.center,
              'মোমেনা-নজরুল ফিজিওথেরাপি সেন্টার \nআধুনিক সদর হাসপাতাল রোড \nগাইবান্ধা পৌরসভা,গাইবান্ধা',
              style: pw.TextStyle(
                color: PdfColor.fromHex('980000'),
                font: pdfPrescriptionController.banglafont,
                renderingMode: PdfTextRenderingMode.fill,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            alignment: pw.Alignment.center,
          ),
          //Doctor Details
          pw.Row(
            children: [
              pw.Text(
                "ডাঃ মোস্তাফিজুর রহমান \nবিপিটি (নিটোর/পংগু হাসপাতাল),\n এমডিএমআর (বিওইউ)\n কনসালট্যান্ট (ফিজিওথেরাপি)\n প্রতিবন্ধী সেবা ও সাহায্য কেন্দ্র\n সমাজকল্যাণ মন্ত্রণালায় ",
                style: pw.TextStyle(
                  font: pdfPrescriptionController.banglafont,
                  fontSize: 10,
                  color: PdfColor.fromHex('76AF5D'),
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Spacer(),
              pw.Text(
                "Dr.Mostafizur Rahaman\nBPT (NITOR/pangu hospital), MDMR (BOU) \nConsultant (physiotherapy)\nProtibondhi seba O sahazzo kendro\n Ministry of social welfare",
                style: pw.TextStyle(
                  font: pdfPrescriptionController.banglafont,
                  fontSize: 10,
                  color: PdfColor.fromHex('76AF5D'),
                ),
              ),
            ],
          ),
          pw.Text(
            'Id:204',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            children: [
              // Patient Information Section
              pw.Text('Name: $patientName'), pw.Spacer(),
              pw.Text('Age: $age'), pw.SizedBox(width: 10),
              pw.Text('Gender: $gender'), pw.SizedBox(width: 10),
              pw.Text('Date: $date'),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Chief Complaints Section
                    if (cheifComplainController.selectedComplaints.isNotEmpty)
                      pw.Text(
                        'Chief Complaints :',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    customItemswithSubitems(
                      cheifComplainController.selectedComplaints,
                      cheifComplainController.selectedSubComplaints,
                    ),

                    // On Examinations
                    if (onExaminationController.selectedExaminations.isNotEmpty)
                      pw.Text(
                        'On Examinations :',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    customItemswithSubitems(
                      onExaminationController.selectedExaminations,
                      onExamWithDetails.obs,
                    ),

                    // Radiological Findings
                    if (radiologicalFindingsController
                        .selectedRadioLogicalFindings
                        .isNotEmpty)
                      pw.Text(
                        'Radiological Findings :',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    customItemswithSubitems(
                      radiologicalFindingsController.selectedRadioLogicalFindings,
                      radiologicalFindingsController.selectedsubRadiologicalFindings,
                    ),

                    // Primary Medical History
                    if (primaryMedicalHistoryController
                        .selectedMedicalHistory
                        .isNotEmpty)
                      pw.Text(
                        'Primary Medical History :',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    customItemswithSubitems(
                      radiologicalFindingsController.selectedRadioLogicalFindings,
                      radiologicalFindingsController.selectedsubRadiologicalFindings,
                    ),

                    // Drug History
                    if (selectedDrugHistory.isNotEmpty)
                      pw.Text(
                        'Drug History:',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ...selectedDrugHistory.map((drug) => pw.Text(drug)),
                    //Previous Therapy History
                    if (prevTherapyCtrl
                            .selectedElectrotherapy
                            .isNotEmpty ||
                        prevTherapyCtrl
                            .selectedManualTherapy
                            .isNotEmpty ||
                        prevTherapyCtrl
                            .selectedAdditionalTherapies
                            .isNotEmpty ||
                        prevTherapyCtrl
                            .othersDetails
                            .value
                            .isNotEmpty)
                      pw.Text(
                        'Previous Therapy History:',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    // Electrotherapy with details
                    ...prevTherapyCtrl.selectedElectrotherapy.map((
                      therapy,
                    ) {
                      final details =
                          prevTherapyCtrl.therapyDetails[therapy];
                      return pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('*$therapy'),
                          if (details != null)
                            pw.Padding(
                              padding: const pw.EdgeInsets.only(left: 12),
                              child: pw.Text(
                                '${details['duration'] != null && details['duration'].isNotEmpty ? 'Duration: ${details['duration']}, ' : ''}'
                                '${details['frequency'] != null && details['frequency'].isNotEmpty ? 'Frequency: ${details['frequency']}, ' : ''}',
                                /* 'Regular: ${details['isRegular'] == null
       ? ''
       : details['isRegular']
       ? "Yes"
       : "No"}' */
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  fontStyle: pw.FontStyle.italic,
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
                    // Manual Therapy
                    ...prevTherapyCtrl.selectedManualTherapy.map(
                      (therapy) => pw.Text('* $therapy'),
                    ),
                    // Additional Therapies
                    ...prevTherapyCtrl.selectedAdditionalTherapies
                        .map((therapy) => pw.Text('* $therapy')),
                    // Add this section for Others Details
                    if (prevTherapyCtrl
                        .othersDetails
                        .value
                        .isNotEmpty) ...[
                      pw.Text(
                        'Others:',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 12),
                        child: pw.Text(
                          '*${prevTherapyCtrl.othersDetails.value}',
                          style: pw.TextStyle(
                            fontSize: 10,
                            fontStyle: pw.FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                      // Advice
              if (optimizedAdviceCtrl.selectedTests.isNotEmpty)
                pw.Text(
                  'Advice:',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ...optimizedAdviceCtrl.selectedTests.map(
                (advice) => pw.Text(advice),
              ),
                // Assistive Device
              if (assestiveDeviceController.selectedAssestiveDevice.isNotEmpty)
                pw.Text(
                  'Suggested Assestive Device :',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              customItemswithSubitems(
                assestiveDeviceController.selectedAssestiveDevice,
                assestiveDeviceController.selectedsubAssestiveDevice,
              ),

              // Referred To
              if (selectedReferredTo.isNotEmpty)
                pw.Text(
                  'Referred To:',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ...selectedReferredTo.map((referral) => pw.Text(referral)),

              // Types of Disabilities
              if (selecteddisabilityTypes.isNotEmpty)
                pw.Text(
                  'Types of Disabilities:',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ...selecteddisabilityTypes.map(
                (disability) => pw.Text(disability),
              ),

              // Diagnosis
              if (diagnosisController.selectedDiagnosis.isNotEmpty)
                pw.Text(
                  'Differential Diagnosis/Diagnosis :',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              customItemswithSubitems(
                diagnosisController.selectedDiagnosis,
                diagnosisController.selectedsubDiagnosis,
              ),
                  ],
                ),
                flex: 3,
              ),

              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Manual Therapy
                    if (manualTherapyController.selectedTherapies.isNotEmpty)
                      pw.Text(
                        'Manual Therapy :',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ...manualTherapyController.selectedTherapies.map(
                      (manualTherapy) => pw.Text(manualTherapy),
                    ),
                    //Miscellaneous Therapy
                    if (miscellaneousTherapyController
                        .selectedTherapies
                        .isNotEmpty)
                      pw.Text(
                        'Miscellaneous Therapy:',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ...miscellaneousTherapyController.selectedTherapies.map(
                      (misCellaneous) => pw.Text(misCellaneous),
                    ),
                    //Speech and Language Therapy
                    if (sltController.selectedTherapies.isNotEmpty)
                      pw.Text(
                        'Speech and Language Therapy:',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ...sltController.selectedTherapies.map(
                      (SLT) => pw.Text(SLT),
                    ),
                    //Electrotherapy
                    ...pdfPrescriptionController.buildElectrotherapySection(),
                  ],
                ),
                flex: 5,
              ),
            
            
            ],
          ),
        ],
      );
    },
  );
}

pw.Widget customItemswithSubitems(
  List<dynamic> items,
  RxMap<String, List<String>> subItems,
) {
  return items.isNotEmpty
      ? pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children:
            items.map<pw.Widget>((item) {
              // Find the corresponding subcategory for each item
              var subcategory = subItems[item] ?? [];

              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    '${item.toString()}',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                  // Display subcategories for each item
                  if (subcategory.isNotEmpty)
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 10),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children:
                            subcategory.map<pw.Widget>((sub) {
                              return pw.Text(
                                "> ${sub}",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  fontStyle: pw.FontStyle.italic,
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                ],
              );
            }).toList(),
      )
      : pw.SizedBox();
}
