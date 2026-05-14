import 'dart:convert';

import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/services/quick_tech_retry_service.dart';
import 'package:http/http.dart' as http;

class QuickTechOccupationHistoryController extends GetxController {

  
bool _isSaving = false;

Future<int> storeOccupationHistory({required int patientId}) async {
  if (_isSaving) {
    print("Already saving — blocked duplicate call");
    return 0;
  }

  _isSaving = true;

  try {
    final token = QuickTechAuthStorageService.getToken();
    final url = Uri.parse('${Api.baseUrl}/api/occupation/history/update');

    final body = {
      'patient_id': patientId,
      'type_of_work': typeOfWorkController.text,
      'stair_moving': stairMovingController.text,
      'lumbar_involvement': lumbarInvolvementController.text,
      'brain_work': brainWorkController.text,
    };

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final response = await retryRequest(() => http.post(
          url,
          body: jsonEncode(body),
          headers: headers,
        ));

    print('Occupation history status: ${response.statusCode}');
    return response.statusCode;
  } catch (e) {
    print('Error storing occupation history: $e');
    return 500;
  } finally {
    _isSaving = false;
  }
}
  // TextEditingControllers for Occupational History
  TextEditingController typeOfWorkController = TextEditingController();
  TextEditingController stairMovingController = TextEditingController();
  TextEditingController lumbarInvolvementController = TextEditingController();
  TextEditingController brainWorkController = TextEditingController();

  // Observable variables for dropdowns in Occupational History
  var typeOfWork = Rx<String?>(
    null,
  ); // Changed initial value to match an existing option
  var stairMoving = Rx<String?>(null);
  var lumbarInvolvement = Rx<String?>(null);
  var brainWork = Rx<String?>(null);

  var typesofworkoptions =
      [
        'Long standing',
        'Long sitting',
        'Long driving',
        'All time moving',
        'Others',
      ].obs;
  var stairMOvingoptions = ['Yes', 'No'].obs;
  var lumbarInvolvementoptions = ['Always', 'Mild ', 'Moderate'].obs;
  var brainWorkoption = ['Severe type', 'Mild type'].obs;
  bool isOccupationHistorynull() {
    return (typeOfWork.value?.isEmpty ?? true) &&
        (stairMoving.value?.isEmpty ?? true) &&
        (lumbarInvolvement.value?.isEmpty ?? true) &&
        (brainWork.value?.isEmpty ?? true);
  }
  bool isOccupationHistoryNull() {
    return typeOfWork.value != null ||
        lumbarInvolvement.value != null ||
        brainWork.value != null ||
        stairMoving.value != null;
  }
  /// Standardized: returns true when section has data to display
  bool hasData() => isOccupationHistoryNull();

  void updateTypesofWork(String? work) {
    if(work !=null){
      typeOfWork.value=work;
      typeOfWorkController.text=work;
      if(!typesofworkoptions.contains(work)){
        typesofworkoptions.add(work);
      }
    }

  }

  void updateStairMoving(String moving) {
    stairMoving.value = moving;
    stairMovingController.text = moving;
  }

  void updatelumberInvolvemnt(String involvement) {
    lumbarInvolvement.value = involvement;
    lumbarInvolvementController.text = involvement;
  }

  void updatebrainWork(String brainworks) {
    brainWork.value = brainworks;
    brainWorkController.text = brainworks;
  }

  // Method to clear all controllers (optional, for resetting form data)
  void clearForm() {
    typeOfWorkController.clear();
    stairMovingController.clear();
    lumbarInvolvementController.clear();
    brainWorkController.clear();
  }

  // Method to get all Occupational History data as a model (optional)
  Map<String, dynamic> getFormData() {
    return {
      'typeOfWork': typeOfWorkController.text,
      'stairMoving': stairMovingController.text,
      'lumbarInvolvement': lumbarInvolvementController.text,
      'brainWork': brainWorkController.text,
    };
  }
  void clearOccupationHistory() {
    typeOfWorkController.clear();
    stairMovingController.clear();
    lumbarInvolvementController.clear();
    brainWorkController.clear();
    typeOfWork.value = null;
    stairMoving.value = null;
    lumbarInvolvement.value = null;
    brainWork.value = null;
    update();
  }
}
