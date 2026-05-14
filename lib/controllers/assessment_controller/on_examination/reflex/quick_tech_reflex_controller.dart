import 'package:e_prescription/controllers/assessment_controller/on_examination/quick_tech_on_examination_controller.dart';
import 'package:e_prescription/models/assessment/reflex/reflex_model.dart';
import 'package:e_prescription/utils/api.dart';

import 'dart:convert';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';
import 'package:http/http.dart' as http;




class QuickTechReflexController extends GetxController {
  var selectedOptions = <String, List<String>>{}.obs;
  var selectedReflexIds = <String, int?>{}.obs; // title -> id (nullable)
  var selectedCategory = ''.obs;
  var customReflexName = ''.obs;
  var reflexList = <DeepTendon>[].obs;
  var allReflexes = <ReflexModel>[].obs; // Store all reflexes from API
  var isLoadingReflexes = false.obs;
  var reflexesError = ''.obs;
  var reflexCategories = <String>[].obs;
  final QuickTechOnExaminationController onExaminationController = locator.get<QuickTechOnExaminationController>();

  // Reflex grades fetched 
  var reflexGrades = <ReflexGrades>[].obs;
  var isLoadingGrades = false.obs;
  var gradesError = ''.obs;

  // Prevent duplicate fetches
  bool _reflexesFetched = false;
  bool _gradesFetched = false;

  @override
  void onInit() {
    super.onInit();
    // Don't fetch here - let OnExaminationController handle it
  }

  Future<void> fetchAllReflexes() async {
    if (_reflexesFetched) return; // Skip if already fetched
    _reflexesFetched = true;
    // isLoadingReflexes.value = true;
    reflexesError.value = '';
    try {
      final response = await http.get(Uri.parse('${Api.baseUrl}/api/reflex/all'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['reflexes'] != null) {
          allReflexes.value = List<ReflexModel>.from(
            (data['reflexes'] as List<dynamic>).map((e) => ReflexModel.fromJson(e)),
          );
          // ReflexModel.name is nullable, so filter out nulls
          reflexCategories.value = allReflexes.map((e) => e.name ?? '').where((e) => e.isNotEmpty).toList();
          print('Loaded ${allReflexes.length} reflex models');
        } else {
          reflexesError.value = 'No reflexes found.';
        }
      } else {
        reflexesError.value = 'Failed to fetch reflexes: ${response.statusCode}';
      }
    } catch (e) {
      print('Error fetching reflexes: $e');
      reflexesError.value = 'Error: ${e.toString()}';
    } finally {
      // isLoadingReflexes.value = false;
    }
  }

  Future<void> fetchReflexGrades() async {
    if (_gradesFetched) return; // Skip if already fetched
    _gradesFetched = true;
    isLoadingGrades.value = true;
    gradesError.value = '';
    try {
      final response = await http.get(Uri.parse('${Api.baseUrl}/api/reflex/grades'));
      print('Reflex grades response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final gradeModel = ReflexGrade.fromJson(data);
        reflexGrades.clear(); // Ensure no type mismatch from previous values
        if (gradeModel.reflexGrades != null && gradeModel.reflexGrades!.isNotEmpty) {
          reflexGrades.addAll(gradeModel.reflexGrades!);
          print('Loaded ${gradeModel.reflexGrades!.length} reflex grades');
        } else {
          gradesError.value = 'No grades found.';
          print('No grades found in response');
        }
      } else {
        gradesError.value = 'Failed to fetch grades: ${response.statusCode}';
        print('Failed to fetch grades: ${response.statusCode}');
        _gradesFetched = false; // Reset flag to retry on 429
      }
    } catch (e) {
      gradesError.value = 'Error: ${e.toString()}';
      print('Error fetching reflex grades: $e');
      _gradesFetched = false; // Reset flag on error
    } finally {
      isLoadingGrades.value = false;
    }
  }

  void updateSelectedOption(String title, String option) {
    if (!selectedOptions.containsKey(title)) {
      selectedOptions[title] = [];
    }
    if (selectedOptions[title]!.contains(option)) {
      selectedOptions[title]!.remove(option);
    } else {
      selectedOptions[title]!.add(option);
      // Store deep tendon id for this title if not already stored
      final tendon = reflexList.firstWhereOrNull((r) => r.name == title);
      if (tendon != null) {
        selectedReflexIds[title] = tendon.id;
      }
    }
    selectedOptions.refresh();
    selectedReflexIds.refresh();
    onExaminationController.updateReflex(selectedOptions);  
  }

  bool isOptionSelected(String title, String option) {
    return selectedOptions[title]?.contains(option) ?? false;
  }

  void setCategory(String title) {
    customReflexName.value = '';
    selectedCategory.value = title;
    updateReflexforCategory(title);
  }

  void updateReflexforCategory(String title) {
    final reflex = allReflexes.firstWhereOrNull((e) => e.name == title);
    if (reflex != null && reflex.deepTendons != null && reflex.deepTendons!.isNotEmpty) {
      reflexList.value = reflex.deepTendons!;
    } else {
      reflexList.clear();
    }
    selectedOptions.clear();
    selectedReflexIds.clear();
  }
}