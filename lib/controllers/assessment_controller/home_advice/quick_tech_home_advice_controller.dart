import 'dart:convert';

import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:e_prescription/services/quick_tech_retry_service.dart';
import 'package:http/http.dart' as http;
var token=QuickTechAuthStorageService.getToken();
class QuickTechHomeAdviceController extends GetxController{
  TextEditingController homeAdviceController=TextEditingController();
  bool isHomeAdviceNull(){
    return homeAdviceController.text.isNotEmpty;
  }

  /// Standardized: returns true when section has data to display
  bool hasData() => isHomeAdviceNull();

  Future<int> storeHomeAdvice({required int patientId,}) async {

    final url = Uri.parse('${Api.baseUrl}/api/home-advice/store');
    try {
      final response = await retryRequest(() => http.post(
            url,
            body: jsonEncode({
              'patient_id': patientId,
              'home_advice': homeAdviceController.text,
            }),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ));
      print('Home advice status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response.statusCode;
    } catch (e) {
      print('Error storing home advice: $e');
      return 500;
    }
  }

  void clearHomeAdvice() {
    homeAdviceController.clear();
    update();
  }
} 