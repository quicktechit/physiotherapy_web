import 'dart:convert';

import 'package:e_prescription/controllers/prescription_controller/patient_info_controller/patient_info_controller.dart';
import 'package:e_prescription/locator.dart';

import 'package:e_prescription/const/electro_param_keys.dart';
import 'package:e_prescription/models/rx_models/electrotherapy.dart';

import 'package:e_prescription/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

PatientInfoController patientInfoController = locator.get<PatientInfoController>();

class QuickTechElectrotherapyController extends GetxController {

  void printElectrotherapyData() {
    List<int> electroTherapyIds = [];
    List<String> therapyTime = [];
    List<String> totalTreatmentTime = [];
    List<String> visitingFrequency = [];
    List<String> frequency = [];
    List<String?> areaMulti = [];
    List<String?> pulseDuration = [];
    List<String?> tractionWeight = [];
    List<String?> holdTime = [];
    List<String?> restTime = [];

    String? areaSingle;
    String? pulseRatio;
    String? intensity;
    String? pulseWidth;
    String? pulseRate;
    String? averageWatt;
    String? typeOfIrr;
    String? distance;

    for (var category in electrotherapyCategories) {
      for (var option in category.options) {
        final params = selectedParameters[option.name] ?? {};
        
        // Only include this therapy if it has at least one parameter selected
        if (params.isNotEmpty) {
          electroTherapyIds.add(option.id);
          therapyTime.add(params['therapy_time']?.toString() ?? 'none');
          totalTreatmentTime.add(params['total_treatment_time']?.toString() ?? 'none');
          visitingFrequency.add(params['visiting_frequency']?.toString() ?? 'none');
          frequency.add(params['Frequency']?.toString() ?? 'none');
          areaMulti.add(params['Area Options'] is List ? (params['Area Options'] as List).join(', ') : null);
          pulseDuration.add(params['Pulse Duration/Ratio']?.toString());
          tractionWeight.add(params['Traction Weight']?.toString());
          holdTime.add(params['Hold Time']?.toString());
          restTime.add(params['Rest Time']?.toString());

          areaSingle ??= params['Area Options'] is String ? params['Area Options'] : null;
          pulseRatio ??= params['Pulse Duration/Ratio']?.toString();
          intensity ??= params['Intensity']?.toString();
          pulseWidth ??= params['Pulse Width']?.toString();
          pulseRate ??= params['Pulse Rate']?.toString();
          averageWatt ??= params['Average Watt']?.toString();
          typeOfIrr ??= params['Type of IRR']?.toString();
          distance ??= params['Distance']?.toString();
        }
      }
    }

   
  }
  final prescriptions = <ElectrotherapyPrescription>[].obs;
  final selectedParameters = <String, Map<String, dynamic>>{}.obs;
  final textControllers = <String, Map<String, TextEditingController>>{}.obs;
  final electrotherapyCategories = <ElectrotherapyCategory>[].obs;
  
  // ✅ NEW: Support multiple custom electrotherapies
  final extraElectrotherapies = <String>[].obs;  // List of custom therapy names
  final extraTherapyControllers = <TextEditingController>[].obs;  // Controllers for each field

  @override
  void onInit() {
    super.onInit();
    fetchElectroTherapies();
  }

  /// ✅ Add a new custom electrotherapy field
  void addExtraElectrotherapy() {
    extraTherapyControllers.add(TextEditingController());
    extraElectrotherapies.add('');
    print('[ElectroController] Added new extra therapy field. Total: ${extraElectrotherapies.length}');
  }

  /// ✅ Remove custom electrotherapy at index
  void removeExtraElectrotherapy(int index) {
    if (index >= 0 && index < extraTherapyControllers.length) {
      extraTherapyControllers[index].dispose();
      extraTherapyControllers.removeAt(index);
      extraElectrotherapies.removeAt(index);
      print('[ElectroController] Removed extra therapy at index $index. Total: ${extraElectrotherapies.length}');
    }
  }

  /// ✅ Update custom electrotherapy value
  void updateExtraElectrotherapy(int index, String value) {
    if (index >= 0 && index < extraElectrotherapies.length) {
      extraElectrotherapies[index] = value;
    }
  }

  /// ✅ Get all non-empty extra therapies
  List<String> getFilledExtraElectrotherapies() {
    return extraElectrotherapies.where((e) => e.trim().isNotEmpty).toList();
  }

  Future<void> fetchElectroTherapies() async {
    try {
      final response = await http.get(
        Uri.parse(Api.getElectrotherapyPrescription),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final therapies =
            (data['electro_therapies'] as List)
                .map((e) => ElectroTherapy.fromJson(e))
                .toList();
        electrotherapyCategories.assignAll([
          ElectrotherapyCategory(
            name: "Electrotherapy",
            options:
                therapies
                    .map(
                      (therapy) => ElectrotherapyOption(
                        id: therapy.id,
                        name: therapy.name,
                        parameters: _mapTherapyToParameters(therapy),
                      ),
                    )
                    .toList(),
          ),
        ]);
        // Init selections and controllers
        for (var category in electrotherapyCategories) {
          for (var option in category.options) {
            selectedParameters[option.name] = {};
            textControllers[option.name] = {
              for (var param in option.parameters)
                if (param.type == ParameterType.textInput)
                  param.name: TextEditingController(),
            };
          }
        }
      } else {
        Get.snackbar("Error", "Failed to fetch therapies: ${response.statusCode}");
        print("Failed to fetch therapies: ${response.body}");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  void clearAllSelections() {
    for (var key in selectedParameters.keys) {
      selectedParameters[key] = {};
    }
    // ✅ NEW: Clear extra therapies too
    extraTherapyControllers.forEach((controller) => controller.dispose());
    extraTherapyControllers.clear();
    extraElectrotherapies.clear();
    update();
  }

  void updateParameter(String optionName, String paramName, dynamic value) {
    final params = Map<String, dynamic>.from(
      selectedParameters[optionName] ?? {},
    );
    
    if (paramName == ElectroParamKeys.kAreaOptions) {
      // Determine parameter type (single vs multi) so we can store UI-friendly value under paramName
      final paramType = _getParameterType(optionName, paramName);

      if (_isNumericId(value)) {
        final receivedIds = _extractNumericIds(value);
        final areaNames = _getAreaNamesForIds(optionName, receivedIds);

        params[ElectroParamKeys.kAreaNames] = areaNames;
        params[ElectroParamKeys.kAreaIds]   = receivedIds;
        if (paramType == ParameterType.singleSelect) {
          params[paramName] = areaNames.isNotEmpty ? areaNames.first : null;
        } else {
          params[paramName] = receivedIds;
        }
        print('DEBUG Controller: Area selection (by ID) - IDs: $receivedIds, Names: $areaNames');
      } else {
        final areaNames = _extractAreaNamesList(value);
        final areaIds = _getAreaIdsForNames(optionName, areaNames);

        params[ElectroParamKeys.kAreaNames] = areaNames;
        params[ElectroParamKeys.kAreaIds]   = areaIds;
        if (paramType == ParameterType.singleSelect) {
          params[paramName] = areaNames.isNotEmpty ? areaNames.first : null;
        } else {
          params[paramName] = areaIds;
        }
        print('DEBUG Controller: Area selection (by Name) - Names: $areaNames, IDs: $areaIds');
      }
    } else {
      params[paramName] = value;
    }

    selectedParameters[optionName] = params;
    print('DEBUG Controller: Updated selectedParameters[$optionName][$paramName] = ${params[paramName]}');
    print('DEBUG Controller: Full params for $optionName = $params');
    update();
  }
  
  /// Check if value contains numeric IDs (not area names)
  bool _isNumericId(dynamic value) {
    if (value is int) return true;
    if (value is List) {
      return value.isNotEmpty && value.every((e) => e is int);
    }
    if (value is String) {
      return int.tryParse(value) != null;
    }
    return false;
  }

  /// Extract numeric IDs from value
  List<int> _extractNumericIds(dynamic value) {
    if (value is int) return [value];
    if (value is List) {
      return value.whereType<int>().toList();
    }
    if (value is String) {
      return [int.tryParse(value) ?? 0];
    }
    return [];
  }

  /// Determine parameter type for a given option and parameter name
  ParameterType _getParameterType(String optionName, String paramName) {
    for (var category in electrotherapyCategories) {
      for (var option in category.options) {
        if (option.name == optionName) {
          for (var param in option.parameters) {
            if (param.name == paramName) return param.type;
          }
        }
      }
    }
    // Default to multiSelect for area options when unknown
    return ParameterType.multiSelect;
  }

  /// Get area names by looking up numeric IDs in the therapy's area definitions
  List<String> _getAreaNamesForIds(String optionName, List<int> areaIds) {
    final List<String> names = [];
    
    for (var category in electrotherapyCategories) {
      for (var option in category.options) {
        if (option.name == optionName) {
          for (var param in option.parameters) {
            if (param.name == ElectroParamKeys.kAreaOptions && param.areaIds != null) {
              // Match each numeric ID to its area name
              for (final selectedId in areaIds) {
                final idIndex = param.areaIds!.indexOf(selectedId);
                if (idIndex >= 0 && idIndex < param.options!.length) {
                  names.add(param.options![idIndex]);
                }
              }
              return names;
            }
          }
          return names;
        }
      }
    }
    
    return names;
  }
  
  /// Extract area names as a list (handles both single select string and multi-select list)
  List<String> _extractAreaNamesList(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value.map((e) => e?.toString() ?? '').where((s) => s.isNotEmpty).toList();
    }
    if (value is String) return [value];
    return [value.toString()];
  }
  
  /// Lookup area IDs by matching names to the therapy's area definitions
  List<int> _getAreaIdsForNames(String optionName, List<String> areaNames) {
    final List<int> ids = [];
    
    // Find the electrotherapy option to get its area definitions
    for (var category in electrotherapyCategories) {
      for (var option in category.options) {
        if (option.name == optionName) {
          // Find the area parameter
          for (var param in option.parameters) {
            if (param.name == ElectroParamKeys.kAreaOptions && param.areaIds != null) {
              // Match each selected name to its ID
              for (final selectedName in areaNames) {
                final nameIndex = param.options!.indexOf(selectedName);
                if (nameIndex >= 0 && nameIndex < param.areaIds!.length) {
                  ids.add(param.areaIds![nameIndex]);
                }
              }
              return ids;
            }
          }
          return ids;
        }
      }
    }
    
    return ids;
  }

  List<ElectrotherapyPerameter> _mapTherapyToParameters(
    ElectroTherapy therapy,
  ) {
    final params = <ElectrotherapyPerameter>[];
    final areaNames = therapy.therapyAreas.map((e) => e.name).toList();
    print('DEBUG: _mapTherapyToParameters for ${therapy.name}, type: ${therapy.type}, areaNames: $areaNames');
    
    // Check for both hyphen and underscore variants
    final hasAreaSingle = therapy.type.contains('area-single') || therapy.type.contains('area_single');
    final hasAreaMulti = therapy.type.contains('area-multi') || therapy.type.contains('area_multi');
    
    if (hasAreaSingle && areaNames.isNotEmpty) {
      print('DEBUG: Adding area-single parameter for ${therapy.name}');
      final areaIds = therapy.therapyAreas.map((e) => e.id).toList();
      params.add(
        ElectrotherapyPerameter(
          name: ElectroParamKeys.kAreaOptions,
          type: ParameterType.singleSelect,
          options: areaNames,
          areaIds: areaIds,
        ),
      );
    } else if (hasAreaMulti && areaNames.isNotEmpty) {
      print('DEBUG: Adding area-multi parameter for ${therapy.name}');
      final areaIds = therapy.therapyAreas.map((e) => e.id).toList();
      params.add(
        ElectrotherapyPerameter(
          name: ElectroParamKeys.kAreaOptions,
          type: ParameterType.multiSelect,
          options: areaNames,
          areaIds: areaIds,
        ),
      );
    } else {
      print('DEBUG: NOT adding area parameter for ${therapy.name} (type check failed or no areas). hasAreaSingle=$hasAreaSingle, hasAreaMulti=$hasAreaMulti, areaNames=$areaNames');
    }
    final paramMap = {
      "frequency":      [ElectroParamKeys.kFrequency,      "Hz"],
      "pulse-ratio":    [ElectroParamKeys.kPulseDuration,  "µs"],
      "pulse-duration": [ElectroParamKeys.kPulseDuration,  "µs"],
      "pulse-width":    [ElectroParamKeys.kPulseWidth,     "µs"],
      "pulse-rate":     [ElectroParamKeys.kPulseRate,      "pps"],
      "average-watt":   [ElectroParamKeys.kAverageWatt,   "watt"],
      "traction-weight":[ElectroParamKeys.kTractionWeight, "Kg"],
      "hold-time":      [ElectroParamKeys.kHoldTime,       "minutes"],
      "rest-time":      [ElectroParamKeys.kRestTime,       "seconds"],
      "distance":       [ElectroParamKeys.kDistance,       "cm"],
      "intensity":      [ElectroParamKeys.kIntensity,      null],
    };
    paramMap.forEach((key, value) {
      if (therapy.type.contains(key)) {
        params.add(
          ElectrotherapyPerameter(
            name: value[0] ?? '',
            type: ParameterType.textInput,
            unit: value[1],
          ),
        );
      }
    });
    if (therapy.type.contains("type-of-irr")) {
      params.add(
        ElectrotherapyPerameter(
          name: ElectroParamKeys.kTypeOfIrr,
          type: ParameterType.singleSelect,
          options: ["Luminous", "Non-luminous"],
        ),
      );
    }
    return params;
  }

  /// Debug: Validate area ID extraction for all selected electrotherapies\n  void debugPrintAreaMapping() {\n    print('\\n=== AREA ID MAPPING DEBUG ===');\n    for (var category in electrotherapyCategories) {\n      for (var option in category.options) {\n        final params = selectedParameters[option.name] ?? {};\n        if (params.isNotEmpty && params.containsKey('Area IDs')) {\n          final areaNames = params['Area Names'] ?? [];\n          final areaIds = params['Area IDs'] ?? [];\n          print('Therapy: ${option.name}');\n          print('  Area Names: $areaNames');\n          print('  Area IDs: $areaIds');\n        }\n      }\n    }\n    print('=== END AREA MAP DEBUG ===\\n');\n  }\n\n  /// Check if any electrotherapies are selected
  bool hasSelectedElectrotherapies() {
    for (var category in electrotherapyCategories) {
      for (var option in category.options) {
        final params = selectedParameters[option.name] ?? {};
        if (params.isNotEmpty) {
          return true;
        }
      }
    }
    return false;
  }

  /// Get count of selected electrotherapies
  int getSelectedElectrotherapiesCount() {
    int count = 0;
    for (var category in electrotherapyCategories) {
      for (var option in category.options) {
        final params = selectedParameters[option.name] ?? {};
        if (params.isNotEmpty) {
          count++;
        }
      }
    }
    return count;
  }

  // Future<void> submitElectrotherapyData() async {
   

  //   // Prepare lists for each field
  //   List<int> electroTherapyIds = [];
  //   List<String> therapyTime = [];
  //   List<String> totalTreatmentTime = [];
  //   List<String> visitingFrequency = [];
  //   List<String> frequency = [];
  //   List<String?> areaMulti = [];
  //   List<String?> pulseDuration = [];
  //   List<String?> tractionWeight = [];
  //   List<String?> holdTime = [];
  //   List<String?> restTime = [];

  //   // For single-value fields (if any selected)
  //   String? areaSingle;
  //   String? pulseRatio;
  //   String? intensity;
  //   String? pulseWidth;
  //   String? pulseRate;
  //   String? averageWatt;
  //   String? typeOfIrr;
  //   String? distance;

  //   // Loop through only selected therapies (those with parameters)
  //   for (var category in electrotherapyCategories) {
  //     for (var option in category.options) {
  //       final params = selectedParameters[option.name] ?? {};
        
  //       // Only include this therapy if it has at least one parameter selected
  //       if (params.isNotEmpty) {
  //         electroTherapyIds.add(option.id);

  //         // Add values to lists, use 'none' or null if not selected
  //         therapyTime.add(params['therapy_time']?.toString() ?? 'none');
  //         totalTreatmentTime.add(
  //           params['total_treatment_time']?.toString() ?? 'none',
  //         );
  //         visitingFrequency.add(
  //           params['visiting_frequency']?.toString() ?? 'none',
  //         );
  //         frequency.add(params['Frequency']?.toString() ?? 'none');
  //         areaMulti.add(
  //           params['Area Options'] is List
  //               ? (params['Area Options'] as List).join(', ')
  //               : null,
  //         );
  //         pulseDuration.add(params['Pulse Duration/Ratio']?.toString());
  //         tractionWeight.add(params['Traction Weight']?.toString());
  //         holdTime.add(params['Hold Time']?.toString());
  //         restTime.add(params['Rest Time']?.toString());

  //         // Single-value fields (if present, only take first non-null)
  //         areaSingle ??=
  //             params['Area Options'] is String ? params['Area Options'] : null;
  //         pulseRatio ??= params['Pulse Duration/Ratio']?.toString();
  //         intensity ??= params['Intensity']?.toString();
  //         pulseWidth ??= params['Pulse Width']?.toString();
  //         pulseRate ??= params['Pulse Rate']?.toString();
  //         averageWatt ??= params['Average Watt']?.toString();
  //         typeOfIrr ??= params['Type of IRR']?.toString();
  //         distance ??= params['Distance']?.toString();
  //       }
  //     }
  //   }

  //   // Build request body
  //   final body = {
  //     "patient_id": patientInfoController.patientId.value,
  //     "electroTherapyIds": electroTherapyIds,
  //     "therapy_time": therapyTime,
  //     "total_treatment_time": totalTreatmentTime,
  //     "visiting_frequency": visitingFrequency,
  //     "frequency": frequency,
  //     "area_multi": areaMulti,
  //     "pulse_duration": pulseDuration,
  //     "traction_weight": tractionWeight,
  //     "hold_time": holdTime,
  //     "rest_time": restTime,
  //     "area_single": areaSingle,
  //     "pulse_ratio": pulseRatio,
  //     "intensity": intensity,
  //     "pulse_width": pulseWidth,
  //     "pulse_rate": pulseRate,
  //     "average_watt": averageWatt,
  //     "type_of_irr": typeOfIrr,
  //     "distance": distance,
  //   };

  //   try {
  //     final response = await http.post(
  //       Uri.parse(Api.updateElectroPresc),
  //       headers: {'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${token}'
  //       },
  //       body: jsonEncode(body),
  //     );
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       // Individual success snackbar removed - handled by main prescription controller
  //       printElectrotherapyData();
   
  //     } else {
  //       Get.snackbar("Error", "Failed to store data: ${response.body}");
  //       print( "Failed to store data: ${response.body}");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Something went wrong: $e");
  //   }
  // }
}

