import 'dart:convert';

import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/services/quick_tech_retry_service.dart';
import 'package:http/http.dart' as http;

class QuickTechFamilyHistoryController extends GetxController {
  // Function to clear all family history fields
  void clearFamilyHistory() {
    homeenvitornmentController.clear();
    noofChildrenController.clear();
    lactateConditionController.clear();
    firstCousinMarrigeController.clear();
    anydisablepersonController.clear();
    psychologicalConditionController.clear();
    homeEnvironment.value = null;
    noofChildren.value = null;
    lactateCondition.value = null;
    firstcousinMarriage.value = null;
    anydisableperson.value = null;
    psychologicalCondition.value = null;
    update();
  }
  // Store family history to API
  Future<int> storeFamilyHistory({required int patientId}) async {
    final token = QuickTechAuthStorageService.getToken();
    final url = Uri.parse('${Api.baseUrl}/api/family/history/update');
    final body = {
      'patient_id': patientId,
      'home_environment': homeEnvironment.value,
      'no_of_children': noofChildren.value,
      'lactate_condition': lactateCondition.value,
      'other_disabled_person': anydisableperson.value,
      'psychological_condition': psychologicalCondition.value,
      'first_cousin_marriage': firstcousinMarriage.value,
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
      print('Family history status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response.statusCode ;
    } catch (e) {
      print('Error storing family history: $e');
      return 500;
    }
  }
  // TextEditingControllers for Occupational History
  TextEditingController homeenvitornmentController = TextEditingController();
  TextEditingController noofChildrenController = TextEditingController();
  TextEditingController lactateConditionController = TextEditingController();
  TextEditingController firstCousinMarrigeController = TextEditingController();
  TextEditingController anydisablepersonController = TextEditingController();
  TextEditingController psychologicalConditionController =
      TextEditingController();

  // Observable variables for dropdowns in Occupational History
  var homeEnvironment = Rx<String?>(null);
  var noofChildren = Rx<String?>(null);
  var lactateCondition = Rx<String?>(null);
  var firstcousinMarriage = Rx<String?>(null);
  var anydisableperson = Rx<String?>(null);
  var psychologicalCondition = Rx<String?>(null);

  var homeEnvironmentOptions =
      [
        'Slum area',
        'Poor housing ',
        'Moderate housing',
        'Ultra poor housing',
        'Rich housing',
      ].obs;
  var noofChildrenoptions = ['1', '2','3','4','5','6'].obs;
  var lactateOptions = ['Yes', 'No',].obs;
  var cousinMarriageOptions = ['Yes', 'No'].obs;
  var disbaledpersonoptions = ['Yes', 'No'].obs;
  var psycologyOptions = ['Severe type', 'Mild type'].obs;
  bool isFamilyHistorynull() {
  return (homeEnvironment.value?.isEmpty ?? true) &&
         (noofChildren.value?.isEmpty ?? true) &&
         (lactateCondition.value?.isEmpty ?? true) &&
         (firstcousinMarriage.value?.isEmpty ?? true) &&
         (anydisableperson.value?.isEmpty ?? true) &&
         (psychologicalCondition.value?.isEmpty ?? true);
}

  bool isFamilyHistoryNull() {
    return homeEnvironment.value != null ||
        noofChildren.value != null ||
        lactateCondition.value != null ||
        firstcousinMarriage.value != null ||
        anydisableperson.value != null ||
        psychologicalCondition.value != null;
  }
  /// Standardized: returns true when section has data to display
  bool hasData() => isFamilyHistoryNull();

  void updateHomeEnvironment(String environment) {
    homeEnvironment.value = environment;
    homeenvitornmentController.text = environment;
  }

  void updatenoofchildren(String children) {
    noofChildren.value = children;
    noofChildrenController.text = children;
  }

  void updateLactate(String lactate) {
    lactateCondition.value = lactate;
    lactateConditionController.text = lactate;
  }

  void updateCousinMarriage(String marriage) {
    firstcousinMarriage.value = marriage;
    firstCousinMarrigeController.text = marriage;
  }

  void updateDisabaled(String disabled) {
    anydisableperson.value = disabled;
    anydisablepersonController.text = disabled;
  }

  void updatedPsychologicalCondition(String? psychologicalCoondition) {
    if(psychologicalCoondition!=null){
      psychologicalCondition.value=psychologicalCoondition;
      psychologicalConditionController.text=psychologicalCoondition;
      if(!psycologyOptions.contains(psychologicalCoondition)){
        psycologyOptions.add(psychologicalCoondition);
      }
    }

  }


  void clearForm() {
    homeenvitornmentController.clear();
    noofChildrenController.clear();
    lactateConditionController.clear();
    firstCousinMarrigeController.clear();
    anydisablepersonController.clear();
    psychologicalConditionController.clear();
  }
}
