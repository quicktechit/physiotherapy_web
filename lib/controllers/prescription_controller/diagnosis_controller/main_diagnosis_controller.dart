import 'dart:convert';
import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/diagnosis_controller.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/cheif_complain_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/on_examination_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/radiological_findings_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/primary_medical_history_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/drug_history_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/assestive_device_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/referred_to_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/disability_types_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/previous_therapy_Controller.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/optimized_advice_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/patient_info_controller/patient_info_controller.dart';
import 'package:e_prescription/locator.dart';

// Models
class PresDiagnosisChildcategory {
  final int id;
  final String diagnosisCategoryId;
  final String diagnosisSubcategoryId;
  final String type;
  final String name;
  final String createdAt;
  final String updatedAt;

  PresDiagnosisChildcategory({
    required this.id,
    required this.diagnosisCategoryId,
    required this.diagnosisSubcategoryId,
    required this.type,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PresDiagnosisChildcategory.fromJson(Map<String, dynamic> json) {
    return PresDiagnosisChildcategory(
      id: json['id'],
      diagnosisCategoryId: json['diagnosis_category_id'],
      diagnosisSubcategoryId: json['diagnosis_subcategory_id'],
      type: json['type'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class PresDiagnosisSubcategory {
  final int id;
  final String diagnosisCategoryId;
  final String type;
  final String name;
  final String createdAt;
  final String updatedAt;
  final List<PresDiagnosisChildcategory> diagnosisChildcategories;

  PresDiagnosisSubcategory({
    required this.id,
    required this.diagnosisCategoryId,
    required this.type,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.diagnosisChildcategories,
  });

  factory PresDiagnosisSubcategory.fromJson(Map<String, dynamic> json) {
    var childList = json['diagnosis_childcategories'] as List?;
    List<PresDiagnosisChildcategory> children =
        childList != null
            ? childList.map((e) => PresDiagnosisChildcategory.fromJson(e)).toList()
            : [];
    return PresDiagnosisSubcategory(
      id: json['id'],
      diagnosisCategoryId: json['diagnosis_category_id'],
      type: json['type'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      diagnosisChildcategories: children,
    );
  }
}

// Place addDiagnosisItems and related helpers here, outside the model classes


class PresDiagnosisCategory {
  final int id;
  final String name;
  final String createdAt;
  final String updatedAt;
  final List<PresDiagnosisSubcategory> diagnosisSubcategories;

  PresDiagnosisCategory({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.diagnosisSubcategories,
  });

  factory PresDiagnosisCategory.fromJson(Map<String, dynamic> json) {
    var subList = json['diagnosis_subcategories'] as List?;
    List<PresDiagnosisSubcategory> subs =
        subList != null
            ? subList.map((e) => PresDiagnosisSubcategory.fromJson(e)).toList()
            : [];
    return PresDiagnosisCategory(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      diagnosisSubcategories: subs,
    );
  }
}

// Controller
class MainDiagnosisController extends ChangeNotifier {
  List<PresDiagnosisCategory> diagnosisCategories = [];
  bool isLoading = false;
  String? error;

  Future<int> storeAllDiagnosisData() async {
    debugPrint('>>> DIAGNOSIS STORE CALLED [${DateTime.now().toString()}]');
    try {
      final cheifComplainController = locator.get<CheifComplainController>();
      final onExaminationController = locator.get<OnExaminationController>();
      final radiologicalFindingsController = locator.get<RadiologicalFindingsController>();
      final primaryMedicalHistoryController = locator.get<PrimaryMedicalHistoryController>();
      final drugHistoryController = locator.get<DrugHistoryController>();
      final assistiveDeviceController = locator.get<AssestiveDeviceController>();
      final referredToController = locator.get<ReferredToController>();
      final disabilityTypesController = locator.get<DisabilityTypesController>();
      final diagnosisController = locator.get<DiagnosisController>();

    
      String _valueOrEmpty(dynamic value) {
        if (value == null) return '';
        if (value is String) return value;
        return value.toString();
      }

   void appendDiagnosisEntry(
  List<String> targetIds,
  Map<String, dynamic> source,
  List<String> subcategoryValues,
  List<String> durations,
  List<String> frequencies,
  List<String> leftRights, {
  bool isChild = false,
  OnExaminationController? onExaminationController,
  String? itemName,
}) {
  final id = source['id'];
  if (id == null) return;
  targetIds.add(id.toString());

  // Children only add their ID to diagChildcatIds - no positional arrays
  if (isChild) return;

  String? value;

  if (onExaminationController != null && itemName != null) {
    final map = onExaminationController.onExaminationMap[itemName];
    debugPrint('DEBUG appendDiagnosisEntry: itemName=$itemName | map exists=${map != null} | type=${map?['type']}');
    if (map != null && map['type'] == 'With Value') {
      final rxString = onExaminationController.examinationValues[itemName];
      debugPrint('DEBUG: Got RxString for $itemName | exists=${rxString != null} | value="${rxString?.value}"');
      if (rxString != null && rxString.value.isNotEmpty) {
        value = rxString.value;
        debugPrint('DEBUG: Setting value to "${rxString.value}" for $itemName');
      }
    }
  } else {
    // only take subcategory_value when it’s present
    if (source['subcategory_value'] != null &&
        source['subcategory_value'].toString().isNotEmpty) {
      value = source['subcategory_value'].toString();
    }
  }

  // Always add a value (empty string if none) to maintain array alignment
  subcategoryValues.add(value ?? '');

  // Always add duration/frequency/left_right to maintain array alignment
  String duration = _valueOrEmpty(source['duration']);
  String frequency = _valueOrEmpty(source['frequency']);
  String leftRight = _valueOrEmpty(source['left_right']);
  
  durations.add(duration);
  frequencies.add(frequency);
  leftRights.add(leftRight);
}

      void addDiagnosisItems(
        Iterable<String> selectedItems,
        Map<String, Map<String, dynamic>> dataMap,
        Map<String, List<String>> subMap,
        List<String> diagSubcatIds,
        List<String> diagChildcatIds,
        List<String> subcategoryValues,
        List<String> durations,
        List<String> frequencies,
        List<String> leftRights,
        {OnExaminationController? onExaminationController}
      ) {
        if (selectedItems.isEmpty) return;

        for (final item in selectedItems) {
          final subcategoryData = dataMap[item];
          if (subcategoryData == null) {
            // This is likely a custom entry - it will be sent via customNewComplaints
            continue;
          }

          appendDiagnosisEntry(
            diagSubcatIds,
            subcategoryData,
            subcategoryValues,
            durations,
            frequencies,
            leftRights,
            onExaminationController: onExaminationController,
            itemName: item,
          );

          final childSelections = subMap[item] ?? const <String>[];
          if (childSelections.isEmpty) continue;

          final children =
              (subcategoryData['children'] as List?)?.cast<Map<String, dynamic>>();
          if (children == null || children.isEmpty) continue;

          for (final childName in childSelections) {
            Map<String, dynamic>? childData;
            for (final child in children) {
              if (child['name'] == childName) {
                childData = child;
                break;
              }
            }
            if (childData == null) continue;

            appendDiagnosisEntry(
              diagChildcatIds,
              childData,
              subcategoryValues,
              durations,
              frequencies,
              leftRights,
              isChild: true,
            );
          }
        }
      }

      // Prepare arrays for bulk data
      List<String> diagSubcatIds = [];
      List<String> diagChildcatIds = [];
      List<String> subcategoryValues = [];
      List<String> durations = [];
      List<String> frequencies = [];
      List<String> leftRights = [];

      // chiefComplaintCategory is Rxn<PresDiagnosisCategory>, so use .value
      final chiefComplaintMap = <String, Map<String, dynamic>>{};
      final chiefCategory =
          cheifComplainController.chiefComplaintCategory.value;
      if (chiefCategory != null) {
        for (final sub in chiefCategory.diagnosisSubcategories) {
          chiefComplaintMap[sub.name] = {
            'id': sub.id,
            'children':
                sub.diagnosisChildcategories
                    .map(
                      (child) => {
                        'id': child.id,
                        'name': child.name,
                      },
                    )
                    .toList(),
          };
        }
      }
      addDiagnosisItems(
        cheifComplainController.selectedComplaints,
        chiefComplaintMap,
        cheifComplainController.selectedSubComplaints,
        diagSubcatIds,
        diagChildcatIds,
        subcategoryValues,
        durations,
        frequencies,
        leftRights,
      );
      // DEBUG: Log On Examination state
      debugPrint('=== ON EXAMINATION DEBUG ===');
      debugPrint('selectedExaminations: ${onExaminationController.selectedExaminations}');
      debugPrint('examinationValues: ${onExaminationController.examinationValues}');
      for (var exam in onExaminationController.selectedExaminations) {
        final examData = onExaminationController.onExaminationMap[exam];
        debugPrint('Exam: $exam | Type: ${examData?['type']} | Value: ${onExaminationController.examinationValues[exam]?.value}');
      }
      
      addDiagnosisItems(
        onExaminationController.selectedExaminations,
        onExaminationController.onExaminationMap,
        onExaminationController.selectedSubExaminations,
        diagSubcatIds,
        diagChildcatIds,
        subcategoryValues,
        durations,
        frequencies,
        leftRights,
        onExaminationController: onExaminationController,
      );
      addDiagnosisItems(
        radiologicalFindingsController.selectedRadioLogicalFindings,
        radiologicalFindingsController.radiologicalFindingsMap,
        radiologicalFindingsController.selectedsubRadiologicalFindings,
        diagSubcatIds,
        diagChildcatIds,
        subcategoryValues,
        durations,
        frequencies,
        leftRights,
      );
      addDiagnosisItems(
        primaryMedicalHistoryController.selectedMedicalHistory,
        primaryMedicalHistoryController.medicalHistoryMap,
        primaryMedicalHistoryController.selectedsubMedicalHistory,
        diagSubcatIds,
        diagChildcatIds,
        subcategoryValues,
        durations,
        frequencies,
        leftRights,
      );
      addDiagnosisItems(
        drugHistoryController.selectedDrugHistory,
        drugHistoryController.drugHistoryMap,
        drugHistoryController.selectedsubDrugHistory,
        diagSubcatIds,
        diagChildcatIds,
        subcategoryValues,
        durations,
        frequencies,
        leftRights,
      );
      addDiagnosisItems(
        assistiveDeviceController.selectedAssestiveDevice,
        assistiveDeviceController.assestiveDeviceMap,
        assistiveDeviceController.selectedsubAssestiveDevice,
        diagSubcatIds,
        diagChildcatIds,
        subcategoryValues,
        durations,
        frequencies,
        leftRights,
      );
      addDiagnosisItems(
        referredToController.selectedReferredTo,
        referredToController.referredToMap,
        referredToController.selectedsubReferredTo,
        diagSubcatIds,
        diagChildcatIds,
        subcategoryValues,
        durations,
        frequencies,
        leftRights,
      );
      addDiagnosisItems(
        disabilityTypesController.selecteddisabilityTypes,
        disabilityTypesController.disabilityTypesMap,
        disabilityTypesController.selectedSubDisabilityTypes,
        diagSubcatIds,
        diagChildcatIds,
        subcategoryValues,
        durations,
        frequencies,
        leftRights,
      );
      addDiagnosisItems(
        diagnosisController.selectedDiagnosis,
        diagnosisController.diagnosisMap,
        diagnosisController.selectedsubDiagnosis,
        diagSubcatIds,
        diagChildcatIds,
        subcategoryValues,
        durations,
        frequencies,
        leftRights,
      );


      // --- Add Advice (OptimizedAdviceController) ---
      final optimizedAdviceController = locator.get<OptimizedAdviceController>();
      for (final test in optimizedAdviceController.selectedTests) {
        String testName = test;
        String? leftRight;
        // Check if test has side info
        if (test.endsWith('(Lt)')) {
          testName = test.replaceAll(' (Lt)', '');
          leftRight = 'Lt';
        } else if (test.endsWith('(Rt)')) {
          testName = test.replaceAll(' (Rt)', '');
          leftRight = 'Rt';
        }
        final subcatId = optimizedAdviceController.testSubcategoryMapping[testName];
        final childcatId = optimizedAdviceController.testChildcategoryMapping[testName];
        if (subcatId != null) {
          diagSubcatIds.add(subcatId.toString());
          subcategoryValues.add('');
          durations.add('');
          frequencies.add('');
          leftRights.add(leftRight ?? '');
        }
        if (childcatId != null) {
          diagChildcatIds.add(childcatId.toString());
        }
      }

      // --- Add Previous Therapy (PreviousTherapyHistoryController) ---
      final previousTherapyController = locator.get<PreviousTherapyHistoryController>();
      // Helper to add therapy
      void addTherapyOption(Map<String, dynamic> option) {
        final subcatId = option['subcategory_id'];
        final childcatId = option['id'];
        if (subcatId != null) {
          diagSubcatIds.add(subcatId.toString());
          final details = previousTherapyController.therapyDetails[childcatId.toString()] ?? {};
          subcategoryValues.add('');
          durations.add(details['duration']?.toString() ?? '');
          frequencies.add(details['frequency']?.toString() ?? '');
          leftRights.add('');
        }
        if (childcatId != null) {
          diagChildcatIds.add(childcatId.toString());
        }
      }
      for (final option in previousTherapyController.selectedElectrotherapy) {
        addTherapyOption(option);
      }
      for (final option in previousTherapyController.selectedManualTherapy) {
        addTherapyOption(option);
      }
      for (final option in previousTherapyController.selectedAdditionalTherapies) {
        addTherapyOption(option);
      }

    
// Add others from previous therapy as a custom newSubCat entry
      if (previousTherapyController.others.value.isNotEmpty &&
          previousTherapyController.previousTherapyCategoryId != null) {
        // Will be added after collecting other custom entries
      }

      // Collect custom new subcategories typed by the user (not in DB)
      final List<Map<String, dynamic>> newSubCats = [];
      void collectCustom(List<Map<String, dynamic>> customList) {
        for (final custom in customList) {
          newSubCats.add({
            'diagnosis_category_id': custom['diagnosis_category_id'],
            'name': custom['name'].toString(),
          });
        }
      }
      collectCustom(cheifComplainController.customNewComplaints);
      collectCustom(onExaminationController.customNewExaminations);
      collectCustom(radiologicalFindingsController.customNewRadiologicalFindings);
      collectCustom(primaryMedicalHistoryController.customNewMedicalHistory);
      collectCustom(drugHistoryController.customNewDrugHistory);
      collectCustom(assistiveDeviceController.customNewAssestiveDevice);
      collectCustom(referredToController.customNewReferredTo);
      collectCustom(disabilityTypesController.customNewDisabilityTypes);
      collectCustom(diagnosisController.customNewDiagnosis);
      
      // Add others from previous therapy if present
      if (previousTherapyController.others.value.isNotEmpty &&
          previousTherapyController.previousTherapyCategoryId != null) {
        newSubCats.add({
          'diagnosis_category_id': previousTherapyController.previousTherapyCategoryId,
          'name': previousTherapyController.others.value,
        });
      }
      
      // Guard: prevent API call with COMPLETELY empty diagnosis data
      // Now we check if there's ANY data: DB entries OR custom entries
      if (diagSubcatIds.isEmpty &&
          diagChildcatIds.isEmpty &&
          subcategoryValues.isEmpty &&
          newSubCats.isEmpty) {
        Get.snackbar(
          'Error',
          'No diagnosis selected. Please add at least one diagnosis item before saving.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return 400;
      }

      final patientId = locator.get<PatientInfoController>().patientId.value;
      final addType = 'prescription';
      final date = locator.get<PatientInfoController>().date.value
          ?.toIso8601String()
          .substring(0, 10);

      final url = Uri.parse(Api.updateDiagnosis);
      final token = QuickTechAuthStorageService.getToken();

      // Build multipart/form-data request (matches Postman format)
      // Uses indexed keys (e.g. diagSubcatIds[0]) which Laravel parses as arrays
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      request.fields['patient_id'] = patientId.toString();
      request.fields['add_type'] = addType;
      if (date != null) request.fields['date'] = date;

      for (int i = 0; i < diagSubcatIds.length; i++) {
        request.fields['diagSubcatIds[$i]'] = diagSubcatIds[i];
      }
      for (int i = 0; i < diagChildcatIds.length; i++) {
        request.fields['diagChildcatIds[$i]'] = diagChildcatIds[i];
      }
      for (int i = 0; i < subcategoryValues.length; i++) {
        request.fields['subcategory_value[$i]'] = subcategoryValues[i];
        if (subcategoryValues[i].isNotEmpty) {
          debugPrint('DEBUG: subcategory_value[$i] = "${subcategoryValues[i]}"');
        }
      }
      for (int i = 0; i < durations.length; i++) {
        request.fields['duration[$i]'] = durations[i];
      }
      for (int i = 0; i < frequencies.length; i++) {
        request.fields['frequency[$i]'] = frequencies[i];
      }
      for (int i = 0; i < leftRights.length; i++) {
        request.fields['left_right[$i]'] = leftRights[i];
      }
      // New custom subcategories – sent as newSubCats[i][diagnosis_category_id] & newSubCats[i][name]
      for (int i = 0; i < newSubCats.length; i++) {
        request.fields['newSubCats[$i][diagnosis_category_id]'] =
            newSubCats[i]['diagnosis_category_id'].toString();
        request.fields['newSubCats[$i][name]'] = newSubCats[i]['name'];
      }

      debugPrint('=== DIAGNOSIS API REQUEST [${DateTime.now().toString()}] ===');
      debugPrint('URL: $url');
      debugPrint('Total entries: ${diagSubcatIds.length} DB + ${newSubCats.length} custom');
      debugPrint('Fields: ${request.fields}');

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('=== DIAGNOSIS API RESPONSE [${DateTime.now().toString()}] ===');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Headers: ${response.headers}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Diagnosis data stored successfully.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        print("Diagnosis:${response.body}");
        print('Diagnosis data stored successfully.');
        debugPrint('<<< DIAGNOSIS STORE SUCCESS [Status: ${response.statusCode}]');
        return response.statusCode;
      } else {
        final errorMsg = 'Failed to store diagnosis data (Status: ${response.statusCode})\nEndpoint: ${Api.updateDiagnosis}\nResponse: ${response.body}';
        print(errorMsg);
        debugPrint('<<< DIAGNOSIS STORE FAILED [Status: ${response.statusCode}]');
        Get.snackbar(
          'Error',
          'Failed to store diagnosis. Status: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return response.statusCode;
      }
    } catch (e) {
      debugPrint('<<< DIAGNOSIS STORE EXCEPTION: $e');
      debugPrint('Error storing diagnosis data: $e');
      return 500;
    }
  


}

  void clearAllDiagnosisData() {
    try {
      locator.get<DiagnosisController>().clearAll();
      locator.get<CheifComplainController>().clearChiefComplaint();
      locator.get<OnExaminationController>().clearAll();
      locator.get<RadiologicalFindingsController>().clearAll();
      locator.get<PrimaryMedicalHistoryController>().clearAll();
      locator.get<DrugHistoryController>().clearAll();
      locator.get<AssestiveDeviceController>().clearAll();
      locator.get<ReferredToController>().clearAll();
      locator.get<DisabilityTypesController>().clearAll();
      final prev = locator.get<PreviousTherapyHistoryController>();
      prev.selectedElectrotherapy.clear();
      prev.selectedManualTherapy.clear();
      prev.selectedAdditionalTherapies.clear();
      prev.others.value = '';
      locator.get<OptimizedAdviceController>().selectedTests.clear();

      print('All diagnosis data cleared successfully.');
    } catch (e) {
      debugPrint('Error clearing diagnosis data: $e');
    }
  }

  Future<void> fetchDiagnosisCategories() async {
    if (diagnosisCategories.isNotEmpty) return; // Already loaded
    isLoading = true;
    error = null;
    notifyListeners();
    final url = Uri.parse(
      '${Api.baseUrl}/api/diagnosis/categories/with/all',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> categoriesJson = data['diagnosis_categories'] ?? [];
        diagnosisCategories =
            categoriesJson
                .map((e) => PresDiagnosisCategory.fromJson(e))
                .toList();
      } else {
        error = 'Failed to load data: ${response.statusCode}';
      }
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

}