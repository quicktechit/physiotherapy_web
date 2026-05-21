

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
    debugPrint("Already saving — blocked duplicate call");
    return 0;
  }
  _isSaving = true;

  try {
    final token = QuickTechAuthStorageService.getToken();

    final fields = {
      'patient_id': patientId.toString(),
      'type_of_work': typeOfWork.value ?? '',       // ✅ Rx value
      'stair_moving': stairMoving.value ?? '',      // ✅ Rx value
      'lumbar_involvement': lumbarInvolvement.value ?? '', // ✅ Rx value
      'brain_work': brainWork.value ?? '',          // ✅ Rx value
    };

    debugPrint("📤 Occupation History Request: $fields");

    final response = await retryRequest(() async {
      final r = http.MultipartRequest(
        'POST',
        Uri.parse('${Api.baseUrl}/api/occupation/history/update'),
      );
      r.headers['Authorization'] = 'Bearer $token';
      r.fields.addAll(fields);
      return http.Response.fromStream(await r.send());
    });

    debugPrint("📥 Response [${response.statusCode}]: ${response.body}");
    return response.statusCode;
  } catch (e, stack) {
    debugPrint("❌ Error: $e\n$stack");
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

  void updateTypesofWork(dynamic work) {
    if(work != null){
      typeOfWork.value = work;
      // do NOT set typeOfWorkController.text — it resets cursor on web
      if(!typesofworkoptions.contains(work)){
        typesofworkoptions.add(work);
      }
    }
  }

  void updateStairMoving(String moving) {
    stairMoving.value = moving;
    // do NOT set stairMovingController.text — it resets cursor on web
  }

  void updatelumberInvolvemnt(String involvement) {
    lumbarInvolvement.value = involvement;
    // do NOT set lumbarInvolvementController.text — it resets cursor on web
  }

  void updatebrainWork(String brainworks) {
    brainWork.value = brainworks;
    // do NOT set brainWorkController.text — it resets cursor on web
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
