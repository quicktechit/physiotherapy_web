import 'dart:convert';

import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:e_prescription/services/quick_tech_patient_draft_storage_service.dart';
class Patient {
  final int userId;
  final int? id; 
  final String name;
  final String? age;
  final String? gender;
  final String phone;
  final String? prescriptionDate;

  Patient({
    required this.userId,
    this.id,
    required this.name,
     this.age,
     this.gender,
    required this.phone,
     this.prescriptionDate,
  });
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      userId: json['user_id'],
      id: json['id'],
      name: json['name'],
      age: json['age'] ?? '',
      gender: json['gender'] ?? '',
      phone: json['phone'] ,
      prescriptionDate: json['prescription_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId, 
      "name": name,
      "age": age,
      "gender": gender,
      "phone": phone,
      "prescription_date": prescriptionDate,
    };
  }
}


class PatientInfoController extends GetxController {
  var patientName = ''.obs;
  var age = ''.obs;
  var gender = ''.obs;
  var phone = ''.obs;
  var patientId = 0.obs;
  Rx<DateTime?> date = Rx<DateTime?>(null);
  
  // Initialize directly to avoid late initialization errors
  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dateContoller = TextEditingController();

  final RxBool isSaving = false.obs;
  DateTime? _cooldownUntil;

  bool get isInCooldown {
    final until = _cooldownUntil;
    return until != null && DateTime.now().isBefore(until);
  }

  int get cooldownSecondsRemaining {
    final until = _cooldownUntil;
    if (until == null) return 0;
    final diff = until.difference(DateTime.now()).inSeconds;
    return diff > 0 ? diff : 0;
  }

  @override
  void onInit() {
    super.onInit();
    
    // Sync RxString with TextEditingController
    ever(patientName, (value) => patientNameController.text = value);
    ever(age, (value) => ageController.text = value);
    ever(phone, (value) => phoneController.text = value);
    ever(gender, (value) => genderController.text = value);
    
    clearAllData();
  }

  @override
  void onClose() {
    patientNameController.dispose();
    ageController.dispose();
    phoneController.dispose();
    genderController.dispose();
    dateContoller.dispose();
    super.onClose();
  }


Future<int> updatePatientInfo(int userId) async {

  if (isSaving.value) {
    // Prevent double-tap / parallel submits.
    return 429;
  }

  if (isInCooldown) {
    final secs = cooldownSecondsRemaining;
    Get.snackbar(
      'Too Many Attempts',
      secs > 0 ? 'Please wait ${secs}s and try again.' : 'Please wait and try again.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
    return 429;
  }

  isSaving.value = true;

  try {
    final token = QuickTechAuthStorageService.getFreshToken();
    if (token == null || token.isEmpty) {
      Get.snackbar(
        "Authentication Error",
        "User is not authenticated. Please log in again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return 401;
    }

    if (patientName.value.isEmpty ||
       
        phone.value.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return 400;
    }


    final DateTime usedDate = date.value ?? DateTime.now();

    String formattedDate = "${usedDate.year}-${usedDate.month}-${usedDate.day}";

    Patient patient = Patient(
      userId: userId,
      name: patientName.value,
      age: age.value,
      gender: gender.value,
      phone: phone.value,
      prescriptionDate: formattedDate,
    );

    final response = await http.post(
      Uri.parse(Api.updatePrescriptionPatientInfo),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(patient.toJson()),
    );

    if (response.statusCode == 429) {
      final retryAfterHeader = response.headers['retry-after'];
      final retryAfterSeconds = int.tryParse(retryAfterHeader ?? '');
      final seconds = (retryAfterSeconds != null && retryAfterSeconds > 0)
          ? retryAfterSeconds
          : 10;
      _cooldownUntil = DateTime.now().add(Duration(seconds: seconds));
      Get.snackbar(
        'Too Many Attempts',
        'Please wait ${seconds}s and try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return 429;
    }

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Get.snackbar("Success", data['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);

      var returnedPatient = data['patient'];
      patientId.value = returnedPatient['id'] ?? 0;
      patientName.value = returnedPatient['name'];
      age.value = returnedPatient['age'] ?? '';
      gender.value = returnedPatient['gender'] ?? '';
      phone.value = (returnedPatient['phone'] ).toString();

      // Update controllers
      patientNameController.text = returnedPatient['name'];
      ageController.text = returnedPatient['age'] ?? '';
      genderController.text = returnedPatient['gender'] ?? '';
      phoneController.text = (returnedPatient['phone'] ).toString();

      try {
        date.value = DateFormat('yyyy-M-d').parseStrict(returnedPatient['prescription_date']);
      } catch (_) {
        date.value = null;
      }
      dateContoller.text = returnedPatient['prescription_date'];
      return response.statusCode;
    } else if (response.statusCode == 401) {
      await QuickTechAuthStorageService.handleUnauthorized();
      return response.statusCode;
    } else {
      Get.snackbar(
        "Error",
        "Failed to update patient",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return response.statusCode;
    }
  } catch (e) {
    print("Exception: $e");
    Get.snackbar(
      "Error",
      "Something went wrong",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return 500;
  } finally {
    isSaving.value = false;
  }
}
void clearAllData() {
  patientName.value = '';
  age.value = '';
  gender.value = '';
  phone.value = '';
  patientId.value = 0;
  date.value = null;
  
  patientNameController.clear();
  ageController.clear();
  phoneController.clear();
  genderController.clear();
  dateContoller.clear();
}

  Future<void> prefillFromAssessmentDraft({bool clearAfterLoad = true}) async {
    final draft = QuickTechPatientDraftStorageService.readDraft();
    if (draft == null) return;

    // Only prefill if user hasn't typed yet.
    if (patientName.value.trim().isEmpty) {
      patientName.value = draft.name;
    }
    if (phone.value.trim().isEmpty) {
      phone.value = draft.phone;
    }

    if (clearAfterLoad) {
      await QuickTechPatientDraftStorageService.clearDraft();
    }
  }

// Keeping the old method for backward compatibility
void ClearTextFields() {
  clearAllData();
}
}
