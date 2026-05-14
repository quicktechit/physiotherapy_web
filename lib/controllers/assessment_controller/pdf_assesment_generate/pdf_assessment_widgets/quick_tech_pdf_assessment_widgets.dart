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
import 'package:e_prescription/controllers/assessment_controller/problem_summary/quick_tech_problem_summary_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/range_of_motion/quick_tech_range0f_motion_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/referred_to/quick_tech_referred_to_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget CenterDetails(pw.Font banglafont) {
  return pw.Align(
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Text(
          'মোমেনা-নজরুল ফিজিওথেরাপি সেন্টার',
          style: pw.TextStyle(
            fontSize: 18,
            color: PdfColor.fromHex('FF0000'),
            font: banglafont,
            renderingMode: PdfTextRenderingMode.fill,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Text(
          ' আধুনিক সদর হাসপাতাল রোড',
          style: pw.TextStyle(
            fontSize: 16,
            color: PdfColor.fromHex('FF0000'),
            font: banglafont,
            renderingMode: PdfTextRenderingMode.fill,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Text(
          '  গাইবান্ধা পৌরসভা,গাইবান্ধা',
          style: pw.TextStyle(
            fontSize: 16,
            color: PdfColor.fromHex('FF0000'),
            font: banglafont,
            renderingMode: PdfTextRenderingMode.fill,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 7),
        pw.Text(
          'Assessment Form',
          style: pw.TextStyle(
            fontSize: 16,
            color: PdfColor.fromHex('FF0000'),
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 15),
      ],
    ),
    alignment: pw.Alignment.topCenter,
  );
}

pw.Widget GeneralInfo(QuickTechPatientInfoController patientInfoController) {
  return pw.Column(
    children: [
      pw.Align(
        alignment: pw.Alignment.topLeft,
        child: pw.Text(
          'General Information',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.SizedBox(height: 4),
      pw.Table(
        border: pw.TableBorder.all(width: 1, color: PdfColors.black),
        columnWidths: {
          0: pw.FixedColumnWidth(120),
          1: pw.FixedColumnWidth(220),
          2: pw.FixedColumnWidth(120),
          3: pw.FixedColumnWidth(140),
        },
        children: [
          _tableRow(
            'Patient Name:',
            patientInfoController.patientNameController.text,
            'Age:',
            patientInfoController.ageController.text,
          ),
          _tableRow(
            'Father Name:',
            patientInfoController.fatherNameController.text,
            'Sex:',
            patientInfoController.sexController.text,
          ),
          _tableRow(
            'Mother Name:',
            patientInfoController.motherNameController.text,
            'Birth Date:',
            patientInfoController.birthDateController.text,
          ),
          _tableRow(
            'Spouse Name:',
            patientInfoController.spouseNameController.text,
            'Voter ID:',
            patientInfoController.voterIDController.text,
          ),
          _tableRow(
            'Occupation:',
            patientInfoController.occupationController.text,
            'Birth Registration No:',
            patientInfoController.birthRegistrationNoController.text,
          ),
          _tableRow(
            'Marital Status:',
            patientInfoController.maritalStatusController.text,
            'Disability ID No:',
            patientInfoController.disabilityIDController.text,
          ),
          _tableRow(
            'Education of Patient:',
            patientInfoController.educationOfPatientController.text,
            'Blood Group:',
            patientInfoController.bloodGroupController.text,
          ),
          _tableRow(
            'Education of Guardian:',
            patientInfoController.educationOfGuardianController.text,
            'Guardian Name:',
            patientInfoController.guardianNameController.text,
          ),
        ],
      ),
      pw.SizedBox(height: 20),
    ],
  );
}

//Occupation History
pw.Widget OccupationHistory(
  QuickTechOccupationHistoryController occupationHistoryController,
) {
  return pw.Column(
    children: [
      pw.Align(
        alignment: pw.Alignment.topLeft,
        child: pw.Text(
          'Occupation History',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.SizedBox(height: 5),
      pw.Table(
        border: pw.TableBorder.all(width: 1, color: PdfColors.black),
        columnWidths: {
          0: pw.FixedColumnWidth(120),
          1: pw.FixedColumnWidth(220),
          2: pw.FixedColumnWidth(120),
          3: pw.FixedColumnWidth(140),
        },
        children: [
          _tableRow(
            'Type of Work',
            occupationHistoryController.typeOfWorkController.text,
            'Stair Moving',
            occupationHistoryController.stairMovingController.text,
          ),
          _tableRow(
            'Lumbar Involvement',
            occupationHistoryController.lumbarInvolvementController.text,
            'Brain Work',
            occupationHistoryController.brainWorkController.text,
          ),
        ],
      ),
      pw.SizedBox(height: 20),
    ],
  );
}

//Family History
pw.Widget FamilyHistory(
  QuickTechFamilyHistoryController familyHistoryController,
) {
  return pw.Column(
    children: [
      pw.Align(
        alignment: pw.Alignment.topLeft,
        child: pw.Text(
          'Family History',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.SizedBox(height: 5),
      pw.Table(
        border: pw.TableBorder.all(width: 1, color: PdfColors.black),
        columnWidths: {
          0: pw.FixedColumnWidth(120),
          1: pw.FixedColumnWidth(220),
          2: pw.FixedColumnWidth(120),
          3: pw.FixedColumnWidth(140),
        },
        children: [
          _tableRow(
            'Family history',
            familyHistoryController.homeenvitornmentController.text,
            'Any other disabled person',
            familyHistoryController.anydisablepersonController.text,
          ),
          _tableRow(
            'No of children',
            familyHistoryController.noofChildrenController.text,
            'Psychological condition',
            familyHistoryController.psychologicalConditionController.text,
          ),
          _tableRow(
            'Lactate condition',
            familyHistoryController.lactateConditionController.text,
            '1st cousine marriage',
            familyHistoryController.firstCousinMarrigeController.text,
          ),
        ],
      ),
      pw.SizedBox(height: 20),
    ],
  );
}

//Birth History
pw.Widget BirthHistory(QuickTechBirthHistoryController birthhistoryController) {
  return pw.Column(
    children: [
      pw.Align(
        alignment: pw.Alignment.topLeft,
        child: pw.Text(
          'Birth history',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.SizedBox(height: 5),
      pw.Table(
        border: pw.TableBorder.all(width: 1, color: PdfColors.black),
        columnWidths: {
          0: pw.FixedColumnWidth(120),
          1: pw.FixedColumnWidth(220),
          2: pw.FixedColumnWidth(120),
          3: pw.FixedColumnWidth(140),
        },
        children: [
          _tableRow(
            'Birth injury',
            birthhistoryController.birthInjuryController.text,
            'Birth weight',
            birthhistoryController.birthWeightController.text,
          ),
          _tableRow(
            'Any complication during delivery',
            birthhistoryController.complicationController.text,
            'Pregnancy maturity',
            birthhistoryController.pregnancyMaturityController.text,
          ),
          _tableRow(
            'Delivery type ',
            birthhistoryController.deliveryTypeController.text,
            'Delivery place',
            birthhistoryController.deliveryPlaceController.text,
          ),
          _tableRow(
            'No of labor',
            birthhistoryController.noOfLaborController.text,
            'Duration of labor',
            birthhistoryController.laborDurationController.text,
          ),
          _tableRow(
            'Child position',
            birthhistoryController.childPositionController.text,
            'After birth problem',
            birthhistoryController.afterBirthProblemController.text,
          ),
        ],
      ),
      pw.SizedBox(height: 20),
    ],
  );
}

//Mother health condition during pregnancy
pw.Widget MotherHealth(
  QuickTechMotherHealthController motherHealthControllere,
) {
  return pw.Column(
    children: [
      pw.Align(
        alignment: pw.Alignment.topLeft,
        child: pw.Text(
          'Mother health condition during pregnancy',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.SizedBox(height: 5),
      pw.Table(
        border: pw.TableBorder.all(width: 1, color: PdfColors.black),
        columnWidths: {
          0: pw.FixedColumnWidth(120),
          1: pw.FixedColumnWidth(220),
          2: pw.FixedColumnWidth(120),
          3: pw.FixedColumnWidth(140),
        },
        children: [
          _tableRow(
            'Blood pressure',
            motherHealthControllere.bloodPressureController.text,
            'Diabetes mellitus',
            motherHealthControllere.diabetesController.text,
          ),
          _tableRow(
            'Preeclampsia',
            motherHealthControllere.preeclampsiaController.text,
            'Infection',
            motherHealthControllere.infectionController.text,
          ),
          _tableRow(
            'Bleeding',
            motherHealthControllere.bleedingController.text,
            'Anxiety or stress',
            motherHealthControllere.anxietyController.text,
          ),
        ],
      ),
      pw.SizedBox(height: 20),
    ],
  );
}

// Past Medical History
pw.Widget PastMedicalHistory(
  QuickTechPastMedicalHistoryController pastMedicalHistoryControler,
) {
  List<String> selectedItems = pastMedicalHistoryControler.getSelectedItems();

  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Align(
        alignment: pw.Alignment.topLeft,
        child: pw.Text(
          'Past Medical History',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.SizedBox(height: 5),

      if (selectedItems.isNotEmpty)
        ...selectedItems
            .map((item) => pw.Text(item, style: pw.TextStyle(fontSize: 14)))
            .toList(),

      pw.SizedBox(height: 20),
    ],
  );
}
//On Examination

pw.Widget OnExamination(
  QuickTechOnExaminationController onExaminationController,
) {
  return pw.Column(
    children: [
      pw.Align(
        alignment: pw.Alignment.topLeft,
        child: pw.Text(
          'On Examination',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.SizedBox(height: 5),
      pw.Table(
        border: pw.TableBorder.all(width: 1, color: PdfColors.black),
        columnWidths: {
          0: pw.FixedColumnWidth(120),
          1: pw.FixedColumnWidth(220),
          2: pw.FixedColumnWidth(120),
          3: pw.FixedColumnWidth(140),
        },
        children: [
          _tableRow(
            'Body type',
            onExaminationController.bodyType.value ?? 'N/A',
            'Posture',
            onExaminationController.posture.value ?? 'N/A',
          ),
          _tableRow(
            'Gait',
            onExaminationController.gait.value ?? 'N/A',
            'Activity',
            onExaminationController.activity.value ?? 'N/A',
          ),
          _tableRow(
            'Percussion',
            onExaminationController.percussion.value ?? 'N/A',
            'Temperature',
            onExaminationController.temperature.value ?? 'N/A',
          ),
          _tableRow(
            'Pulse',
            onExaminationController.pulse.value ?? 'N/A',
            'Blood pressure',
            onExaminationController.bloodPressure.value ?? 'N/A',
          ),
          _tableRow(
            'Inflammatory sign',
            (onExaminationController.inflammatorySign.value.isNotEmpty
                ? onExaminationController.inflammatorySign.value.join(', ')
                : 'N/A'),
            'Reflex',
            onExaminationController.reflex.value != null
                ? onExaminationController.reflex.value!.entries
                    .map((entry) => '*${entry.key}: ${entry.value}')
                    .join(', ')
                : 'N/A',
          ),

          _tableRow(
            'Sensory',
            onExaminationController.sensory.value ?? 'N/A',
            'Motor',
            onExaminationController.motor.value ?? 'N/A',
          ),
          _tableRow(
            'Muscle tone',
            onExaminationController.muscleTone.value ?? 'N/A',
            'Spasticity',
            onExaminationController.spasticity.value ?? 'N/A',
          ),
          _tableRow(
            'Bowel bladder control',
            onExaminationController.bowelBladderControl.value ?? 'N/A',
            'Any limb/ organ absence ',
            onExaminationController.limbOrOrganAbsence.value ?? 'N/A',
          ),
          _tableRow(
            'Balancing condition',
            onExaminationController.balancingCondition.value ?? 'N/A',
            'Others ',
            onExaminationController.others.value ?? 'N/A',
          ),
        ],
      ),
      pw.SizedBox(height: 20),
    ],
  );
}

//Muscle Power
pw.Widget MusclePower(QuickTechMusclePowerController musclePowerController) {
  return pw.Column(
    children: [
      pw.Align(
        alignment: pw.Alignment.topLeft,
        child: pw.Text(
          'Muscle Power',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.SizedBox(height: 5),
      pw.Table(
        border: pw.TableBorder.all(width: 1, color: PdfColors.black),
        columnWidths: {
          0: pw.FixedColumnWidth(120),
          1: pw.FixedColumnWidth(100),
          2: pw.FixedColumnWidth(120),
          3: pw.FixedColumnWidth(100),
          4: pw.FixedColumnWidth(100),
          5: pw.FixedColumnWidth(100),
          6: pw.FixedColumnWidth(100),
          7: pw.FixedColumnWidth(150),
        },
        children: [
          MusclePowertablerow(
            'Limb',
            'Movement',
            'Muscle Name',
            'Initial Left',
            'Initial Right',
            'Discharge Left',
            'Discharge Right',
            'Comments',
          ),
          MusclePowertablerow(
            'Upper Limb',
            musclePowerController.uppermovementController.text,
            musclePowerController.uppermusclenameController.text,
            musclePowerController.upperleftInitialController.text,
            musclePowerController.upperrightInitialController.text,
            musclePowerController.upperleftDischargeController.text,
            musclePowerController.upperrightDischargeController.text,
            musclePowerController.upperCommentController.text,
          ),
          MusclePowertablerow(
            'Lower Limb',
            musclePowerController.lowermovementController.text,
            musclePowerController.lowermusclenameController.text,
            musclePowerController.lowerleftInitialController.text,
            musclePowerController.lowerrightInitialController.text,
            musclePowerController.lowerleftDischargeController.text,
            musclePowerController.lowerrightDischargeController.text,
            musclePowerController.upperCommentController.text,
          ),
        ],
      ),
      pw.SizedBox(height: 20),
    ],
  );
}

//range of MOtion
pw.Widget RangeofMotion(
  QuickTechRange0fMotionController range0fMotionController,
) {
  return pw.Column(
    children: [
      pw.Align(
        alignment: pw.Alignment.topLeft,
        child: pw.Text(
          'Range of motion',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.SizedBox(height: 5),
      pw.Table(
        border: pw.TableBorder.all(width: 1, color: PdfColors.black),
        columnWidths: {
          0: pw.FixedColumnWidth(120),
          1: pw.FixedColumnWidth(100),
          2: pw.FixedColumnWidth(120),
          3: pw.FixedColumnWidth(100),
          4: pw.FixedColumnWidth(100),
          5: pw.FixedColumnWidth(100),
          6: pw.FixedColumnWidth(100),
          7: pw.FixedColumnWidth(150),
        },
        children: [
          MusclePowertablerow(
            'Limb',
            'Movement',
            'Muscle Name',
            'Initial ROM Left',
            'Initial ROM Right',
            'Discharge ROM Left',
            'Discharge ROM Right',
            'Comments',
          ),
          MusclePowertablerow(
            'Upper Limb',
            range0fMotionController.uppermovementController.text,
            range0fMotionController.uppermusclenameController.text,
            range0fMotionController.upperleftInitialROMController.text,
            range0fMotionController.upperrightInitialROMController.text,
            range0fMotionController.upperleftDischargeROMController.text,
            range0fMotionController.upperrightDischargeROMController.text,
            range0fMotionController.upperCommentController.text,
          ),
          MusclePowertablerow(
            'Lower Limb',
            range0fMotionController.lowermovementController.text,
            range0fMotionController.lowermusclenameController.text,
            range0fMotionController.lowerleftInitialROMController.text,
            range0fMotionController.lowerrightInitialROMController.text,
            range0fMotionController.lowerleftDischargeROMController.text,
            range0fMotionController.lowerrightDischargeROMController.text,
            range0fMotionController.upperCommentController.text,
          ),
        ],
      ),
      pw.SizedBox(height: 20),
    ],
  );
}

//Problem Summary,Goal and Plan
pw.Widget ProblemSummary(
  QuickTechProblemSummaryController problemSummaryController,
) {
  return pw.Column(
    children: [
      pw.Align(
        alignment: pw.Alignment.topLeft,
        child: pw.Text(
          'Problem Summary,Goal and Plan',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.SizedBox(height: 5),
      pw.Table(
        border: pw.TableBorder.all(width: 1, color: PdfColors.black),
        columnWidths: {
          0: pw.FixedColumnWidth(120),
          1: pw.FixedColumnWidth(100),
          2: pw.FixedColumnWidth(120),
        },
        children: [
          ProblemSummaryRow('Problem list', 'Goal', 'Treatment plan'),
          ProblemSummaryRow(
            problemSummaryController.problemListController.text,
            problemSummaryController.goalListController.text,
            problemSummaryController.treatmentPlanController.text,
          ),
        ],
      ),
      pw.SizedBox(height: 20),
    ],
  );
}

//Home Advice
pw.Widget HomeAdvice(QuickTechHomeAdviceController homeAdviceController) {
  return pw.Column(
    children: [
      pw.Align(
        alignment: pw.Alignment.topLeft,
        child: pw.Text(
          'Home Advice',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.SizedBox(height: 5),
      customInfo('Advice', homeAdviceController.homeAdviceController.text),
      //  if (selectedItems.isNotEmpty)
      //       ...selectedItems
      //           .map((item) => pw.Text(item, style: pw.TextStyle(fontSize: 14)))
      //           .toList(),
      pw.SizedBox(height: 20),
    ],
  );
}

//Differential Diagnosis
pw.Widget DifferentialDiagnosis(
  QuickTechDifferentialDiagnosisController differentialDiagnosisController,
) {
  List<String> selectedDiagnoses =
      differentialDiagnosisController.selectedDiagnosis;
  Map<String, List<String>> selectedSubDiagnoses =
      differentialDiagnosisController.selectedsubDiagnosis;

  if (selectedDiagnoses.isEmpty) {
    return pw.Text('No differential diagnoses selected');
  }

  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Align(
        alignment: pw.Alignment.topLeft,
        child: pw.Text(
          'Differential Diagnosis',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.SizedBox(height: 5),

      for (var diagnosis in selectedDiagnoses)
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              diagnosis,
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),

            if (selectedSubDiagnoses[diagnosis]?.isNotEmpty ?? false)
              ...selectedSubDiagnoses[diagnosis]!.map(
                (subDiagnosis) => pw.Text(
                  '  - $subDiagnosis',
                  style: pw.TextStyle(fontSize: 12),
                ),
              ),

            pw.SizedBox(height: 10),
          ],
        ),
    ],
  );
}

//Advice for Assestive Device
pw.Widget AssestiveDevice(
  QuickTechAssestiveDeviceController assestiveDeviceController,
) {
  List<String> selectedAssestiveDevice =
      assestiveDeviceController.selectedAssestiveDevice;
  Map<String, List<String>> selectedSubAssesticeDevice =
      assestiveDeviceController.selectedsubAssestiveDevice;

  if (selectedAssestiveDevice.isEmpty) {
    return pw.Text('No Assestive Device selected');
  }

  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Align(
        alignment: pw.Alignment.topLeft,
        child: pw.Text(
          'Advice for Assestive Device',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.SizedBox(height: 5),

      for (var device in selectedAssestiveDevice)
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              device,
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),

            if (selectedSubAssesticeDevice[device]?.isNotEmpty ?? false)
              ...selectedSubAssesticeDevice[device]!.map(
                (subDevice) => pw.Text(
                  '  - $subDevice',
                  style: pw.TextStyle(fontSize: 12),
                ),
              ),

            pw.SizedBox(height: 10),
          ],
        ),
    ],
  );
}

//Referred To
pw.Widget ReferredTo(QuickTechReferredToController referredToController) {
  List<String> selectedReferredTo = referredToController.selectedReferredTo;

  if (selectedReferredTo.isEmpty) {
    return pw.Text('No referred provider selected');
  }

  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Align(
        alignment: pw.Alignment.topLeft,
        child: pw.Text(
          'Referred To',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.SizedBox(height: 5),

      for (var device in selectedReferredTo)
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              device,
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),

            pw.SizedBox(height: 10),
          ],
        ),
    ],
  );
}

//////
pw.Widget customInfo(String label, String value) {
  return pw.Row(
    children: [
      pw.Text(
        '$label: ',
        style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
      ),
      pw.Expanded(
        child: pw.Text(
          value.isNotEmpty ? value : 'N/A',
          style: pw.TextStyle(fontSize: 14),
        ),
      ),
    ],
  );
}

pw.TableRow _tableRow(
  String label1,
  String value1,
  String label2,
  String value2,
) {
  return pw.TableRow(
    children: [
      _labelCell(label1),
      _valueCell(value1),
      _labelCell(label2),
      _valueCell(value2),
    ],
  );
}

pw.Widget _labelCell(String label) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(8.0),
    child: pw.Text(
      label,
      style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
    ),
  );
}

pw.Widget _valueCell(String value) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(8.0),
    child: pw.Text(
      value.isNotEmpty ? value : 'N/A',
      style: const pw.TextStyle(fontSize: 12),
    ),
  );
}

pw.TableRow MusclePowertablerow(
  String label1,
  String label2,
  String label3,
  String label4,
  String label5,
  String label6,
  String label7,
  String label8,
) {
  return pw.TableRow(
    children: [
      pw.Padding(
        padding: pw.EdgeInsets.all(4),
        child: pw.Text(
          label1,
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text(label2)),
      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text(label3)),
      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text(label4)),
      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text(label5)),
      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text(label6)),
      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text(label7)),
      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text(label8)),
    ],
  );
}

pw.TableRow ProblemSummaryRow(String label1, String label2, String label3) {
  return pw.TableRow(
    children: [
      pw.Padding(
        padding: pw.EdgeInsets.all(4),
        child: pw.Text(
          label1,
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.Padding(
        padding: pw.EdgeInsets.all(4),
        child: pw.Text(
          label2,
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.Padding(
        padding: pw.EdgeInsets.all(4),
        child: pw.Text(
          label3,
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
      ),
    ],
  );
}
