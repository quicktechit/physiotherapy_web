


import 'dart:convert';
import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:e_prescription/services/quick_tech_retry_service.dart';

class MedicalHistoryItem {
  final int id;
  final String name;
  MedicalHistoryItem({required this.id, required this.name});
  factory MedicalHistoryItem.fromJson(Map<String, dynamic> json) {
    return MedicalHistoryItem(
      id: json['id'],
      name: json['name'],
    );
  }
}

class QuickTechPastMedicalHistoryController extends GetxController {
  // Function to clear all past medical history selections
  void clearPastMedicalHistory() {
    selectedMedicalHistories.updateAll((key, value) => false);
    update();
  }
  // Store past medical history to API
  Future<int> storePastMedicalHistory({required int patientId}) async {
    final token = QuickTechAuthStorageService.getToken();
    final url = Uri.parse('${Api.baseUrl}/api/past-medical/history/store');
    final selectedItems = getSelectedItems();

    final body = {
      'patient_id': patientId,
      'medical_histories': selectedItems,
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
      print('Past medical history status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response.statusCode;
    } catch (e) {
      print('Error storing past medical history: $e');
      return 500;
    }
  }
  var medicalHistories = <MedicalHistoryItem>[].obs;
  var selectedMedicalHistories = <int, bool>{}.obs;
  var isLoading = false.obs;


  Future<void> fetchMedicalHistories() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse('${Api.baseUrl}/api/medical-history/all'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> items = data['medical_histories'];
        medicalHistories.value = items.map((e) => MedicalHistoryItem.fromJson(e)).toList();
    

        // Initialize selection map
        for (var item in medicalHistories) {
          selectedMedicalHistories[item.id] = false;
        }
      }
    } catch (e) {
      // handle error
    } finally {
      isLoading.value = false;
    }
  }

  void updateMedicalHistory(int id, bool value) {
    selectedMedicalHistories[id] = value;
  }

  void addOtherItem(String name) {
    // Add a new custom item to the list and select it
    final newId = (medicalHistories.isNotEmpty ? (medicalHistories.map((e) => e.id).reduce((a, b) => a > b ? a : b) + 1) : 1000);
    final newItem = MedicalHistoryItem(id: newId, name: name);
    medicalHistories.add(newItem);
    selectedMedicalHistories[newId] = true;
  }

  List<String> getSelectedItems() {
    return medicalHistories
        .where((item) => selectedMedicalHistories[item.id] == true)
        .map((item) => item.name)
        .toList();
  }

  bool isAnySelected() {
    return selectedMedicalHistories.values.any((v) => v == true);
  }

  bool hasData() => isAnySelected();

  void clearForm() {
    selectedMedicalHistories.updateAll((key, value) => false);
  }
}
