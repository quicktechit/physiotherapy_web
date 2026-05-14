
import '../locator.dart';
// Assessment Controllers
import 'package:e_prescription/controllers/assessment_controller/assestive_device/quick_tech_assestive_device_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/birth_history/quick_tech_birth_history_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/differential_diagnosis/quick_tech_differential_diagnosis_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/family_history/quick_tech_family_history_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/home_advice/quick_tech_home_advice_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/mother_health_condition_during_pregnancy/quick_tech_mother_health_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/muscle_power/quick_tech_muscle_power_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/occupation_history/quick_tech_occupation_history_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/on_examination/quick_tech_on_examination_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/on_examination/reflex/quick_tech_reflex_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/past_medical_history/quick_tech_past_medical_history_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/patient_info/quick_tech_patient_info_controlle.dart';
import 'package:e_prescription/controllers/assessment_controller/pdf_assesment_generate/quick_tech_pdf_assesment_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/problem_summary/quick_tech_problem_summary_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/quick_tech_assessment_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/range_of_motion/quick_tech_range0f_motion_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/referred_to/quick_tech_referred_to_controller.dart';

// Authentication Controllers
import 'package:e_prescription/controllers/authentication_controller/login_controller/quick_tech_forgot_pass_controller.dart';
import 'package:e_prescription/controllers/authentication_controller/login_controller/quick_tech_login_controller.dart';
import 'package:e_prescription/controllers/authentication_controller/otp_controller/quick_tech_otp_controller.dart';
import 'package:e_prescription/controllers/authentication_controller/registration_controller/quick_tech_registration_controller.dart';

// Blog Controller
import 'package:e_prescription/controllers/blog_controller/quick_tech_blog_controller.dart';

// Home Controller
import 'package:e_prescription/controllers/home_controller/image_slider_controller/quick_tech_image_slider_controller.dart';

// Package Controller
import 'package:e_prescription/controllers/package_controller/quick_tech_package_controller.dart';

// Patient Controller
import 'package:e_prescription/controllers/patient_controller/quick_tech_patient_controller.dart';

// Pdf Controller
import 'package:e_prescription/controllers/pdf_prescription_controller/quick_tech_pdf_controller.dart';

// Prescription Controllers
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/assestive_device_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/cheif_complain_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/diagnosis_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/disability_types_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/drug_history_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/main_diagnosis_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/on_examination_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/optimized_advice_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/previous_therapy_Controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/primary_medical_history_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/radiological_findings_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/referred_to_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/patient_info_controller/patient_info_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_electrotherapy_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_manual_therapy_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_miscellaneous_therapy_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_rx_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_speech_language_therapy_controller.dart';

// Profile Controller
import 'package:e_prescription/controllers/profile_controller/quick_tech_profile_controller.dart';

// Splash Controller
import 'package:e_prescription/controllers/splash_screen/quick_tech_splash_screen_controller.dart';

// Template Controller
import 'package:e_prescription/controllers/template_controller/quick_tech_template_controller.dart';

// Theme Controller
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';

mixin BaseController {
  // Assessment Controllers
  final QuickTechAssestiveDeviceController assestiveDeviceController = locator.get<QuickTechAssestiveDeviceController>();
  final QuickTechBirthHistoryController birthHistoryController = locator.get<QuickTechBirthHistoryController>();
  final QuickTechDifferentialDiagnosisController differentialDiagnosisController = locator.get<QuickTechDifferentialDiagnosisController>();
  final QuickTechFamilyHistoryController familyHistoryController = locator.get<QuickTechFamilyHistoryController>();
  final QuickTechHomeAdviceController homeAdviceController = locator.get<QuickTechHomeAdviceController>();
  final QuickTechMotherHealthController motherHealthController = locator.get<QuickTechMotherHealthController>();
  final QuickTechMusclePowerController musclePowerController = locator.get<QuickTechMusclePowerController>();
  final QuickTechOccupationHistoryController occupationHistoryController = locator.get<QuickTechOccupationHistoryController>();
  final QuickTechOnExaminationController onExaminationController = locator.get<QuickTechOnExaminationController>();
  final QuickTechReflexController reflexController = locator.get<QuickTechReflexController>();
  final QuickTechPastMedicalHistoryController pastMedicalHistoryController = locator.get<QuickTechPastMedicalHistoryController>();
  final QuickTechPatientInfoController assessmentPatientInfoController = locator.get<QuickTechPatientInfoController>();
  final QuickTechPdfAssesmentController pdfAssesmentController = locator.get<QuickTechPdfAssesmentController>();
  final QuickTechProblemSummaryController problemSummaryController = locator.get<QuickTechProblemSummaryController>();
  final QuickTechRange0fMotionController rangeOfMotionController = locator.get<QuickTechRange0fMotionController>();
  final QuickTechReferredToController assessmentReferredToController = locator.get<QuickTechReferredToController>();
  final QuickTechAssessmentController assessmentController = locator.get<QuickTechAssessmentController>();

  // Authentication Controllers
  final QuickTechForgotPassController forgotPassController = locator.get<QuickTechForgotPassController>();
  final QuickTechLoginController loginController = locator.get<QuickTechLoginController>();
  final QuickTechOtpController otpController = locator.get<QuickTechOtpController>();
  final QuickTechRegistrationController registrationController = locator.get<QuickTechRegistrationController>();

  // Blog Controller
  final QuickTechBlogController blogController = locator.get<QuickTechBlogController>();

  // Home Controller
  final QuickTechImageSliderController imageSliderController = locator.get<QuickTechImageSliderController>();

  // Package Controller
  final QuickTechPackageController packageController = locator.get<QuickTechPackageController>();

  // Patient Controller
  final QuickTechPatientController patientController = locator.get<QuickTechPatientController>();

  // Pdf Controller
  final QuickTechPdfController pdfController = locator.get<QuickTechPdfController>();

  // Prescription Controllers
  final AssestiveDeviceController prescriptionAssestiveDeviceController = locator.get<AssestiveDeviceController>();
  final CheifComplainController cheifComplainController = locator.get<CheifComplainController>();
  final DiagnosisController diagnosisController = locator.get<DiagnosisController>();
  final DisabilityTypesController disabilityTypesController = locator.get<DisabilityTypesController>();
  final DrugHistoryController drugHistoryController = locator.get<DrugHistoryController>();
  final MainDiagnosisController mainDiagnosisController = locator.get<MainDiagnosisController>();
  final OnExaminationController prescriptionOnExaminationController = locator.get<OnExaminationController>();
  final OptimizedAdviceController optimizedAdviceController = locator.get<OptimizedAdviceController>();
  final PreviousTherapyHistoryController previousTherapyHistoryController = locator.get<PreviousTherapyHistoryController>();
  final PrimaryMedicalHistoryController primaryMedicalHistoryController = locator.get<PrimaryMedicalHistoryController>();
  final RadiologicalFindingsController radiologicalFindingsController = locator.get<RadiologicalFindingsController>();
  final ReferredToController prescriptionReferredToController = locator.get<ReferredToController>();
  final PatientInfoController patientInfoController = locator.get<PatientInfoController>();
  final QuickTechElectrotherapyController electrotherapyController = locator.get<QuickTechElectrotherapyController>();
  final QuickTechManualTherapyController manualTherapyController = locator.get<QuickTechManualTherapyController>();
  final QuickTechMiscellaneousTherapyController miscellaneousTherapyController = locator.get<QuickTechMiscellaneousTherapyController>();
  final QuicktechmainPrescriptionControllr mainPrescriptionController = locator.get<QuicktechmainPrescriptionControllr>();
  final QuickTechSpeechLanguageTherapyController speechLanguageTherapyController = locator.get<QuickTechSpeechLanguageTherapyController>();

  // Profile Controller
  final QuickTechProfileController profileController = locator.get<QuickTechProfileController>();

  // Splash Controller
  final QuickTechSplashScreenController splashScreenController = locator.get<QuickTechSplashScreenController>();

  // Template Controller
  final QuickTechTemplateController templateController = locator.get<QuickTechTemplateController>();

  // Theme Controller
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
}
