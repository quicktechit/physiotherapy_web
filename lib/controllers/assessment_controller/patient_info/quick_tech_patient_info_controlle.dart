import 'package:e_prescription/const/quick_tech_app_colors.dart';

import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/models/assessment/patient_info.dart';
import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:e_prescription/services/quick_tech_retry_service.dart';

class QuickTechPatientInfoController extends GetxController {

  // Holds the patient id after successful post
  final RxnInt patientId = RxnInt();
  String? token=QuickTechAuthStorageService.getToken();

  int? get currentPatientId {
  return patientId.value;
  }
  Future<String> getBearerToken() async {

    return token!;
  }

  // API endpoint
  final String apiUrl = '${Api.updateAssessmentPatientInfo}';
Future<int> postPatientInfo() async {
  final token = await getBearerToken();
  final patient = getPatientInfo();

  final Map<String, String> fields = {
    "name": patient.patientName,
    "father_name": patient.fatherName,
    "mother_name": patient.motherName,
    "spouse_name": patient.spouseName,
    "age": patient.age.toString(),
    "gender": patient.sex,
    "occupation": patient.occupation,
    "marital_status": patient.maritalStatus,
    "blood_group": patient.bloodGroup,
    "guardian_name": patient.guardianName,
    "voter_id": patient.voterID,
    "date_of_birth": birthDateController.text,
    "birth_registration": patient.birthRegistrationNo,
    "disability_id": patient.disabilityID,
    "patient_education": patient.educationOfPatient,
    "guardian_education": patient.educationOfGuardian,
    "phone": patient.phone,
  };

  debugPrint("📤 Request fields: ${jsonEncode(fields)}");

  try {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(apiUrl),
    );
    request.headers['Authorization'] = 'Bearer $token';
    request.fields.addAll(fields);

    final streamed = await retryRequest(
      () async {
        final r = http.MultipartRequest('POST', Uri.parse(apiUrl));
        r.headers['Authorization'] = 'Bearer $token';
        r.fields.addAll(fields);
        return http.Response.fromStream(await r.send());
      },
      maxAttempts: 5,
      initialDelay: const Duration(seconds: 2),
    );

    debugPrint("📥 Response [${streamed.statusCode}]: ${streamed.body}");

    if (streamed.statusCode == 200 || streamed.statusCode == 201) {
      final responseData = jsonDecode(streamed.body);
      if (responseData["patient"]?["id"] != null) {
        patientId.value = int.tryParse(responseData["patient"]["id"].toString());
        debugPrint("✅ Patient ID saved: ${patientId.value}");
      }
    }

    return streamed.statusCode;
  } catch (e, stack) {
    debugPrint("❌ Error: $e\n$stack");
    return 500;
  }
}

  TextEditingController patientNameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController spouseNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController voterIDController = TextEditingController();
  TextEditingController disabilityIDController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController guardianNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController birthRegistrationNoController = TextEditingController();
  TextEditingController educationOfPatientController = TextEditingController();
  TextEditingController educationOfGuardianController = TextEditingController();
  TextEditingController sexController = TextEditingController();
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

  RxInt age = 0.obs;


  var occupation = Rx<String?>(null);
  var maritalStatus = Rx<String?>(null);
  var educationOfPatient = Rx<String?>(null);
  var educationOfGuardian = Rx<String?>(null);
  var sex = Rx<String?>(null);

 
  var occupationOptions =
      [
        'Govt job',
        'Non govt job',
        'Agri work',
        'No work',
        'Student',
        'Business',
        'Others',
      ].obs;

  var maritalStatusOptions = ['Single', 'Married', 'Others'].obs;

  var educationOptions =
      [
        'Only read and write',
        'Under S.S.C',
        'S.S.C',
        'H.S.C',
        'Honours',
        'Masters',
        'Higher study',
        'Others',
      ].obs;

  var sexOptions = ['Male', 'Female', 'Other'].obs;


  void updatePatientName(String name) {
    // controller already has the text from user input; no reassignment needed
  }

  void updateFatherName(String name) {
    // controller already has the text from user input; no reassignment needed
  }

  void updateMotherName(String name) {
    // controller already has the text from user input; no reassignment needed
  }

  void updatePhoneNumber(String phone) {
    // controller already has the text from user input; no reassignment needed
  }

  void updateSpouseName(String name) {
    // controller already has the text from user input; no reassignment needed
  }

  void updateAge(int newAge) {
    age.value = newAge;
    // do NOT set ageController.text here — it resets cursor on web
  }

  void updateVoterID(String id) {
    // controller already has the text from user input; no reassignment needed
  }

  void updateDisabilityID(String id) {
    // controller already has the text from user input; no reassignment needed
  }

  void updateBloodGroup(String group) {
    // controller already has the text from user input; no reassignment needed
  }

  void updateGuardianName(String name) {
    // controller already has the text from user input; no reassignment needed
  }

  void updateBirthDate(String date) {
    // do NOT set birthDateController.text — it resets cursor on web
    update();
  }

  void updateOccupation(String? newOccupation) {
    if (newOccupation != null) {
      occupation.value = newOccupation;
      // do NOT set occupationController.text — it resets cursor on web

      if (!occupationOptions.contains(newOccupation)) {
        occupationOptions.add(newOccupation);
      }
    }
  }

  void updateMaritalStatus(String status) {
    maritalStatus.value = status;
    // do NOT set maritalStatusController.text — it resets cursor on web
  }

  void updateBirthRegistrationNo(String registrationNo) {
    // controller already has the text from user input; no reassignment needed
  }

  void updateEducationOfPatient(String education) {
    educationOfPatient.value = education;
    // do NOT set educationOfPatientController.text — it resets cursor on web
  }

  void updateEducationOfGuardian(String education) {
    educationOfGuardian.value = education;
    // do NOT set educationOfGuardianController.text — it resets cursor on web
  }

  void updateSex(String gender) {
    sex.value = gender;
    // do NOT set sexController.text — it resets cursor on web
  }

PatientInfo getPatientInfo() {
  return PatientInfo(
    patientName: patientNameController.text,
    age: age.value,
    fatherName: fatherNameController.text,
    motherName: motherNameController.text,
    phone: phoneController.text,
    birthDate: DateTime.now(),
    spouseName: spouseNameController.text,
    voterID: voterIDController.text,
    occupation: occupation.value ?? '',         // ✅ Rx value
    maritalStatus: maritalStatus.value ?? '',   // ✅ Rx value
    disabilityID: disabilityIDController.text,
    educationOfPatient: educationOfPatient.value ?? '',   // ✅ Rx value
    bloodGroup: bloodGroupController.text,
    educationOfGuardian: educationOfGuardian.value ?? '', // ✅ Rx value
    guardianName: guardianNameController.text,
    birthRegistrationNo: birthRegistrationNoController.text,
    sex: sex.value ?? '',  // ✅ Rx value
  );
}
Future<void> selectDateOfBirth(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: themeController.isDay.value
                ? QuickTechAppColors.lightmaincolor
                : QuickTechAppColors.darkmaincolor,
            onPrimary: Colors.white,
            surface: themeController.isDay.value
                ? QuickTechAppColors.lightScaffoldColor
                : QuickTechAppColors.darkScaffoldColor,
            onSurface: themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor
                : QuickTechAppColors.darkmaintextcolor,
          ),
          dialogTheme: DialogThemeData(
            backgroundColor: themeController.isDay.value ? Colors.white : QuickTechAppColors.black,
          ),
        ),
        child: child!,
      );
    },
  );

  if (pickedDate != null) {
    // ✅ Format as yyyy-MM-dd for API + update controller so UI shows it
    final formatted = "${pickedDate.year.toString().padLeft(4, '0')}-"
        "${pickedDate.month.toString().padLeft(2, '0')}-"
        "${pickedDate.day.toString().padLeft(2, '0')}";
    birthDateController.text = formatted; // ✅ This was missing — fixes date not showing
    update();
  }
}
  // Function to clear all patient information fields
  void clearPatientInfo() {
    patientNameController.clear();
    fatherNameController.clear();
    motherNameController.clear();
    phoneController.clear();
    spouseNameController.clear();
    ageController.clear();
    voterIDController.clear();
    disabilityIDController.clear();
    bloodGroupController.clear();
    guardianNameController.clear();
    birthDateController.clear();
    occupationController.clear();
    maritalStatusController.clear();
    birthRegistrationNoController.clear();
    educationOfPatientController.clear();
    educationOfGuardianController.clear();
    sexController.clear();
    age.value = 0;
    occupation.value = null;
    maritalStatus.value = null;
    educationOfPatient.value = null;
    educationOfGuardian.value = null;
    sex.value = null;
    patientId.value = null;
    update();
  }
}
