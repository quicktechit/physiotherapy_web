import 'dart:typed_data';

import 'package:e_prescription/screens/add_assesment/assesment_pdf_generate/quick_tech_assesment_pdf.dart';
import 'package:e_prescription/screens/add_assesment/preview_assesment/quick_tech_assesment_preview.dart';
import 'package:e_prescription/screens/add_assesment/quick_tech_add_assesment_page.dart';
import 'package:e_prescription/screens/authentications/login/forgot_password/quick_tech_forgot_password.dart';
import 'package:e_prescription/screens/authentications/login/quick_tech_login.dart';
import 'package:e_prescription/screens/authentications/registration/quick_tech_registration.dart';
import 'package:e_prescription/screens/blogs/blog_details/quick_tech_blog_details.dart';
import 'package:e_prescription/screens/blogs/quick_tech_blogs.dart';
import 'package:e_prescription/screens/homepage/quick_tech_home_page.dart';
import 'package:e_prescription/screens/homepage/quick_tech_main_home.dart';
import 'package:e_prescription/screens/packages/quick_tech_packages.dart';
import 'package:e_prescription/screens/patient_records/quick_tech_patient_records.dart';
import 'package:e_prescription/screens/patient_records/patient_details/quick_tech_patients_details.dart';
import 'package:e_prescription/screens/pdf_prescription/quick_tech_pdf_prescription.dart';
import 'package:e_prescription/screens/add_prescription/preview_screen/quick_tech_preview_prescription.dart';
import 'package:e_prescription/screens/add_prescription/quick_tech_add_prescription_form.dart';
import 'package:e_prescription/screens/profile/profile_update/quick_tech_profile_update.dart';
import 'package:e_prescription/screens/profile/quick_tech_profile_page.dart';
import 'package:e_prescription/screens/settings/quick_tech_settings.dart';
import 'package:e_prescription/screens/splash_screen/quick_tech_splash_screen.dart';
import 'package:e_prescription/screens/templates/quick_tech_templates_selection.dart';
import 'package:e_prescription/models/patient_model.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: '/',
      page: () => QuickTechSplashScreen(),
      transition: Transition.fadeIn,  

    ),
    GetPage(
      name: '/home',
      page: () => QuickTechHomePage(),
      transition: Transition.leftToRight, 
 
    ),
    GetPage(
      name: '/login',
      page: () => QuickTechLogin(),
      transition: Transition.rightToLeft,  

    ),
    
    GetPage(
      name: '/registration',
      page: () => QuickTechRegistration(),
      transition: Transition.downToUp,  
    ),
    GetPage(
      name: '/forgotpass',
      page: () => QuickTechForgotPassword(),
      transition: Transition.rightToLeft,  
    ),
    GetPage(
      name: '/mainhome',
      page: () => QuickTechMainHome(),
      transition: Transition.zoom, 
    ),
    GetPage(
      name: '/templateselect',
      page: () => QuickTechTemplatesSelection(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: '/prescriptionform',
      page: () => QuickTechPrescriptionForm(),
      transition: Transition.fadeIn, 
    ),
    GetPage(
      name: '/packages',
      page: () => QuickTechPackages(),
      transition: Transition.fadeIn, 
    ),
    GetPage(
      name: '/profile',
      page: () => QuickTechProfilePage(isAppBarVisible: true,),
      transition: Transition.zoom, 
    ),
    GetPage(
      name: '/profileupdate',
      page: () => QuickTechProfileUpdatePage(),
      transition: Transition.zoom, 
    ),
    GetPage(
      name: '/preview',
      page: () => QuickTechPreviewPrescription(),
      transition: Transition.zoom, 
    ),
    GetPage(
      name: '/patientrecords',
      page: () => QuickTechPatientRecords(isAppBarVisible: true,),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/patientdetails',
      page: () {
        final args = Get.arguments;
        if (args is Patient) {
          return QuickTechPatientsDetails(patient: args);
        }
        return QuickTechPatientRecords(isAppBarVisible: true);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/pdfprescription',
      page: () {
        final args = Get.arguments;
        if (args is Uint8List) {
          return QuickTechPdfPrescription(pdfBytes: args);
        }
        return QuickTechPatientRecords(isAppBarVisible: true);
      },
      transition: Transition.cupertino,
    ),
    GetPage(
      name: '/settings',
      page: () => QuickTechSettings(isAppBarVisible: true,),
      transition: Transition.fadeIn,
    ),
 GetPage(
      name: '/blogs',
      page: () => QuickTechBlogs(),
      transition: Transition.fadeIn,
    ),
 GetPage(
      name: '/blogdetails',
      page: () {
        final args = Get.arguments;
        if (args is int) {
          return QuickTechBlogDetails(id: args);
        }
        return QuickTechBlogs();
      },
      transition: Transition.fadeIn,
    ),
 GetPage(
      name: '/addassessment',
      page: () => QuickTechAddAssesmentPage(),
      transition: Transition.fadeIn,
    ),
 GetPage(
      name: '/assessmentpreview',
      page: () => QuickTechAssesmentPreview(),
      transition: Transition.fadeIn,
    ),
 GetPage(
      name: '/assessmentPdf',
      page: () => QuickTechAssesmentPdf(),
      transition: Transition.fadeIn,
    ),
  ];
}
