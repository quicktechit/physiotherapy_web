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
import 'package:e_prescription/models/prescription/diagnosis_category_response.dart';

// Controller
class MainDiagnosisController extends ChangeNotifier {
  List<DiagnosisCategories> diagnosisCategories = [];
  bool isLoading = false;
  String? error;

  List<String> _getMissingChildSelections() {
    final cheifComplainController = locator.get<CheifComplainController>();
    final onExaminationController = locator.get<OnExaminationController>();
    final radiologicalFindingsController =
        locator.get<RadiologicalFindingsController>();
    final primaryMedicalHistoryController =
        locator.get<PrimaryMedicalHistoryController>();
    final drugHistoryController = locator.get<DrugHistoryController>();
    final assistiveDeviceController = locator.get<AssestiveDeviceController>();
    final referredToController = locator.get<ReferredToController>();
    final disabilityTypesController = locator.get<DisabilityTypesController>();
    final diagnosisController = locator.get<DiagnosisController>();

    final missingChildSelections = <String>[];

    void addMissingItems(
      Iterable<String> selectedItems,
      Map<String, Map<String, dynamic>> dataMap,
      Map<String, List<String>> subMap,
    ) {
      for (final item in selectedItems) {
        final subcategoryData = dataMap[item];
        if (subcategoryData == null) continue;

        final childSelections = subMap[item] ?? const <String>[];
        final children =
            (subcategoryData['children'] as List?)?.cast<Map<String, dynamic>>() ??
                const <Map<String, dynamic>>[];

        if (children.isNotEmpty && childSelections.isEmpty) {
          missingChildSelections.add(item);
        }
      }
    }

    final chiefComplaintMap = <String, Map<String, dynamic>>{};
    final chiefCategory = cheifComplainController.chiefComplaintCategory.value;
    if (chiefCategory != null) {
      for (final sub
          in chiefCategory.diagnosisSubcategories ??
              <DiagnosisSubcategories>[]) {
        if (sub.name == null) continue;
        chiefComplaintMap[sub.name!] = {
          'id': sub.id,
          'children':
              (sub.diagnosisChildcategories ?? <DiagnosisChildcategories>[])
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

    addMissingItems(
      cheifComplainController.selectedComplaints,
      chiefComplaintMap,
      cheifComplainController.selectedSubComplaints,
    );
    addMissingItems(
      onExaminationController.selectedExaminations,
      onExaminationController.onExaminationMap,
      onExaminationController.selectedSubExaminations,
    );
    addMissingItems(
      radiologicalFindingsController.selectedRadioLogicalFindings,
      radiologicalFindingsController.radiologicalFindingsMap,
      radiologicalFindingsController.selectedsubRadiologicalFindings,
    );
    addMissingItems(
      primaryMedicalHistoryController.selectedMedicalHistory,
      primaryMedicalHistoryController.medicalHistoryMap,
      primaryMedicalHistoryController.selectedsubMedicalHistory,
    );
    addMissingItems(
      drugHistoryController.selectedDrugHistory,
      drugHistoryController.drugHistoryMap,
      drugHistoryController.selectedsubDrugHistory,
    );
    addMissingItems(
      assistiveDeviceController.selectedAssestiveDevice,
      assistiveDeviceController.assestiveDeviceMap,
      assistiveDeviceController.selectedsubAssestiveDevice,
    );
    addMissingItems(
      referredToController.selectedReferredTo,
      referredToController.referredToMap,
      referredToController.selectedsubReferredTo,
    );
    addMissingItems(
      disabilityTypesController.selecteddisabilityTypes,
      disabilityTypesController.disabilityTypesMap,
      disabilityTypesController.selectedSubDisabilityTypes,
    );
    addMissingItems(
      diagnosisController.selectedDiagnosis,
      diagnosisController.diagnosisMap,
      diagnosisController.selectedsubDiagnosis,
    );

    return missingChildSelections.toSet().toList();
  }

  bool validateRequiredChildSelections() {
    final missingChildSelections = _getMissingChildSelections();
    if (missingChildSelections.isEmpty) {
      return true;
    }

    Get.snackbar(
      'Child Category Required',
      'Please select a child category for: ${missingChildSelections.join(', ')}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return false;
  }

  Future<int> storeAllDiagnosisData() async {
    try {
      if (!validateRequiredChildSelections()) {
        return 400;
      }

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

      final diagnosisEntries = <Map<String, String>>[];

      String _resolveSubcategoryValue(
        Map<String, dynamic> source, {
        OnExaminationController? onExaminationController,
        String? itemName,
      }) {
        if (onExaminationController != null && itemName != null) {
          final map = onExaminationController.onExaminationMap[itemName];
          if (map != null && map['type'] == 'With Value') {
            final rxString = onExaminationController.examinationValues[itemName];
            if (rxString != null && rxString.value.isNotEmpty) {
              return rxString.value;
            }
          }
        }

        final subcategoryValue = source['subcategory_value'];
        if (subcategoryValue != null &&
            subcategoryValue.toString().isNotEmpty) {
          return subcategoryValue.toString();
        }

        return '';
      }

      void appendDiagnosisEntry({
        required dynamic subcategoryId,
        dynamic childcategoryId,
        String subcategoryValue = '',
        String duration = '',
        String frequency = '',
        String leftRight = '',
      }) {
        if (subcategoryId == null) return;
        diagnosisEntries.add({
          'diagSubcatId': subcategoryId.toString(),
          'diagChildcatId': childcategoryId?.toString() ?? '',
          'subcategory_value': subcategoryValue,
          'duration': duration,
          'frequency': frequency,
          'left_right': leftRight,
        });
      }

      void addDiagnosisItems(
        Iterable<String> selectedItems,
        Map<String, Map<String, dynamic>> dataMap,
        Map<String, List<String>> subMap,
        {OnExaminationController? onExaminationController}
      ) {
        if (selectedItems.isEmpty) return;

        for (final item in selectedItems) {
          final subcategoryData = dataMap[item];
          if (subcategoryData == null) {
            // This is likely a custom entry - it will be sent via customNewComplaints
            continue;
          }

          final childSelections = subMap[item] ?? const <String>[];
          final subcategoryValue = _resolveSubcategoryValue(
            subcategoryData,
            onExaminationController: onExaminationController,
            itemName: item,
          );
          final duration = _valueOrEmpty(subcategoryData['duration']);
          final frequency = _valueOrEmpty(subcategoryData['frequency']);
          final leftRight = _valueOrEmpty(subcategoryData['left_right']);

          final children =
              (subcategoryData['children'] as List?)?.cast<Map<String, dynamic>>() ??
                  const <Map<String, dynamic>>[];

          if (childSelections.isEmpty) {
            appendDiagnosisEntry(
              subcategoryId: subcategoryData['id'],
              subcategoryValue: subcategoryValue,
              duration: duration,
              frequency: frequency,
              leftRight: leftRight,
            );
            continue;
          }

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
              subcategoryId: subcategoryData['id'],
              childcategoryId: childData['id'],
              subcategoryValue: subcategoryValue,
              duration: duration,
              frequency: frequency,
              leftRight: leftRight,
            );
          }
        }
      }

      final chiefComplaintMap = <String, Map<String, dynamic>>{};
      final chiefCategory =
          cheifComplainController.chiefComplaintCategory.value;
      if (chiefCategory != null) {
        for (final sub in chiefCategory.diagnosisSubcategories ?? <DiagnosisSubcategories>[]) {
          if (sub.name == null) continue;
          chiefComplaintMap[sub.name!] = {
            'id': sub.id,
            'children':
                (sub.diagnosisChildcategories ?? <DiagnosisChildcategories>[])
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
      );

      addDiagnosisItems(
        onExaminationController.selectedExaminations,
        onExaminationController.onExaminationMap,
        onExaminationController.selectedSubExaminations,
        onExaminationController: onExaminationController,
      );
      addDiagnosisItems(
        radiologicalFindingsController.selectedRadioLogicalFindings,
        radiologicalFindingsController.radiologicalFindingsMap,
        radiologicalFindingsController.selectedsubRadiologicalFindings,
      );
      addDiagnosisItems(
        primaryMedicalHistoryController.selectedMedicalHistory,
        primaryMedicalHistoryController.medicalHistoryMap,
        primaryMedicalHistoryController.selectedsubMedicalHistory,
      );
      addDiagnosisItems(
        drugHistoryController.selectedDrugHistory,
        drugHistoryController.drugHistoryMap,
        drugHistoryController.selectedsubDrugHistory,
      );
      addDiagnosisItems(
        assistiveDeviceController.selectedAssestiveDevice,
        assistiveDeviceController.assestiveDeviceMap,
        assistiveDeviceController.selectedsubAssestiveDevice,
      );
      addDiagnosisItems(
        referredToController.selectedReferredTo,
        referredToController.referredToMap,
        referredToController.selectedsubReferredTo,
      );
      addDiagnosisItems(
        disabilityTypesController.selecteddisabilityTypes,
        disabilityTypesController.disabilityTypesMap,
        disabilityTypesController.selectedSubDisabilityTypes,
      );
      addDiagnosisItems(
        diagnosisController.selectedDiagnosis,
        diagnosisController.diagnosisMap,
        diagnosisController.selectedsubDiagnosis,
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
          appendDiagnosisEntry(
            subcategoryId: subcatId,
            childcategoryId: childcatId,
            leftRight: leftRight ?? '',
          );
        }
      }

      // --- Add Previous Therapy (PreviousTherapyHistoryController) ---
      final previousTherapyController = locator.get<PreviousTherapyHistoryController>();
      // Helper to add therapy
      void addTherapyOption(Map<String, dynamic> option) {
        final subcatId = option['subcategory_id'];
        final childcatId = option['id'];
        if (subcatId != null) {
          final details = previousTherapyController.therapyDetails[childcatId.toString()] ?? {};
          appendDiagnosisEntry(
            subcategoryId: subcatId,
            childcategoryId: childcatId,
            subcategoryValue: '',
            duration: details['duration']?.toString() ?? '',
            frequency: details['frequency']?.toString() ?? '',
            leftRight: '',
          );
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

      final validChildIds = <String>{};

      void addValidChildIdsFromDataMap(Map<String, Map<String, dynamic>> dataMap) {
        for (final subcategory in dataMap.values) {
          final children =
              (subcategory['children'] as List?)?.cast<Map<String, dynamic>>() ??
                  const <Map<String, dynamic>>[];
          for (final child in children) {
            final childId = child['id'];
            if (childId != null) {
              validChildIds.add(childId.toString());
            }
          }
        }
      }

      addValidChildIdsFromDataMap(chiefComplaintMap);
      addValidChildIdsFromDataMap(onExaminationController.onExaminationMap);
      addValidChildIdsFromDataMap(radiologicalFindingsController.radiologicalFindingsMap);
      addValidChildIdsFromDataMap(primaryMedicalHistoryController.medicalHistoryMap);
      addValidChildIdsFromDataMap(drugHistoryController.drugHistoryMap);
      addValidChildIdsFromDataMap(assistiveDeviceController.assestiveDeviceMap);
      addValidChildIdsFromDataMap(referredToController.referredToMap);
      addValidChildIdsFromDataMap(disabilityTypesController.disabilityTypesMap);
      addValidChildIdsFromDataMap(diagnosisController.diagnosisMap);

      validChildIds.addAll(
        optimizedAdviceController.testChildcategoryMapping.values
            .where((id) => id > 0)
            .map((id) => id.toString()),
      );
      validChildIds.addAll(
        previousTherapyController.selectedElectrotherapy
            .map((item) => item['id'])
            .where((id) => id != null)
            .map((id) => id.toString()),
      );
      validChildIds.addAll(
        previousTherapyController.selectedManualTherapy
            .map((item) => item['id'])
            .where((id) => id != null)
            .map((id) => id.toString()),
      );
      validChildIds.addAll(
        previousTherapyController.selectedAdditionalTherapies
            .map((item) => item['id'])
            .where((id) => id != null)
            .map((id) => id.toString()),
      );

      final skippedInvalidChildIds = <String>[];

      List<Map<String, dynamic>> _therapySelectionSnapshot(
        List<Map<String, dynamic>> selections,
      ) {
        return selections.map((item) {
          final childId = item['id']?.toString() ?? '';
          final details = previousTherapyController.therapyDetails[childId] ?? {};
          return {
            'subcategory_id': item['subcategory_id'],
            'child_id': item['id'],
            'name': item['name'],
            'duration': details['duration']?.toString() ?? '',
            'frequency': details['frequency']?.toString() ?? '',
            'isRegular': details['isRegular'],
          };
        }).toList();
      }

      final selectedSnapshot = <String, dynamic>{
        'chiefComplaint': {
          'selected': cheifComplainController.selectedComplaints.toList(),
          'selectedChildren': cheifComplainController.selectedSubComplaints,
          'custom': cheifComplainController.customNewComplaints,
        },
        'onExamination': {
          'selected': onExaminationController.selectedExaminations.toList(),
          'selectedChildren': onExaminationController.selectedSubExaminations,
          'values': onExaminationController.examinationValues.map(
            (key, value) => MapEntry(key, value.value),
          ),
          'custom': onExaminationController.customNewExaminations,
        },
        'radiologicalFindings': {
          'selected': radiologicalFindingsController.selectedRadioLogicalFindings.toList(),
          'selectedChildren':
              radiologicalFindingsController.selectedsubRadiologicalFindings,
          'custom': radiologicalFindingsController.customNewRadiologicalFindings,
        },
        'primaryMedicalHistory': {
          'selected': primaryMedicalHistoryController.selectedMedicalHistory.toList(),
          'selectedChildren': primaryMedicalHistoryController.selectedsubMedicalHistory,
          'custom': primaryMedicalHistoryController.customNewMedicalHistory,
        },
        'drugHistory': {
          'selected': drugHistoryController.selectedDrugHistory.toList(),
          'selectedChildren': drugHistoryController.selectedsubDrugHistory,
          'custom': drugHistoryController.customNewDrugHistory,
        },
        'assistiveDevice': {
          'selected': assistiveDeviceController.selectedAssestiveDevice.toList(),
          'selectedChildren': assistiveDeviceController.selectedsubAssestiveDevice,
          'custom': assistiveDeviceController.customNewAssestiveDevice,
        },
        'referredTo': {
          'selected': referredToController.selectedReferredTo.toList(),
          'selectedChildren': referredToController.selectedsubReferredTo,
          'custom': referredToController.customNewReferredTo,
        },
        'disabilityTypes': {
          'selected': disabilityTypesController.selecteddisabilityTypes.toList(),
          'selectedChildren': disabilityTypesController.selectedSubDisabilityTypes,
          'custom': disabilityTypesController.customNewDisabilityTypes,
        },
        'diagnosis': {
          'selected': diagnosisController.selectedDiagnosis.toList(),
          'selectedChildren': diagnosisController.selectedsubDiagnosis,
          'custom': diagnosisController.customNewDiagnosis,
        },
        'advice': {
          'selectedTests': optimizedAdviceController.selectedTests.toList(),
        },
        'previousTherapy': {
          'electrotherapy': _therapySelectionSnapshot(
            previousTherapyController.selectedElectrotherapy,
          ),
          'manualTherapy': _therapySelectionSnapshot(
            previousTherapyController.selectedManualTherapy,
          ),
          'additionalTherapies': _therapySelectionSnapshot(
            previousTherapyController.selectedAdditionalTherapies,
          ),
          'others': previousTherapyController.others.value,
        },
        'skippedInvalidChildIds': skippedInvalidChildIds,
      };

      debugPrint('DIAGNOSIS SELECTED: ${jsonEncode(selectedSnapshot)}');
      
      // Guard: prevent API call with COMPLETELY empty diagnosis data
      // Now we check if there's ANY data: DB entries OR custom entries
      if (diagnosisEntries.isEmpty &&
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

      int childIndex = 0;
      int valueIndex = 0;
      int durationIndex = 0;
      int frequencyIndex = 0;
      int leftRightIndex = 0;

      for (int i = 0; i < diagnosisEntries.length; i++) {
        final entry = diagnosisEntries[i];
        request.fields['diagSubcatIds[$i]'] = entry['diagSubcatId'] ?? '';

        final childId = entry['diagChildcatId'] ?? '';
        if (childId.isNotEmpty) {
          if (validChildIds.contains(childId)) {
            request.fields['diagChildcatIds[$childIndex]'] = childId;
            childIndex++;
          } else {
            skippedInvalidChildIds.add(childId);
          }
        }

        final subcategoryValue = entry['subcategory_value'] ?? '';
        if (subcategoryValue.isNotEmpty) {
          request.fields['subcategory_value[$valueIndex]'] = subcategoryValue;
          valueIndex++;
        }

        final duration = entry['duration'] ?? '';
        if (duration.isNotEmpty) {
          request.fields['duration[$durationIndex]'] = duration;
          durationIndex++;
        }

        final frequency = entry['frequency'] ?? '';
        if (frequency.isNotEmpty) {
          request.fields['frequency[$frequencyIndex]'] = frequency;
          frequencyIndex++;
        }

        final leftRight = entry['left_right'] ?? '';
        if (leftRight.isNotEmpty) {
          request.fields['left_right[$leftRightIndex]'] = leftRight;
          leftRightIndex++;
        }
      }
      // New custom subcategories – sent as newSubCats[i][diagnosis_category_id] & newSubCats[i][name]
      for (int i = 0; i < newSubCats.length; i++) {
        request.fields['newSubCats[$i][diagnosis_category_id]'] =
            newSubCats[i]['diagnosis_category_id'].toString();
        request.fields['newSubCats[$i][name]'] = newSubCats[i]['name'];
      }

      debugPrint('DIAGNOSIS REQUEST: ${jsonEncode(request.fields)}');

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('DIAGNOSIS RESPONSE [${response.statusCode}]: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Diagnosis data stored successfully.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return response.statusCode;
      } else {
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
      debugPrint('DIAGNOSIS RESPONSE [EXCEPTION]: $e');
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
    final url = Uri.parse(Api.getDiagnosis);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        diagnosisCategories =
            DiagnosisCategoryResponse.fromJson(data).diagnosisCategories ?? [];
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