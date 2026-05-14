import 'package:e_prescription/controllers/assessment_controller/assestive_device/quick_tech_assestive_device_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/birth_history/quick_tech_birth_history_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/differential_diagnosis/quick_tech_differential_diagnosis_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/family_history/quick_tech_family_history_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/home_advice/quick_tech_home_advice_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/mother_health_condition_during_pregnancy/quick_tech_mother_health_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/muscle_power/quick_tech_muscle_power_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/occupation_history/quick_tech_occupation_history_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/on_examination/quick_tech_on_examination_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/past_medical_history/quick_tech_past_medical_history_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/patient_info/quick_tech_patient_info_controlle.dart';
import 'package:e_prescription/controllers/assessment_controller/pdf_assesment_generate/pdf_assessment_widgets/quick_tech_pdf_assessment_widgets.dart';
import 'package:e_prescription/controllers/assessment_controller/problem_summary/quick_tech_problem_summary_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/range_of_motion/quick_tech_range0f_motion_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/referred_to/quick_tech_referred_to_controller.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class QuickTechPdfAssesmentController extends GetxController {
  int _assessmentId = 5; // Default ID; set via setAssessmentId() before calling fetchAndSavePdf()

  String get apiUrl => '${Api.baseUrl}/api/assessment/of/prescription/$_assessmentId';

  /// Set the assessment ID before downloading the PDF
  void setAssessmentId(int id) {
    _assessmentId = id;
  }

  /// Get the current assessment ID
  int getAssessmentId() => _assessmentId;

  // Download PDF from API and save locally
  Future<String?> fetchAndSavePdf() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getApplicationDocumentsDirectory();
        final filePath = '${dir.path}/assessment_prescription_$_assessmentId.pdf';
        final file = File(filePath);
        await file.writeAsBytes(bytes);
        return filePath;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  // Access the other controllers
  final QuickTechPatientInfoController patientInfoController = locator.get<QuickTechPatientInfoController>();
  final QuickTechOccupationHistoryController occupationHistoryController = locator.get<QuickTechOccupationHistoryController>();
  final QuickTechFamilyHistoryController familyHistoryController = locator.get<QuickTechFamilyHistoryController>();
  final QuickTechBirthHistoryController birthHistoryController = locator.get<QuickTechBirthHistoryController>();
  final QuickTechMotherHealthController motherHealthController = locator.get<QuickTechMotherHealthController>();
  final QuickTechPastMedicalHistoryController pastMedicalHistoryController = locator.get<QuickTechPastMedicalHistoryController>();
  final QuickTechOnExaminationController onExaminationController = locator.get<QuickTechOnExaminationController>();
  final QuickTechMusclePowerController musclePowerController = locator.get<QuickTechMusclePowerController>();
  final QuickTechRange0fMotionController range0fMotionController = locator.get<QuickTechRange0fMotionController>();
  final QuickTechProblemSummaryController problemSummaryController = locator.get<QuickTechProblemSummaryController>();
  final QuickTechHomeAdviceController homeAdviceController = locator.get<QuickTechHomeAdviceController>();
  final QuickTechDifferentialDiagnosisController diagnosisController = locator.get<QuickTechDifferentialDiagnosisController>();
  final QuickTechAssestiveDeviceController assestiveDeviceController = locator.get<QuickTechAssestiveDeviceController>();
  final QuickTechReferredToController referredToController = locator.get<QuickTechReferredToController>();

  late pw.Font banglafont;

  Future<pw.Document> generatePDF() async {
    final pdf = pw.Document();
    final ByteData fontData = await rootBundle.load('assets/fonts/Notosan.ttf');
    banglafont = pw.Font.ttf(fontData);

    final pageTheme = pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.only(left: 50, right: 50, top: 30, bottom: 30),
      orientation: pw.PageOrientation.natural,
    );

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pageTheme,
        build: (context) => [
          CenterDetails(banglafont),
          GeneralInfo(patientInfoController),
          if (occupationHistoryController.hasData())
            OccupationHistory(occupationHistoryController),
          if (familyHistoryController.hasData())
            FamilyHistory(familyHistoryController),
          if (birthHistoryController.hasData())
            BirthHistory(birthHistoryController),
          if (motherHealthController.hasData())
            MotherHealth(motherHealthController),
          // Past Medical History Section (dynamic)
          if (pastMedicalHistoryController.getSelectedItems().isNotEmpty)
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Past Medical History', style: pw.TextStyle(font: banglafont, fontWeight: pw.FontWeight.bold, fontSize: 16)),
                pw.SizedBox(height: 5),
                ...pastMedicalHistoryController.getSelectedItems().map((name) => pw.Text('• $name', style: pw.TextStyle(font: banglafont, fontSize: 12))),
                pw.SizedBox(height: 15),
              ],
            ),
          if (onExaminationController.hasData())
            OnExamination(onExaminationController),
          if (musclePowerController.hasData())
            MusclePower(musclePowerController),
          if (range0fMotionController.hasData())
            RangeofMotion(range0fMotionController),
          if (problemSummaryController.hasData())
            ProblemSummary(problemSummaryController),
          if (homeAdviceController.hasData())
            HomeAdvice(homeAdviceController),
          if (diagnosisController.selectedDiagnosis.isNotEmpty)
            DifferentialDiagnosis(diagnosisController),
          if (assestiveDeviceController.selectedAssestiveDevice.isNotEmpty)
            AssestiveDevice(assestiveDeviceController),
          if (referredToController.selectedReferredTo.isNotEmpty)
            ReferredTo(referredToController)
        ],
      ),
    );

    return pdf;
  }
}
