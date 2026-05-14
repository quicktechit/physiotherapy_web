



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
import 'package:e_prescription/controllers/authentication_controller/login_controller/quick_tech_forgot_pass_controller.dart';
import 'package:e_prescription/controllers/authentication_controller/login_controller/quick_tech_login_controller.dart';
import 'package:e_prescription/controllers/authentication_controller/otp_controller/quick_tech_otp_controller.dart';
import 'package:e_prescription/controllers/authentication_controller/registration_controller/quick_tech_registration_controller.dart';
import 'package:e_prescription/controllers/blog_controller/quick_tech_blog_controller.dart';
import 'package:e_prescription/controllers/home_controller/image_slider_controller/quick_tech_image_slider_controller.dart';
import 'package:e_prescription/controllers/package_controller/quick_tech_package_controller.dart';
import 'package:e_prescription/controllers/patient_controller/quick_tech_patient_controller.dart';
import 'package:e_prescription/controllers/pdf_prescription_controller/quick_tech_pdf_controller.dart';
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
import 'package:e_prescription/controllers/profile_controller/quick_tech_profile_controller.dart';
import 'package:e_prescription/controllers/splash_screen/quick_tech_splash_screen_controller.dart';
import 'package:e_prescription/controllers/template_controller/quick_tech_template_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';

import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
void setUp() {
  // Guard: prevent double-registration on hot restart
  if (locator.isRegistered<QuickTechThemeController>()) return;

  ///Assessment Controllers
  locator.registerLazySingleton<QuickTechAssestiveDeviceController>(
    () => QuickTechAssestiveDeviceController(),
  );
  locator.registerLazySingleton<QuickTechBirthHistoryController>(
    () => QuickTechBirthHistoryController(),
  );
  locator.registerLazySingleton<QuickTechDifferentialDiagnosisController>(
    () => QuickTechDifferentialDiagnosisController(),
  );
  locator.registerLazySingleton<QuickTechFamilyHistoryController>(
    () => QuickTechFamilyHistoryController(),
  );
  locator.registerLazySingleton<QuickTechHomeAdviceController>(
    () => QuickTechHomeAdviceController(),
  );
  locator.registerLazySingleton<QuickTechMotherHealthController>(
    () => QuickTechMotherHealthController(),
  );
  locator.registerLazySingleton<QuickTechMusclePowerController>(
    () => QuickTechMusclePowerController(),
  );
  locator.registerLazySingleton<QuickTechOccupationHistoryController>(
    () => QuickTechOccupationHistoryController(),
  );
  locator.registerLazySingleton<QuickTechOnExaminationController>(
    () => QuickTechOnExaminationController(),
  );
  locator.registerLazySingleton<QuickTechReflexController>(
    () => QuickTechReflexController(),
  );
  locator.registerLazySingleton<QuickTechPastMedicalHistoryController>(
    () => QuickTechPastMedicalHistoryController(),
  );
  locator.registerLazySingleton<QuickTechPatientInfoController>(
    () => QuickTechPatientInfoController(),
  );
  locator.registerLazySingleton<QuickTechPdfAssesmentController>(
    () => QuickTechPdfAssesmentController(),
  );
  locator.registerLazySingleton<QuickTechProblemSummaryController>(
    () => QuickTechProblemSummaryController(),
  );
  locator.registerLazySingleton<QuickTechRange0fMotionController>(
    () => QuickTechRange0fMotionController(),
  );
  locator.registerLazySingleton<QuickTechReferredToController>(
    () => QuickTechReferredToController(),
  );
  locator.registerLazySingleton<QuickTechAssessmentController>(
    () => QuickTechAssessmentController(),
  );
  ///
  ///Authentication Controllers
  locator.registerLazySingleton<QuickTechForgotPassController>(
    () => QuickTechForgotPassController(),
  );
  locator.registerLazySingleton<QuickTechLoginController>(
    () => QuickTechLoginController(),
  );
  locator.registerLazySingleton<QuickTechOtpController>(
    () => QuickTechOtpController(),
  );
  locator.registerLazySingleton<QuickTechRegistrationController>(
    () => QuickTechRegistrationController(),
  );
  //
  ///Blog Controller
  locator.registerLazySingleton<QuickTechBlogController>(
    () => QuickTechBlogController(),
  );
  //
  ///Home Controller
  locator.registerLazySingleton<QuickTechImageSliderController>(
    () => QuickTechImageSliderController(),
  );
  //
  ///Package Controller
    locator.registerLazySingleton<QuickTechPackageController>(
    () => QuickTechPackageController(),
  );
  //
  ///Patient Controller
    locator.registerLazySingleton<QuickTechPatientController>(
    () => QuickTechPatientController(),
  );
  //
  ///Pdf Controller
    locator.registerLazySingleton<QuickTechPdfController>(
    () => QuickTechPdfController(),
  );
  //
  ///Prescription Controllers
     locator.registerLazySingleton<AssestiveDeviceController>(
    () => AssestiveDeviceController(),
  );
     locator.registerLazySingleton<CheifComplainController>(
    () => CheifComplainController(),
  );
     locator.registerLazySingleton<DiagnosisController>(
    () => DiagnosisController(),
  );
     locator.registerLazySingleton<DisabilityTypesController>(
    () => DisabilityTypesController(),
  );
     locator.registerLazySingleton<DrugHistoryController>(
    () => DrugHistoryController(),
  );
     locator.registerLazySingleton<MainDiagnosisController>(
    () => MainDiagnosisController(),
  );
     locator.registerLazySingleton<OnExaminationController>(
    () => OnExaminationController(),
  );
     locator.registerLazySingleton<OptimizedAdviceController>(
    () => OptimizedAdviceController(),
  );
     locator.registerLazySingleton<PreviousTherapyHistoryController>(
    () => PreviousTherapyHistoryController(),
  );
     locator.registerLazySingleton<PrimaryMedicalHistoryController>(
    () => PrimaryMedicalHistoryController(),
  );
     locator.registerLazySingleton<RadiologicalFindingsController>(
    () => RadiologicalFindingsController(),
  );
     locator.registerLazySingleton<ReferredToController>(
    () => ReferredToController(),
  );
     locator.registerLazySingleton<PatientInfoController>(
    () => PatientInfoController(),
  );
     locator.registerLazySingleton<QuickTechElectrotherapyController>(
    () => QuickTechElectrotherapyController(),
  );
     locator.registerLazySingleton<QuickTechManualTherapyController>(
    () => QuickTechManualTherapyController(),
  );
     locator.registerLazySingleton<QuickTechMiscellaneousTherapyController>(
    () => QuickTechMiscellaneousTherapyController(),
  );
     locator.registerLazySingleton<QuicktechmainPrescriptionControllr>(
    () => QuicktechmainPrescriptionControllr(),
  );
     locator.registerLazySingleton<QuickTechSpeechLanguageTherapyController>(
    () => QuickTechSpeechLanguageTherapyController(),
  );
  //
  ///Profile Controllers
     locator.registerLazySingleton<QuickTechProfileController>(
    () => QuickTechProfileController(),
  );
  //
  ///Splash Controllers
     locator.registerLazySingleton<QuickTechSplashScreenController>(
    () => QuickTechSplashScreenController(),
  );
  //
  ///Template Controllers
     locator.registerLazySingleton<QuickTechTemplateController>(
    () => QuickTechTemplateController(),
  );
  //
  ///Theme Controller
     locator.registerLazySingleton<QuickTechThemeController>(
    () => QuickTechThemeController(),
  );

  
}
