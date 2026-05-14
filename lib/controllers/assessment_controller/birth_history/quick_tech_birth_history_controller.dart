import 'dart:convert';

import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/services/quick_tech_retry_service.dart';

import 'package:http/http.dart' as http;

class QuickTechBirthHistoryController extends GetxController {
  // Function to clear all birth history fields
  void clearBirthHistory() {
    birthInjuryController.clear();
    birthWeightController.clear();
    complicationController.clear();
    pregnancyMaturityController.clear();
    deliveryTypeController.clear();
    deliveryPlaceController.clear();
    noOfLaborController.clear();
    laborDurationController.clear();
    childPositionController.clear();
    afterBirthProblemController.clear();
    birthInjury.value = null;
    birthWeight.value = null;
    complication.value = null;
    pregnancyMaturity.value = null;
    deliveryType.value = null;
    deliveryPlace.value = null;
    noOfLabor.value = null;
    laborDuration.value = null;
    childPosition.value = null;
    afterBirthProblem.value = null;
    update();
  }
  // Store birth history to API
  Future<int> storeBirthHistory({required int patientId}) async {
    final token = QuickTechAuthStorageService.getToken();
    final url = Uri.parse('${Api.baseUrl}/api/birth/history/update');
    final body = {
      'patient_id': patientId,
      'birth_injury': birthInjury.value,
      'birth_weight': birthWeight.value,
      'complication_during_delivery': complication.value,
      'pregnancy_maturity': pregnancyMaturity.value,
      'delivery_type': deliveryType.value,
      'delivery_place': deliveryPlace.value,
      'no_of_labor': noOfLabor.value,
      'duration_of_labor': laborDuration.value,
      'child_position': childPosition.value,
      'after_birth_problem': afterBirthProblem.value,
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
      print('Birth history status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response.statusCode;
    } catch (e) {
      print('Error storing birth history: $e');
      return 500;
    }
  }
  // TextEditingControllers for Birth History
  TextEditingController birthInjuryController = TextEditingController();
  TextEditingController birthWeightController = TextEditingController();
  TextEditingController complicationController = TextEditingController();
  TextEditingController pregnancyMaturityController = TextEditingController();
  TextEditingController deliveryTypeController = TextEditingController();
  TextEditingController deliveryPlaceController = TextEditingController();
  TextEditingController noOfLaborController = TextEditingController();
  TextEditingController laborDurationController = TextEditingController();
  TextEditingController childPositionController = TextEditingController();
  TextEditingController afterBirthProblemController = TextEditingController();

  // Observable variables for dropdowns in Birth History
  var birthInjury = Rx<String?>(null);  
  var birthWeight = Rx<String?>(null);  
  var complication = Rx<String?>(null); 
  var pregnancyMaturity = Rx<String?>(null);
  var deliveryType = Rx<String?>(null);  
  var deliveryPlace = Rx<String?>(null); 
  var noOfLabor = Rx<String?>(null); 
  var laborDuration = Rx<String?>(null); 
  var childPosition = Rx<String?>(null); 
  var afterBirthProblem = Rx<String?>(null); 

  // Options for dropdowns
  var birthInjuryOptions = ['Yes', 'No'].obs;
  var birthWeightOptions = ['Underweight', 'Overweight','Others'].obs;
  var complicationOptions = ['Yes', 'No'].obs;
  var pregnancyMaturityOptions = ['Matured', 'Immature', 'Overtime'].obs;
  var deliveryTypeOptions = ['Normal', 'Caesarian'].obs;
  var deliveryPlaceOptions = ['Home', 'Hospital/Clinic', 'Maternity Centre'].obs;
  var childPositionOptions = ['Breach', 'Normal'].obs;
  var afterBirthProblemOptions = ['Jaundice', 'Pneumonia', 'Others'].obs;
  var laborDurationOptions= ['1', '2', '3', '4', '5','Others'].obs;
  bool isBirthHIstorynull() {
  return (birthInjury.value?.isEmpty ?? true) &&
      (birthWeight.value?.isEmpty ?? true) &&
      (complication.value?.isEmpty ?? true) &&
      (pregnancyMaturity.value?.isEmpty ?? true) &&
      (deliveryType.value?.isEmpty ?? true) &&
      (deliveryPlace.value?.isEmpty ?? true) &&
      (noOfLabor.value?.isEmpty ?? true) &&
      (laborDuration.value?.isEmpty ?? true) &&
      (childPosition.value?.isEmpty ?? true) &&
      (afterBirthProblem.value?.isEmpty ?? true);
}

bool isBirthHIstoryNull(){
  return birthInjury.value!=null||
  birthWeight.value!=null||
  complication.value!=null||
  pregnancyMaturity.value!=null||
  deliveryType.value!=null||
  deliveryPlace.value!=null||
  noOfLabor.value!=null||
  laborDuration.value!=null||
  childPosition.value!=null||
  afterBirthProblem.value!=null;
}
  /// Standardized: returns true when section has data to display
  bool hasData() => isBirthHIstoryNull();
  // Update functions
  void updateBirthInjury(String injury) {
    birthInjury.value = injury;
    birthInjuryController.text = injury;
  }

  void updateBirthWeight(String? weight) {
    if(weight!=null){
      birthWeight.value=weight;
      birthWeightController.text=weight;
      if(!birthWeightOptions.contains(weight)){
        birthWeightOptions.add(weight);
      }
    }

  }

  void updateComplication(String complications) {
    complication.value = complications;
    complicationController.text = complications;
  }

  void updatePregnancyMaturity(String maturity) {
    pregnancyMaturity.value = maturity;
    pregnancyMaturityController.text = maturity;
  }

  void updateDeliveryType(String type) {
    deliveryType.value = type;
    deliveryTypeController.text = type;
  }

  void updateDeliveryPlace(String place) {
    deliveryPlace.value = place;
    deliveryPlaceController.text = place;
  }

  void updateNoOfLabor(String labor) {
    noOfLabor.value = labor;
    noOfLaborController.text = labor;
  }

  void updateLaborDuration(String? duration) {
   if(duration!=null){
     laborDuration.value = duration;
    laborDurationController.text = duration;
   }
   if(!laborDurationOptions.contains(duration))
   laborDurationOptions.add(duration!);
  }

  void updateChildPosition(String position) {
    childPosition.value = position;
    childPositionController.text = position;
  }

  void updateAfterBirthProblem(String? problem) {
    if(problem !=null){
      afterBirthProblem.value = problem;
    afterBirthProblemController.text = problem;

    }
    if(!afterBirthProblemOptions.contains(problem)){
      afterBirthProblemOptions.add(problem!);
    }
  }


  void clearForm() {
    birthInjuryController.clear();
    birthWeightController.clear();
    complicationController.clear();
    pregnancyMaturityController.clear();
    deliveryTypeController.clear();
    deliveryPlaceController.clear();
    noOfLaborController.clear();
    laborDurationController.clear();
    childPositionController.clear();
    afterBirthProblemController.clear();
  }


  // Can create a model for BirthHistoryData and return it here
}
