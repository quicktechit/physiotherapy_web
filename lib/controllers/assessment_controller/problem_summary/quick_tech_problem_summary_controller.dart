import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:e_prescription/services/quick_tech_retry_service.dart';
import 'dart:convert';
var token=QuickTechAuthStorageService.getToken();
class QuickTechProblemSummaryController extends GetxController{
  TextEditingController problemListController = TextEditingController();
  TextEditingController goalListController = TextEditingController();
  TextEditingController treatmentPlanController = TextEditingController();

    Future<int> storeSummaryAdvice(int patientId) async {
      final url = Uri.parse('${Api.baseUrl}/api/problem-goal-plan/store');
      final data = {
        'patient_id': patientId,
        'problem_list': problemListController.text,
        'goal': goalListController.text,
        'treatment_plan': treatmentPlanController.text,
      };
      try {
        final response = await retryRequest(() => http.post(
              url,
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token'
              },
              body: jsonEncode(data),
            ));
        print('Summary advice status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return response.statusCode;
      } catch (e) {
        print('Error storing summary-goal-plan: $e');
        return 500;
      }
    }

  bool isProblemSummaryNull(){
    return problemListController.text.isNotEmpty||
    goalListController.text.isNotEmpty||
    treatmentPlanController.text.isNotEmpty;
  }
  /// Standardized: returns true when section has data to display
  bool hasData() => isProblemSummaryNull();

  void clearProblemSummary() {
    problemListController.clear();
    goalListController.clear();
    treatmentPlanController.clear();
    update();
  }
  
}