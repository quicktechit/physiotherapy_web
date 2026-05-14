import 'dart:convert';
import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:e_prescription/services/quick_tech_retry_service.dart';
  var token=QuickTechAuthStorageService.getToken();
class QuickTechRange0fMotionController extends GetxController {

  Future<int> submitRangeOfMotionData({required int patientId}) async {
    final url = '${Api.baseUrl}/api/muscle-power-rom/store';
    final body = {
      'add_type': 'rom',
      'patient_id': patientId,
      'upper_movement': uppermovementController.text,
      'upper_muscle': uppermusclenameController.text,
      'upper_initial_left': upperleftInitialROMController.text,
      'upper_initial_right': upperrightInitialROMController.text,
      'upper_discharge_left': upperleftDischargeROMController.text,
      'upper_discharge_right': upperrightDischargeROMController.text,
      'upper_comment': upperCommentController.text,
      'oxford_muscle_grading': oxfordMuscle.value,
      'lower_movement': lowermovementController.text,
      'lower_muscle': lowermusclenameController.text,
      'lower_initial_left': lowerleftInitialROMController.text,
      'lower_initial_right': lowerrightInitialROMController.text,
      'lower_discharge_left': lowerleftDischargeROMController.text,
      'lower_discharge_right': lowerrightDischargeROMController.text,
      'lower_comment': lowerCommentController.text,
    };
    try {
      final response = await retryRequest(() => http.post(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
            body: jsonEncode(body),
          ));
      print('Range of motion status: ${response.statusCode}');
      print('Range of motion response: ${response.body}');
      return response.statusCode;
    } catch (e) {
      print('Error storing range of motion data: $e');
      return 500;
    }
  }
  //Upper Limb
  TextEditingController uppermovementController = TextEditingController();
  TextEditingController uppermusclenameController = TextEditingController();
  TextEditingController upperleftInitialROMController = TextEditingController();
  TextEditingController upperrightInitialROMController = TextEditingController();
  TextEditingController upperleftDischargeROMController = TextEditingController();
  TextEditingController upperrightDischargeROMController = TextEditingController();
  TextEditingController upperCommentController = TextEditingController();
  //Lower limb
  TextEditingController lowermovementController = TextEditingController();
  TextEditingController lowermusclenameController = TextEditingController();
  TextEditingController lowerleftInitialROMController = TextEditingController();
  TextEditingController lowerrightInitialROMController = TextEditingController();
  TextEditingController lowerleftDischargeROMController = TextEditingController();
  TextEditingController lowerrightDischargeROMController = TextEditingController();
  TextEditingController lowerCommentController = TextEditingController();

  var oxfordMuscle = Rx<String?>(null);
  TextEditingController oxfordmuscleController = TextEditingController();
  var oxfordmuscleOptions = ['0', '1', '2', '3', '4', '5'].obs;
  void updateOxfordMuscle(String muscle) {
    oxfordMuscle.value = muscle;
    oxfordmuscleController.text = muscle;
  }
    bool isRangeofMotionnull() {
  return (uppermovementController.text.isNotEmpty) ||
         (uppermusclenameController.text.isNotEmpty) ||
         (upperleftInitialROMController.text.isNotEmpty) ||
         (upperrightInitialROMController.text.isNotEmpty) ||
         (upperleftDischargeROMController.text.isNotEmpty) ||
         (upperrightDischargeROMController.text.isNotEmpty) ||
         (upperCommentController.text.isNotEmpty) ||

         (lowermovementController.text.isNotEmpty) ||
         (lowermusclenameController.text.isNotEmpty) ||
         (lowerleftInitialROMController.text.isNotEmpty) ||
         (lowerrightInitialROMController.text.isNotEmpty) ||
         (lowerleftDischargeROMController.text.isNotEmpty) ||
         (lowerrightDischargeROMController.text.isNotEmpty) ||
         (lowerCommentController.text.isNotEmpty) ||

         (oxfordMuscle.value?.isNotEmpty ?? false); // Oxford muscle value
}

    bool isRangeofMotionNull() {
  return uppermovementController.text.isNotEmpty ||
         uppermusclenameController.text.isNotEmpty ||
         upperleftInitialROMController.text.isNotEmpty ||
         upperrightInitialROMController.text.isNotEmpty ||
         upperleftDischargeROMController.text.isNotEmpty ||
         upperrightDischargeROMController.text.isNotEmpty ||
         upperCommentController.text.isNotEmpty ||

         lowermovementController.text.isNotEmpty ||
         lowermusclenameController.text.isNotEmpty ||
         lowerleftInitialROMController.text.isNotEmpty ||
         lowerrightInitialROMController.text.isNotEmpty ||
         lowerleftDischargeROMController.text.isNotEmpty ||
         lowerrightDischargeROMController.text.isNotEmpty ||
         lowerCommentController.text.isNotEmpty ||

         oxfordMuscle.value != null && oxfordMuscle.value!.isNotEmpty; // Oxford muscle value
}
   /// Standardized: returns true when section has data to display
   bool hasData() => isRangeofMotionNull();

   void printInputs() {
    print("Upper Limb Movement: ${uppermovementController.text}");
    print("Upper Limb Muscle Name: ${uppermusclenameController.text}");
    print("Upper Left Initial ROM: ${upperleftInitialROMController.text}");
    print("Upper Right Initial ROM: ${upperrightInitialROMController.text}");
    print("Upper Left Discharge ROM: ${upperleftDischargeROMController.text}");
    print("Upper Right Discharge ROM: ${upperrightDischargeROMController.text}");
    print("Upper Comment: ${upperCommentController.text}");

    print("Lower Limb Movement: ${lowermovementController.text}");
    print("Lower Limb Muscle Name: ${lowermusclenameController.text}");
    print("Lower Left Initial ROM: ${lowerleftInitialROMController.text}");
    print("Lower Right Initial ROM: ${lowerrightInitialROMController.text}");
    print("Lower Left Discharge ROM: ${lowerleftDischargeROMController.text}");
    print("Lower Right Discharge ROM: ${lowerrightDischargeROMController.text}");
    print("Lower Comment: ${lowerCommentController.text}");

    print("Oxford Muscle Score: ${oxfordMuscle.value}");
  }

  void clearRangeOfMotion() {
    uppermovementController.clear();
    uppermusclenameController.clear();
    upperleftInitialROMController.clear();
    upperrightInitialROMController.clear();
    upperleftDischargeROMController.clear();
    upperrightDischargeROMController.clear();
    upperCommentController.clear();
    lowermovementController.clear();
    lowermusclenameController.clear();
    lowerleftInitialROMController.clear();
    lowerrightInitialROMController.clear();
    lowerleftDischargeROMController.clear();
    lowerrightDischargeROMController.clear();
    lowerCommentController.clear();
    oxfordMuscle.value = null;
    update();
  }
}
