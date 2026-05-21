import 'dart:convert';

import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/services/quick_tech_retry_service.dart';
import 'package:http/http.dart' as http;

class QuickTechMotherHealthController extends GetxController {
  // Function to clear all mother health fields
  void clearMotherHealth() {
    bloodPressureController.clear();
    diabetesController.clear();
    gestationalDiabetesController.clear();
    preeclampsiaController.clear();
    infectionController.clear();
    bleedingController.clear();
    anxietyController.clear();
    bloodPressure.value = null;
    diabetes.value = null;
    gestationalDiabetes.value = null;
    preeclampsia.value = null;
    infection.value = null;
    bleeding.value = null;
    anxiety.value = null;
    update();
  }
  // Store mother health condition during pregnancy to API
  Future<int> storeMotherHealthCondition({required int patientId}) async {
    final token = QuickTechAuthStorageService.getToken();
    final url = Uri.parse('${Api.baseUrl}/api/mother-pregnancy/health/update');
    final body = {
      'patient_id': patientId,
      'blood_pressure': bloodPressure.value,
      'diabetes_mellitus': diabetes.value,
      'gestational_diabetes': gestationalDiabetes.value,
      'preeclampsia': preeclampsia.value,
      'infection': infection.value,
      'bleeding': bleeding.value,
      'anxiety_or_stress': anxiety.value,
    };
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      final response = await retryRequest(() => http.post(
            url,
            body: jsonEncode(body),
            headers: headers,
          ));
      print('Mother health status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response.statusCode;
    } catch (e) {
      print('Error storing mother health condition: $e');
      return 500;
    }
  }
  // TextEditingControllers (If needed for extra details)
  TextEditingController bloodPressureController = TextEditingController();
  TextEditingController diabetesController = TextEditingController();
  TextEditingController gestationalDiabetesController = TextEditingController();
  TextEditingController preeclampsiaController = TextEditingController();
  TextEditingController infectionController = TextEditingController();
  TextEditingController bleedingController = TextEditingController();
  TextEditingController anxietyController = TextEditingController();

  // Observable variables for dropdowns in Mother Health Condition
  var bloodPressure = Rx<String?>(null);
  var diabetes = Rx<String?>(null);
  var gestationalDiabetes = Rx<String?>(null);
  var preeclampsia = Rx<String?>(null);
  var infection = Rx<String?>(null);
  var bleeding = Rx<String?>(null);
  var anxiety = Rx<String?>(null);

  // Options for dropdowns
  var bloodPressureOptions = ['High', 'Low', 'Others'].obs;
  var diabetesOptions = ['Yes', 'No', 'Gestational Diabetes'].obs;
  var preeclampsiaOptions = ['Yes', 'No'].obs;
  var infectionOptions = ['Yes', 'No'].obs;
  var bleedingOptions = ['Present', 'Absent'].obs;
  var anxietyOptions = ['Present', 'Absent'].obs;
  bool isMotherHealthnull() {
  return (bloodPressure.value?.isEmpty ?? true) &&
         (diabetes.value?.isEmpty ?? true) &&
         (gestationalDiabetes.value?.isEmpty ?? true) &&
         (preeclampsia.value?.isEmpty ?? true) &&
         (infection.value?.isEmpty ?? true) &&
         (bleeding.value?.isEmpty ?? true) &&
         (anxiety.value?.isEmpty ?? true);
}

bool isMotherHealthNull(){
  return bloodPressure.value!=null||
  diabetes.value!=null||
  gestationalDiabetes.value!=null||
  preeclampsia.value!=null||
  infection.value!=null||
  bleeding.value!=null||
  anxiety.value!=null;
}
  /// Standardized: returns true when section has data to display
  bool hasData() => isMotherHealthNull();
  // Update functions for each field
  void updateBloodPressure(dynamic pressure) {
    if(pressure!=null){
      bloodPressure.value = pressure;
      // do NOT set bloodPressureController.text — it resets cursor on web
    }
    if(!bloodPressureOptions.contains(pressure)){
    bloodPressureOptions.add(pressure!);
    }
  }

  void updateDiabetes(String diabetesType) {
    diabetes.value = diabetesType;
    // do NOT set diabetesController.text — it resets cursor on web
  }

  void updateGestationalDiabetes(String condition) {
    gestationalDiabetes.value = condition;
    // do NOT set gestationalDiabetesController.text — it resets cursor on web
  }

  void updatePreeclampsia(String condition) {
    preeclampsia.value = condition;
    // do NOT set preeclampsiaController.text — it resets cursor on web
  }

  void updateInfection(String infectionStatus) {
    infection.value = infectionStatus;
    // do NOT set infectionController.text — it resets cursor on web
  }

  void updateBleeding(String bleedingStatus) {
    bleeding.value = bleedingStatus;
    // do NOT set bleedingController.text — it resets cursor on web
  }

  void updateAnxiety(String anxietyStatus) {
    anxiety.value = anxietyStatus;
    // do NOT set anxietyController.text — it resets cursor on web
  }

  // Method to clear all controllers (optional, for resetting form data)
  void clearForm() {
    bloodPressureController.clear();
    diabetesController.clear();
    gestationalDiabetesController.clear();
    preeclampsiaController.clear();
    infectionController.clear();
    bleedingController.clear();
    anxietyController.clear();
  }
}
