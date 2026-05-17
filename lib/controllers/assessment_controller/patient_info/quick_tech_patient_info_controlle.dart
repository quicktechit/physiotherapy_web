import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
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

  // Use this api to Post Patient Info
  Future<int> postPatientInfo() async {
    final token = await getBearerToken();
    final patient = getPatientInfo();
    final Map<String, dynamic> data = {
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
    try {
      final response = await retryRequest(() => http.post(
            Uri.parse(apiUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(data),
          ),
          maxAttempts: 5,
          initialDelay: const Duration(seconds: 2));
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("Patient Info Uploaded Successfully:");
        print(jsonEncode(responseData["patient"]));

        if (responseData["patient"] != null && responseData["patient"]["id"] != null) {
          patientId.value = int.tryParse(responseData["patient"]["id"].toString());
        }
        print("Successfully Patient Info Stored");

      } else {
        print("Failed to upload patient info. Status: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
      return response.statusCode;
    } catch (e) {
      print("Error: $e");
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
    birthDateController.text = date;
    update();
  }

  void updateOccupation(String? newOccupation) {
    if (newOccupation != null) {
      occupation.value = newOccupation;
      occupationController.text = newOccupation;

      if (!occupationOptions.contains(newOccupation)) {
        occupationOptions.add(newOccupation);
      }
    }
  }

  void updateMaritalStatus(String status) {
    maritalStatus.value = status;
    maritalStatusController.text = status;
  }

  void updateBirthRegistrationNo(String registrationNo) {
    // controller already has the text from user input; no reassignment needed
  }

  void updateEducationOfPatient(String education) {
    educationOfPatient.value = education;
    educationOfPatientController.text = education;
  }

  void updateEducationOfGuardian(String education) {
    educationOfGuardian.value = education;
    educationOfGuardianController.text = education;
  }

  void updateSex(String gender) {
    sex.value = gender;
    sexController.text = gender;
  }

  // Method to get all patient data as a model
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
      occupation: occupationController.text,
      maritalStatus: maritalStatusController.text,
      disabilityID: disabilityIDController.text,
      educationOfPatient: educationOfPatientController.text,
      bloodGroup: bloodGroupController.text,
      educationOfGuardian: educationOfGuardianController.text,
      guardianName: guardianNameController.text,
      birthRegistrationNo: birthRegistrationNoController.text,
      sex: sexController.text,
    );
  }
Future<void> selectDateOfBirth(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: themeController.isDay.value
                ? QuickTechAppColors.lightmaincolor
                : QuickTechAppColors.darkmaincolor,
            onPrimary: Colors.white, // Header text color
            surface: themeController.isDay.value
                ? QuickTechAppColors.lightScaffoldColor
                : QuickTechAppColors.darkScaffoldColor,
            onSurface: themeController.isDay.value?QuickTechAppColors.lightmaintextcolor:QuickTechAppColors.darkmaintextcolor, 
         
          ), dialogTheme: DialogThemeData(backgroundColor: themeController.isDay.value
              ? Colors.white
              : QuickTechAppColors.black),
      
       
      ), child: child!,);
    },
  );

  if (pickedDate != null) {
    String formattedDate = dateFormat(pickedDate);
    updateBirthDate(formattedDate);
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
