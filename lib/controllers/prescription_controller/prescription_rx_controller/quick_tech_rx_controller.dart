import 'dart:convert';
import 'package:e_prescription/const/electro_param_keys.dart';
import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/controllers/prescription_controller/patient_info_controller/patient_info_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_electrotherapy_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_manual_therapy_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_miscellaneous_therapy_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_speech_language_therapy_controller.dart';
import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

QuickTechElectrotherapyController electrotherapyController =
    locator.get<QuickTechElectrotherapyController>();
QuickTechManualTherapyController manualTherapyController =
    locator.get<QuickTechManualTherapyController>();
QuickTechMiscellaneousTherapyController miscellaneousTherapyController =
    locator.get<QuickTechMiscellaneousTherapyController>();
QuickTechSpeechLanguageTherapyController speechLanguageTherapyController =
    locator.get<QuickTechSpeechLanguageTherapyController>();

PatientInfoController patientInfoController =
    locator.get<PatientInfoController>();

class QuicktechmainPrescriptionControllr extends GetxController {
  Future<int> storeSelectedRxData() async {
    List<String> storedTherapies = [];
    List<String> errorMessages = [];
    final token = QuickTechAuthStorageService.getFreshToken();

    // ========== 1. Store Electrotherapy Data + Extra Therapies ==========
    final hasElectroSelection = electrotherapyController
        .selectedParameters
        .values
        .any((m) => m.isNotEmpty);
    final hasExtraTherapies = electrotherapyController.getFilledExtraElectrotherapies().isNotEmpty;
    if (hasElectroSelection || hasExtraTherapies) {
      try {
        final selectedElectroOptions = <Map<String, dynamic>>[];
        List<int> electroTherapyIds = [];
        List<String> therapyTime = [];
        List<String> totalTreatmentTime = [];
        List<String> visitingFrequency = [];
        List<String> frequency = [];
        List<List<int>?> areaMulti = [];
        List<String?> areaSingleList = [];
        List<String?> pulseDuration = [];
        List<String?> tractionWeight = [];
        List<String?> holdTime = [];
        List<String?> restTime = [];
        List<String?> pulseRatioList = [];
        List<String?> intensityList = [];
        List<String?> pulseWidthList = [];
        List<String?> pulseRateList = [];
        List<String?> averageWattList = [];
        List<String?> typeOfIrrList = [];
        List<String?> distanceList = [];

        // Loop through selected electrotherapies
        for (var category
            in electrotherapyController.electrotherapyCategories) {
          for (var option in category.options) {
            final params =
                electrotherapyController.selectedParameters[option.name] ?? {};
            if (params.isNotEmpty) {
              selectedElectroOptions.add({
                'id': option.id,
                'name': option.name,
                'params': Map<String, dynamic>.from(params),
              });

              electroTherapyIds.add(option.id);

              therapyTime.add(params[ElectroParamKeys.kTherapyTime]?.toString() ?? '0');
              totalTreatmentTime.add(
                params[ElectroParamKeys.kTotalTreatmentTime]?.toString() ?? '0',
              );
              visitingFrequency.add(
                params[ElectroParamKeys.kVisitingFrequency]?.toString() ?? '0',
              );
              frequency.add(params[ElectroParamKeys.kFrequency]?.toString() ?? '0');

              // ✅ FIXED AREA OPTIONS - Always use stored Area IDs
              final areaIds = params[ElectroParamKeys.kAreaIds];
              if (areaIds is List && areaIds.isNotEmpty) {
                // Filter out nulls and ensure all are integers
                final validIds = (areaIds)
                    .whereType<int>()
                    .toList();
                if (validIds.isNotEmpty) {
                  areaMulti.add(validIds);
                  areaSingleList.add(null);
                } else {
                  areaMulti.add(null);
                  areaSingleList.add(null);
                }
              } else if (areaIds is int) {
                areaSingleList.add(areaIds.toString());
                areaMulti.add([areaIds]);
              } else {
                areaMulti.add([]);
                areaSingleList.add(null);
              }

              // Optional values (all as arrays)
              pulseDuration.add(params[ElectroParamKeys.kPulseDuration]?.toString());
              tractionWeight.add(params[ElectroParamKeys.kTractionWeight]?.toString());
              holdTime.add(params[ElectroParamKeys.kHoldTime]?.toString());
              restTime.add(params[ElectroParamKeys.kRestTime]?.toString());
              pulseRatioList.add(params[ElectroParamKeys.kPulseDuration]?.toString());
              intensityList.add(params[ElectroParamKeys.kIntensity]?.toString());
              pulseWidthList.add(params[ElectroParamKeys.kPulseWidth]?.toString());
              pulseRateList.add(params[ElectroParamKeys.kPulseRate]?.toString());
              averageWattList.add(params[ElectroParamKeys.kAverageWatt]?.toString());
              typeOfIrrList.add(params[ElectroParamKeys.kTypeOfIrr]?.toString());
              distanceList.add(params[ElectroParamKeys.kDistance]?.toString());
            }
          }
        }

        String? firstNonNull(List l) => l.firstWhere((e) => e != null && e.toString().isNotEmpty, orElse: () => null)?.toString();
      
        // Flatten all area IDs from all therapies into a single list
        // Backend's array_intersect() expects a flat array, not per-therapy nesting
        final areaMultiFlat = <int>[];
        for (var area in areaMulti) {
          if (area != null && area.isNotEmpty) {
            areaMultiFlat.addAll(area);
          }
        }

        if (electroTherapyIds.isEmpty && !hasExtraTherapies) {
        } else {
          // ✅ FIX: Manually build form-encoded body to support MULTIPLE values per key
          // (http.MultipartRequest.fields is a Map and can't have duplicate keys)
          final bodyParts = <String>[];
          
          // Add scalar field
          bodyParts.add('patient_id=${Uri.encodeQueryComponent(patientInfoController.patientId.value.toString())}');

          /// ✅ Only add parameter fields if we have standard electrotherapy IDs
          if (electroTherapyIds.isNotEmpty) {
            // Add all scalar optional fields
            bodyParts.add('area_single=${Uri.encodeQueryComponent(firstNonNull(areaSingleList) ?? '')}');
            bodyParts.add('pulse_ratio=${Uri.encodeQueryComponent(firstNonNull(pulseRatioList) ?? '')}');
            bodyParts.add('intensity=${Uri.encodeQueryComponent(firstNonNull(intensityList) ?? '')}');
            bodyParts.add('pulse_width=');
            bodyParts.add('pulse_rate=');
            bodyParts.add('average_watt=');
            bodyParts.add('type_of_irr=${Uri.encodeQueryComponent(firstNonNull(typeOfIrrList) ?? '')}');
            bodyParts.add('distance=${Uri.encodeQueryComponent(firstNonNull(distanceList) ?? '')}');

            // Add ALL array elements with [] suffix (each one separately)
            for (var id in electroTherapyIds) {
              bodyParts.add('electroTherapyIds[]=${Uri.encodeQueryComponent(id.toString())}');
            }
            for (var time in therapyTime) {
              bodyParts.add('therapy_time[]=${Uri.encodeQueryComponent(time)}');
            }
            for (var total in totalTreatmentTime) {
              bodyParts.add('total_treatment_time[]=${Uri.encodeQueryComponent(total)}');
            }
            for (var freq in visitingFrequency) {
              bodyParts.add('visiting_frequency[]=${Uri.encodeQueryComponent(freq)}');
            }
            for (var f in frequency) {
              bodyParts.add('frequency[]=${Uri.encodeQueryComponent(f)}');
            }
            for (var area in areaMultiFlat) {
              bodyParts.add('area_multi[]=${Uri.encodeQueryComponent(area.toString())}');
            }
            for (var pd in pulseDuration) {
              bodyParts.add('pulse_duration[]=${Uri.encodeQueryComponent(pd ?? '')}');
            }
            for (var tw in tractionWeight) {
              bodyParts.add('traction_weight[]=${Uri.encodeQueryComponent(tw ?? '')}');
            }
            for (var ht in holdTime) {
              bodyParts.add('hold_time[]=${Uri.encodeQueryComponent(ht ?? '')}');
            }
            for (var rt in restTime) {
              bodyParts.add('rest_time[]=${Uri.encodeQueryComponent(rt ?? '')}');
            }
            for (var pw in pulseWidthList) {
              bodyParts.add('pulse_width[]=${Uri.encodeQueryComponent(pw ?? '')}');
            }
            for (var pr in pulseRateList) {
              bodyParts.add('pulse_rate[]=${Uri.encodeQueryComponent(pr ?? '')}');
            }
            for (var aw in averageWattList) {
              bodyParts.add('average_watt[]=${Uri.encodeQueryComponent(aw ?? '')}');
            }
          }

          // Add ALL extra therapies (each one separately)
          final extraTherapies = electrotherapyController.getFilledExtraElectrotherapies();
          for (var therapy in extraTherapies) {
            bodyParts.add('newElectroTherapy[]=${Uri.encodeQueryComponent(therapy)}');
          }

          final electroSelectedSnapshot = {
            'patient_id': patientInfoController.patientId.value,
            'selected': selectedElectroOptions,
            'newElectroTherapy': extraTherapies,
          };
          debugPrint('RX ELECTRO SELECTED: ${jsonEncode(electroSelectedSnapshot)}');

          final body = bodyParts.join('&');
          debugPrint('RX ELECTRO REQUEST: $body');

          try {
            final electroResponse = await http.post(
              Uri.parse(Api.updateElectroPresc),
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/x-www-form-urlencoded',
              },
              body: body,
            );

            debugPrint('RX ELECTRO RESPONSE [${electroResponse.statusCode}]: ${electroResponse.body}');

            if (electroResponse.statusCode == 200 || electroResponse.statusCode == 201) {
              storedTherapies.add("Electrotherapy");
            } else {
              errorMessages.add("Electrotherapy: ${electroResponse.body}");
            }
          } catch (e) {
            errorMessages.add("Electrotherapy: $e");
          }
        }
      } catch (e) {
        errorMessages.add("Electrotherapy: $e");
      }
    }

    // ========== 2. Store Manual, Miscellaneous, and Speech Language Therapy Data ==========
    List<int> manualSpeechIds = [];
    List<int?> therapySubcategoryIds = [];
    List<String?> notes = [];

    // Manual Therapy
    if (manualTherapyController.selectedTherapies.isNotEmpty) {
      for (var category in manualTherapyController.categories) {
        if (category.isSelected) {
          // If category has subcategories
          if (category.subcategories != null &&
              category.subcategories!.isNotEmpty) {
            for (int i = 0; i < category.subcategories!.length; i++) {
              if (category.subcategorySelections![i]) {
                // Add only subcategory ID, not category ID
                therapySubcategoryIds.add(category.subcategories![i].id);
                notes.add(
                  category.subcategoryNotes![i].isNotEmpty
                      ? category.subcategoryNotes![i]
                      : null,
                );
              }
            }
          } else {
            // Category has no subcategories, add category ID to manualSpeechIds
            manualSpeechIds.add(category.id ?? 0);
            notes.add(null);
          }
        }
      }
    }

    // Miscellaneous Therapy
    if (miscellaneousTherapyController.selectedTherapies.isNotEmpty) {
      for (var category in miscellaneousTherapyController.categories) {
        if (category.isSelected && category.subcategories.isNotEmpty) {
          for (var sub in category.subcategories) {
            if (sub.isSelected) {
              // Add only subcategory ID
              therapySubcategoryIds.add(sub.id);
              notes.add(
                sub.note != null && sub.note!.isNotEmpty ? sub.note : null,
              );
            }
          }
        }
      }
    }

    // Speech Language Therapy
    if (speechLanguageTherapyController.selectedTherapies.isNotEmpty) {
      for (var category in speechLanguageTherapyController.categories) {
        if (category.isSelected) {
          // If category has subcategories
          if (category.subcategories != null &&
              category.subcategories!.isNotEmpty) {
            for (var sub in category.subcategories!) {
              if (sub.isSelected) {
                // Add only subcategory ID
                therapySubcategoryIds.add(sub.id);
                notes.add(
                  sub.note != null && sub.note!.isNotEmpty ? sub.note : null,
                );
              }
            }
          } else {
            // Category has no subcategories, add category ID to manualSpeechIds
            manualSpeechIds.add(category.id ?? 0);
            notes.add(null);
          }
        }
      }
    }

    // Submit all other therapies to the shared API in one request if any selected
    final manualCustom = manualTherapyController.getFilledCustomTherapies();
    final miscCustom = miscellaneousTherapyController.getFilledCustomTherapies();
    final speechCustom = speechLanguageTherapyController.getFilledCustomTherapies();
    final hasCustomTherapies = manualCustom.isNotEmpty || miscCustom.isNotEmpty || speechCustom.isNotEmpty;

    if (manualSpeechIds.isNotEmpty || therapySubcategoryIds.isNotEmpty || hasCustomTherapies) {
      
      /// ✅ Check patient_id
      final patientId = patientInfoController.patientId.value;
      if (patientId == '0') {
        errorMessages.add("Invalid patient ID. Cannot submit other therapy without patient.");
      } else {
        try {
          /// ✅ FIX: Manually build form-encoded body to support MULTIPLE values per key
          final bodyParts = <String>[];
          
          // Add scalar field
          bodyParts.add('patient_id=${Uri.encodeQueryComponent(patientId.toString())}');

          // Add array fields with [] suffix - each element separately
          for (var id in manualSpeechIds) {
            bodyParts.add('manualSpeechIds[]=${Uri.encodeQueryComponent(id.toString())}');
          }
          for (var id in therapySubcategoryIds) {
            bodyParts.add('therapySubcategoryIds[]=${Uri.encodeQueryComponent(id?.toString() ?? '')}');
          }
          // ✅ FIX: Only add non-empty notes to avoid backend foreach() error
          for (var note in notes) {
            if (note != null && note.isNotEmpty) {
              bodyParts.add('note[]=${Uri.encodeQueryComponent(note)}');
            }
          }

          // Add custom therapies with indexed format
          int customTherapyIndex = 0;
          for (var therapy in manualCustom) {
            bodyParts.add('otherTherapy[$customTherapyIndex][new_manual_speech_name]=${Uri.encodeQueryComponent(therapy)}');
            bodyParts.add('otherTherapy[$customTherapyIndex][new_manual_speech_type]=${Uri.encodeQueryComponent('Manual Therapy')}');
            customTherapyIndex++;
          }
          for (var therapy in miscCustom) {
            bodyParts.add('otherTherapy[$customTherapyIndex][new_manual_speech_name]=${Uri.encodeQueryComponent(therapy)}');
            bodyParts.add('otherTherapy[$customTherapyIndex][new_manual_speech_type]=${Uri.encodeQueryComponent('Miscellaneous Therapy')}');
            customTherapyIndex++;
          }
          for (var therapy in speechCustom) {
            bodyParts.add('otherTherapy[$customTherapyIndex][new_manual_speech_name]=${Uri.encodeQueryComponent(therapy)}');
            bodyParts.add('otherTherapy[$customTherapyIndex][new_manual_speech_type]=${Uri.encodeQueryComponent('Speech and Language Therapy')}');
            customTherapyIndex++;
          }

          final otherSelectedSnapshot = {
            'patient_id': patientId,
            'manualSpeechIds': manualSpeechIds,
            'therapySubcategoryIds': therapySubcategoryIds,
            'note': notes,
            'otherTherapy': [
              ...manualCustom.map((item) => {
                    'new_manual_speech_name': item,
                    'new_manual_speech_type': 'Manual Therapy',
                  }),
              ...miscCustom.map((item) => {
                    'new_manual_speech_name': item,
                    'new_manual_speech_type': 'Miscellaneous Therapy',
                  }),
              ...speechCustom.map((item) => {
                    'new_manual_speech_name': item,
                    'new_manual_speech_type': 'Speech and Language Therapy',
                  }),
            ],
          };
          debugPrint('RX OTHER SELECTED: ${jsonEncode(otherSelectedSnapshot)}');

          final body = bodyParts.join('&');
          debugPrint('RX OTHER REQUEST: $body');

          final response = await http.post(
            Uri.parse(Api.updateotherallPresc),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: body,
          );

          debugPrint('RX OTHER RESPONSE [${response.statusCode}]: ${response.body}');

          if (response.statusCode == 200 || response.statusCode == 201) {
            /// ✅ FIX: Check BOTH standard therapies AND custom therapies
            if (manualTherapyController.selectedTherapies.isNotEmpty || manualCustom.isNotEmpty) {
              storedTherapies.add("Manual Therapy");
            }
            if (miscellaneousTherapyController.selectedTherapies.isNotEmpty || miscCustom.isNotEmpty) {
              storedTherapies.add("Miscellaneous Therapy");
            }
            if (speechLanguageTherapyController.selectedTherapies.isNotEmpty || speechCustom.isNotEmpty) {
              storedTherapies.add("Speech Language Therapy");
            }
          } else {
            errorMessages.add(
              "Other therapy submission failed: ${response.body}",
            );
          }
        } catch (e) {
          errorMessages.add("Other therapy error: $e");
        }
      }
    }


    // ========== 3. Show Result ==========
    if (storedTherapies.isNotEmpty) {
      String message =
          storedTherapies.length == 1
              ? "${storedTherapies.first} stored successfully"
              : "${storedTherapies.join(', ')} stored successfully";

      Get.snackbar(
        "Prescription Stored",
        message,
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: QuickTechAppColors.white,
      );
      return 200;
    } else if (errorMessages.isNotEmpty) {
      Get.snackbar(
        "Error",
        errorMessages.first,
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: QuickTechAppColors.white,
      );
      return 400;
    }
    return 500;
  }

  void clearAllRxData() {
    try {
      // Clear electrotherapy parameters and text controllers
      // Use the controller's clearAllSelections to preserve expected keys
      electrotherapyController.clearAllSelections();

      // Also clear any TextEditingController contents to reset UI inputs
      try {
        electrotherapyController.textControllers.forEach((optionName, tcMap) {
          tcMap.forEach((paramName, controller) {
            controller.clear();
          });
        });
      } catch (e) {
      }

      // Clear manual therapy selections - use proper method
      manualTherapyController.clearAllSelections();

      // Clear miscellaneous therapy selections
      miscellaneousTherapyController.clearAllSelections();

      // Clear speech language therapy selections
      speechLanguageTherapyController.clearAllSelections();

    } catch (e) {
    }
  }
}
