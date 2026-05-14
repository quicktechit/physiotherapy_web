import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
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
import 'package:e_prescription/locator.dart';

import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget AssementSummary(bool? isPreview) {
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechPatientInfoController patientinfoController = locator.get<QuickTechPatientInfoController>();
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
  return Obx(() {
    final isDay = themeController.isDay.value;
    final cardColor =
        isDay ? QuickTechAppColors.bktxtfld : QuickTechAppColors.bkdarktxtfld;
    final textColor =
        isDay
            ? QuickTechAppColors.lightmaintextcolor
            : QuickTechAppColors.white;



    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text(
                    'General Information',
                    style: myStyle(
                      18,
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaincolor
                          : QuickTechAppColors.darkmaincolor,
                      FontWeight.bold,
                    ),
                  ),
                  customInfo(
                    'Name',
                    patientinfoController.patientNameController.text,
                    textColor,
                  ),
                  customInfo(
                    "Father's Name",
                    patientinfoController.fatherNameController.text,
                    textColor,
                  ),
                  customInfo(
                    "Mother's Name",
                    patientinfoController.motherNameController.text,
                    textColor,
                  ),
                  customInfo(
                    "Spouse Name",
                    patientinfoController.spouseNameController.text,
                    textColor,
                  ),
                  customInfo(
                    'Age',
                    patientinfoController.ageController.text,
                    textColor,
                  ),
                  customInfo(
                    'Sex',
                    patientinfoController.sexController.text,
                    textColor,
                  ),
                 
                  customInfo(
                    'Occupation',
                    patientinfoController.occupationController.text,
                    textColor,
                  ),
                  customInfo(
                    'Marrital Status',
                    patientinfoController.maritalStatusController.text,
                    textColor,
                  ),

                  customInfo(
                    'Blood Group',
                    patientinfoController.bloodGroupController.text,
                    textColor,
                  ),
                  customInfo(
                    'Guardian Name',
                    patientinfoController.guardianNameController.text,
                    textColor,
                  ),
                  customInfo(
                    'Voter ID',
                    patientinfoController.voterIDController.text,
                    textColor,
                  ),
                  customInfo(
                    'Date of Birth',
                    patientinfoController.birthDateController.text,
                    textColor,
                  ),
                  customInfo(
                    'Birth Registration No',
                    patientinfoController.birthRegistrationNoController.text,
                    textColor,
                  ),
                  customInfo(
                    'Disability ID no',
                    patientinfoController.disabilityIDController.text,
                    textColor,
                  ),
                  customInfo(
                    'Education of Patient',
                    patientinfoController.educationOfPatientController.text,
                    textColor,
                  ),
                  customInfo(
                    'Education of Guardian',
                    patientinfoController.educationOfGuardianController.text,
                    textColor,
                  ),
             
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          //Occupation History Section
          if (occupationHistoryController.isOccupationHistoryNull()) ...[
            Text(
              'Occupation History',
              style: myStyle(
                18,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaincolor
                    : QuickTechAppColors.darkmaincolor,
                FontWeight.bold,
              ),
            ),
            if (occupationHistoryController.typeOfWork.value != null)
              customInfo(
                'Type of Work',
                occupationHistoryController.typeOfWork.value.toString(),
                textColor,
              ),
            if (occupationHistoryController.stairMoving.value != null)
              customInfo(
                'Stair moving',
                occupationHistoryController.stairMoving.value.toString(),
                textColor,
              ),
            if (occupationHistoryController.lumbarInvolvement.value != null)
              customInfo(
                'Lumbar involvement',
                occupationHistoryController.lumbarInvolvement.value.toString(),
                textColor,
              ),
            if (occupationHistoryController.brainWork.value != null)
              customInfo(
                'Brain work',
                occupationHistoryController.brainWork.value.toString(),
                textColor,
              ),
            SizedBox(height: 20),
          ],
//Family History Section
          if (familyHistoryController.isFamilyHistoryNull()) ...[
            Text(
              'Family history',
              style: myStyle(
                18,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaincolor
                    : QuickTechAppColors.darkmaincolor,
                FontWeight.bold,
              ),
            ),
            if (familyHistoryController.homeEnvironment.value != null)
              customInfo(
                'Home environment',
                familyHistoryController.homeEnvironment.value.toString(),
                textColor,
              ),
            if (familyHistoryController.noofChildren.value != null)
              customInfo(
                'No of children',
                familyHistoryController.noofChildren.value.toString(),
                textColor,
              ),
            if (familyHistoryController.lactateCondition.value != null)
              customInfo(
                'Lactate condition',
                familyHistoryController.lactateCondition.value.toString(),
                textColor,
              ),
            if (familyHistoryController.anydisableperson.value != null)
              customInfo(
                'Any other disabled person',
                familyHistoryController.anydisableperson.value.toString(),
                textColor,
              ),
            if (familyHistoryController.psychologicalCondition.value != null)
              customInfo(
                'Psychological condition',
                familyHistoryController.psychologicalCondition.value.toString(),
                textColor,
              ),
            if (familyHistoryController.firstcousinMarriage.value != null)
              customInfo(
                '1st cousine marriage',
                familyHistoryController.firstcousinMarriage.value.toString(),
                textColor,
              ),
            SizedBox(height: 20),
          ],

          if (birthHistoryController.isBirthHIstoryNull()) ...[
            Text(
              'Birth History',
              style: myStyle(
                18,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaincolor
                    : QuickTechAppColors.darkmaincolor,
                FontWeight.bold,
              ),
            ),
            if (birthHistoryController.birthInjury.value != null)
              customInfo(
                'Birth injury',
                birthHistoryController.birthInjury.value.toString(),
                textColor,
              ),
            if (birthHistoryController.complication.value != null)
              customInfo(
                'Any complication during delivery',
                birthHistoryController.complication.value.toString(),
                textColor,
              ),
            if (birthHistoryController.deliveryType.value != null)
              customInfo(
                'Delivery type ',
                birthHistoryController.deliveryType.value.toString(),
                textColor,
              ),
            if (birthHistoryController.noOfLabor.value != null)
              customInfo(
                'No of labor',
                birthHistoryController.noOfLabor.value.toString(),
                textColor,
              ),
            if (birthHistoryController.childPosition.value != null)
              customInfo(
                'Child position',
                birthHistoryController.childPosition.value.toString(),
                textColor,
              ),
            if (birthHistoryController.birthWeight.value != null)
              customInfo(
                'Birth weight',
                birthHistoryController.birthWeight.value.toString(),
                textColor,
              ),
            if (birthHistoryController.pregnancyMaturity.value != null)
              customInfo(
                'Pregnancy maturity',
                birthHistoryController.pregnancyMaturity.value.toString(),
                textColor,
              ),
            if (birthHistoryController.deliveryPlace.value != null)
              customInfo(
                'Delivery place',
                birthHistoryController.deliveryPlace.value.toString(),
                textColor,
              ),
            if (birthHistoryController.laborDuration.value != null)
              customInfo(
                'Duration of labor',
                birthHistoryController.laborDuration.value.toString(),
                textColor,
              ),
            if (birthHistoryController.afterBirthProblem.value != null)
              customInfo(
                'After birth problem',
                birthHistoryController.afterBirthProblem.value.toString(),
                textColor,
              ),
            SizedBox(height: 20),
          ],

          if (motherHealthController.isMotherHealthNull()) ...[
            Text(
              'Mother health condition during pregnancy',
              style: myStyle(
                18,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaincolor
                    : QuickTechAppColors.darkmaincolor,
                FontWeight.bold,
              ),
            ),
            if (motherHealthController.bloodPressure.value != null)
              customInfo(
                'Blood pressure',
                motherHealthController.bloodPressure.value.toString(),
                textColor,
              ),
            if (motherHealthController.preeclampsia.value != null)
              customInfo(
                'preeclampsia',
                motherHealthController.preeclampsia.value.toString(),
                textColor,
              ),
            if (motherHealthController.bleeding.value != null)
              customInfo(
                'Bleeding',
                motherHealthController.bleeding.value.toString(),
                textColor,
              ),
            if (motherHealthController.diabetes.value != null)
              customInfo(
                'Diabetes mellitus',
                motherHealthController.diabetes.value.toString(),
                textColor,
              ),
            if (motherHealthController.infection.value != null)
              customInfo(
                'Infection',
                motherHealthController.infection.value.toString(),
                textColor,
              ),
            if (motherHealthController.anxiety.value != null)
              customInfo(
                'Anxiety or stress',
                motherHealthController.anxiety.value.toString(),
                textColor,
              ),
            SizedBox(height: 20),
          ],

         if (pastMedicalHistoryController.getSelectedItems().isNotEmpty) ...[
            Text(
              'Past Medical History',
              style: myStyle(
                18,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaincolor
                    : QuickTechAppColors.darkmaincolor,
                FontWeight.bold,
              ),
            ),
            ...pastMedicalHistoryController.getSelectedItems().map((name) => customInfo(name, 'Yes', textColor)),
            SizedBox(height: 20),
          ],

          if (onExaminationController.isOnExaminationNull()) ...[
            Text(
              'On Examination',
              style: myStyle(
                20,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaincolor
                    : QuickTechAppColors.darkmaincolor,
                FontWeight.bold,
              ),
            ),
            if (onExaminationController.bodyType.value != null)
              customInfo(
                'Body type',
                onExaminationController.bodyType.value.toString(),
                textColor,
              ),
            if (onExaminationController.posture.value != null)
              customInfo(
                'Posture',
                onExaminationController.posture.value.toString(),
                textColor,
              ),
            if (onExaminationController.gait.value != null)
              customInfo(
                'Gait',
                onExaminationController.gait.value.toString(),
                textColor,
              ),
            if (onExaminationController.activity.value != null)
              customInfo(
                'Activity',
                onExaminationController.activity.value.toString(),
                textColor,
              ),
            if (onExaminationController.percussion.value != null)
              customInfo(
                'Percussion',
                onExaminationController.percussion.value.toString(),
                textColor,
              ),
            if (onExaminationController.temperature.value != null)
              customInfo(
                'Temperature',
                onExaminationController.temperature.value.toString(),
                textColor,
              ),
            if (onExaminationController.pulse.value != null)
              customInfo(
                'Pulse',
                onExaminationController.pulse.value.toString(),
                textColor,
              ),
            if (onExaminationController.bloodPressure.value != null)
              customInfo(
                'Blood pressure',
                onExaminationController.bloodPressure.value.toString(),
                textColor,
              ),
            if (onExaminationController.inflammatorySign.value.isNotEmpty)
              customInfo(
                'Inflammatory sign',
                onExaminationController.inflammatorySign.value.toString(),
                textColor,
              ),
            // Display selected reflexes
                  if (onExaminationController.reflex.value != null)
                    ReflexSection(
                      onExaminationController.reflex.value!,
                      textColor,
                    ),
            if (onExaminationController.sensory.value != null)
              customInfo(
                'Sensory',
                onExaminationController.sensory.value.toString(),
                textColor,
              ),
            if (onExaminationController.motor.value != null)
              customInfo(
                'Motor',
                onExaminationController.motor.value.toString(),
                textColor,
              ),
            if (onExaminationController.muscleTone.value != null)
              customInfo(
                'Muslce Tone',
                onExaminationController.muscleTone.value.toString(),
                textColor,
              ),
            if (onExaminationController.spasticity.value != null)
              customInfo(
                'Spasticity',
                onExaminationController.spasticity.value.toString(),
                textColor,
              ),
            if (onExaminationController.bowelBladderControl.value != null)
              customInfo(
                'Bowel bladder control',
                onExaminationController.bowelBladderControl.value.toString(),
                textColor,
              ),

            if (onExaminationController.limbOrOrganAbsence.value != null)
              customInfo(
                'Any limb or organ absence',
                onExaminationController.limbOrOrganAbsence.value.toString(),
                textColor,
              ),
            if (onExaminationController.balancingCondition.value != null)
              customInfo(
                'Balancing or co ordination',
                onExaminationController.balancingCondition.value.toString(),
                textColor,
              ),
            if (onExaminationController.others.value != null)
              customInfo(
                'Others',
                onExaminationController.others.value.toString(),
                textColor,
              ),
            SizedBox(height: 20),
          ],
          if (musclePowerController.isMusclePowerNull()) ...[
            Text(
              'Muscle Power',
              style: myStyle(
                20,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaincolor
                    : QuickTechAppColors.darkmaincolor,
                FontWeight.bold,
              ),
            ),
            if (musclePowerController.uppermovementController.text.isNotEmpty)
              customInfo(
                'Upper Limb Movement',
                musclePowerController.uppermovementController.text,
                textColor,
              ),
            if (musclePowerController.uppermusclenameController.text.isNotEmpty)
              customInfo(
                'Upper Limb Muscle Name',
                musclePowerController.uppermusclenameController.text,
                textColor,
              ),
            if (musclePowerController
                .upperleftInitialController
                .text
                .isNotEmpty)
              customInfo(
                'Upper Left Initial',
                musclePowerController.upperleftInitialController.text,
                textColor,
              ),
            if (musclePowerController
                .upperrightInitialController
                .text
                .isNotEmpty)
              customInfo(
                'Upper Right Initial',
                musclePowerController.upperrightInitialController.text,
                textColor,
              ),
            if (musclePowerController
                .upperleftDischargeController
                .text
                .isNotEmpty)
              customInfo(
                'Upper Left Discharge',
                musclePowerController.upperleftDischargeController.text,
                textColor,
              ),
            if (musclePowerController
                .upperrightDischargeController
                .text
                .isNotEmpty)
              customInfo(
                'Upper Right Discharge',
                musclePowerController.upperrightDischargeController.text,
                textColor,
              ),
            if (musclePowerController.upperCommentController.text.isNotEmpty)
              customInfo(
                'Upper Limb Comment',
                musclePowerController.upperCommentController.text,
                textColor,
              ),
            if (musclePowerController.lowermovementController.text.isNotEmpty)
              customInfo(
                'Lower Limb Movement',
                musclePowerController.lowermovementController.text,
                textColor,
              ),
            if (musclePowerController.lowermusclenameController.text.isNotEmpty)
              customInfo(
                'Lower Limb Muscle Name',
                musclePowerController.lowermusclenameController.text,
                textColor,
              ),
            if (musclePowerController
                .lowerleftInitialController
                .text
                .isNotEmpty)
              customInfo(
                'Lower Left Initial',
                musclePowerController.lowerleftInitialController.text,
                textColor,
              ),
            if (musclePowerController
                .lowerrightInitialController
                .text
                .isNotEmpty)
              customInfo(
                'Lower Right Initial',
                musclePowerController.lowerrightInitialController.text,
                textColor,
              ),
            if (musclePowerController
                .lowerleftDischargeController
                .text
                .isNotEmpty)
              customInfo(
                'Lower Left Discharge',
                musclePowerController.lowerleftDischargeController.text,
                textColor,
              ),
            if (musclePowerController
                .lowerrightDischargeController
                .text
                .isNotEmpty)
              customInfo(
                'Lower Right Discharge',
                musclePowerController.lowerrightDischargeController.text,
                textColor,
              ),
            if (musclePowerController.lowerCommentController.text.isNotEmpty)
              customInfo(
                'Lower Limb Comment',
                musclePowerController.lowerCommentController.text,
                textColor,
              ),
            if (musclePowerController.oxfordMuscle.value != null &&
                musclePowerController.oxfordMuscle.value!.isNotEmpty)
              customInfo(
                'Oxford Muscle Score',
                musclePowerController.oxfordMuscle.value!,
                textColor,
              ),
          ],
          if (range0fMotionController.isRangeofMotionNull()) ...[
            Text(
              'Muscle Power',
              style: myStyle(
                20,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaincolor
                    : QuickTechAppColors.darkmaincolor,
                FontWeight.bold,
              ),
            ),
            if (range0fMotionController.uppermovementController.text.isNotEmpty)
              customInfo(
                'Upper Limb Movement',
                range0fMotionController.uppermovementController.text,
                textColor,
              ),
            if (range0fMotionController
                .uppermusclenameController
                .text
                .isNotEmpty)
              customInfo(
                'Upper Limb Muscle Name',
                range0fMotionController.uppermusclenameController.text,
                textColor,
              ),
            if (range0fMotionController
                .upperleftInitialROMController
                .text
                .isNotEmpty)
              customInfo(
                'Upper Left Initial ROM',
                range0fMotionController.upperleftInitialROMController.text,
                textColor,
              ),
            if (range0fMotionController
                .upperrightInitialROMController
                .text
                .isNotEmpty)
              customInfo(
                'Upper Right Initial ROM',
                range0fMotionController.upperrightInitialROMController.text,
                textColor,
              ),
            if (range0fMotionController
                .upperleftDischargeROMController
                .text
                .isNotEmpty)
              customInfo(
                'Upper Left Discharge ROM',
                range0fMotionController.upperleftDischargeROMController.text,
                textColor,
              ),
            if (range0fMotionController
                .upperrightDischargeROMController
                .text
                .isNotEmpty)
              customInfo(
                'Upper Right Discharge ROM',
                range0fMotionController.upperrightDischargeROMController.text,
                textColor,
              ),
            if (range0fMotionController.upperCommentController.text.isNotEmpty)
              customInfo(
                'Upper Limb Comment',
                range0fMotionController.upperCommentController.text,
                textColor,
              ),
            if (range0fMotionController.lowermovementController.text.isNotEmpty)
              customInfo(
                'Lower Limb Movement',
                range0fMotionController.lowermovementController.text,
                textColor,
              ),
            if (range0fMotionController
                .lowermusclenameController
                .text
                .isNotEmpty)
              customInfo(
                'Lower Limb Muscle Name',
                range0fMotionController.lowermusclenameController.text,
                textColor,
              ),
            if (range0fMotionController
                .lowerleftInitialROMController
                .text
                .isNotEmpty)
              customInfo(
                'Lower Left Initial ROM',
                range0fMotionController.lowerleftInitialROMController.text,
                textColor,
              ),
            if (range0fMotionController
                .lowerrightInitialROMController
                .text
                .isNotEmpty)
              customInfo(
                'Lower Right Initial ROM',
                range0fMotionController.lowerrightInitialROMController.text,
                textColor,
              ),
            if (range0fMotionController
                .lowerleftDischargeROMController
                .text
                .isNotEmpty)
              customInfo(
                'Lower Left Discharge ROM',
                range0fMotionController.lowerleftDischargeROMController.text,
                textColor,
              ),
            if (range0fMotionController
                .lowerrightDischargeROMController
                .text
                .isNotEmpty)
              customInfo(
                'Lower Right Discharge ROM',
                range0fMotionController.lowerrightDischargeROMController.text,
                textColor,
              ),
            if (range0fMotionController.lowerCommentController.text.isNotEmpty)
              customInfo(
                'Lower Limb Comment',
                range0fMotionController.lowerCommentController.text,
                textColor,
              ),
            if (range0fMotionController.oxfordMuscle.value != null &&
                range0fMotionController.oxfordMuscle.value!.isNotEmpty)
              customInfo(
                'Oxford Muscle Score',
                range0fMotionController.oxfordMuscle.value!,
                textColor,
              ),
            SizedBox(height: 20),
          ],
          if (problemSummaryController.isProblemSummaryNull()) ...[
            Text(
              'Problem summary, Goal and plan',
              style: myStyle(
                20,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaincolor
                    : QuickTechAppColors.darkmaincolor,
                FontWeight.bold,
              ),
            ),
            if (problemSummaryController.problemListController.text.isNotEmpty)
              customInfo(
                'Problem list',
                problemSummaryController.problemListController.text,
                textColor,
              ),
            if (problemSummaryController.goalListController.text.isNotEmpty)
              customInfo(
                'Goal',
                problemSummaryController.goalListController.text,
                textColor,
              ),
            if (problemSummaryController
                .treatmentPlanController
                .text
                .isNotEmpty)
              customInfo(
                'Treatment plan',
                problemSummaryController.treatmentPlanController.text,
                textColor,
              ),
                       SizedBox(height: 20),
          ],
          if (homeAdviceController.isHomeAdviceNull()) ...[
            Text(
              'Home Advice',
              style: myStyle(
                20,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaincolor
                    : QuickTechAppColors.darkmaincolor,
                FontWeight.bold,
              ),
            ),
            if (homeAdviceController.homeAdviceController.text.isNotEmpty)
              customInfo(
                'Home Advice',
                homeAdviceController.homeAdviceController.text,
                textColor,
              ),
              SizedBox(height: 20,)
          ],
          if (diagnosisController.selectedDiagnosis.isNotEmpty) ...[
            Text(
              'Differential Diagnosis',
              style: myStyle(
                20,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaincolor
                    : QuickTechAppColors.darkmaincolor,
                FontWeight.bold,
              ),
            ),
            ...diagnosisController.selectedDiagnosis.map((diagnosis) {
              List<String> subDiagnoses =
                  diagnosisController.selectedsubDiagnosis[diagnosis] ?? [];

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    diagnosis,
                    style: myStyle(16, textColor, FontWeight.bold),
                  ),
                  if (subDiagnoses.isNotEmpty) ...[
                    SizedBox(height: 6),
                    Text('=>', style: myStyle(14, textColor, FontWeight.bold)),
                    ...subDiagnoses.map((subDiagnosis) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          subDiagnosis,
                          style: myStyle(14, textColor.withValues(alpha: 0.8)),
                        ),
                      );
                    }).toList(),
                  ],
                  SizedBox(height: 10),
                ],
              );
            }).toList(),
            SizedBox(height: 20),
          ],

          if (assestiveDeviceController.selectedAssestiveDevice.isNotEmpty) ...[
            Text(
              'Advice for assistive device',
              style: myStyle(
                20,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaincolor
                    : QuickTechAppColors.darkmaincolor,
                FontWeight.bold,
              ),
            ),

            ...assestiveDeviceController.selectedAssestiveDevice.map((device) {
              List<String> subdevices =
                  assestiveDeviceController
                      .selectedsubAssestiveDevice[device] ??
                  [];

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(device, style: myStyle(16, textColor, FontWeight.bold)),
                  if (subdevices.isNotEmpty) ...[
                    SizedBox(height: 6),
                    Text('=>', style: myStyle(14, textColor, FontWeight.bold)),
                    ...subdevices.map((subdevice) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          subdevice,
                          style: myStyle(14, textColor.withValues(alpha: 0.8)),
                        ),
                      );
                    }).toList(),
                  ],
                  SizedBox(height: 10),
                ],
              );
            }).toList(),
            SizedBox(height: 20),
          ],
          if (referredToController.selectedReferredTo.isNotEmpty)
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
          ...referredToController.selectedReferredTo.map((referredto) {
            return Text(
              referredto,
              style: myStyle(16, textColor, FontWeight.bold),
            );
          }),
        ],
      ),
    );
  });
}

Widget ReflexSection(Map<String, String> reflexData, Color textColor) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Reflex:',
        style: myStyle(
         14, textColor, FontWeight.w600
        ),
      ),
     
      ...reflexData.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                  Text(
                    "*${entry.key}",
                    style: myStyle(
                      13,
                      textColor,
                      FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                if(entry.value!='Others')
                  Text(
                    "=>${entry.value}",
                    style: myStyle(
                      14,
                      textColor.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    ],
  );
}

Widget customInfo(String label, String value, Color textColor) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label:   ', style: myStyle(14, textColor, FontWeight.w600)),
        Expanded(
          child: Text(
            value.isNotEmpty ? value : '',
            style: myStyle(14, textColor.withValues(alpha: 0.9)),
          ),
        ),
      ],
    ),
  );
}
