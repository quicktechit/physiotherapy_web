import 'package:e_prescription/utils/api.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class QuickTechAssessmentController extends GetxController {
  final diagnosisCategories = <DiagnosisCategorys>[].obs;
  final isLoadingDiagnosisCategories = false.obs;
  var isLoading = false.obs;

  final Map<String, int> _categoryIdByName = <String, int>{};
  Future<void>? _categoriesFetchFuture;

  Future<void> _ensureDiagnosisCategoryIndexLoaded() async {
    if (_categoryIdByName.isNotEmpty) return;
    if (_categoriesFetchFuture != null) return _categoriesFetchFuture;

    _categoriesFetchFuture = () async {
      final url = '${Api.baseUrl}/api/only/diagnosis-categories';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) return;

      final data = json.decode(response.body);
      final List<dynamic> categoriesJson = data['diagnosis_categories'] ?? [];
      for (final dynamic raw in categoriesJson) {
        if (raw is Map<String, dynamic>) {
          final name = raw['name']?.toString();
          final idRaw = raw['id'];
          final id = int.tryParse(idRaw?.toString() ?? '');
          if (name != null && name.trim().isNotEmpty && id != null) {
            _categoryIdByName[name] = id;
          }
        }
      }
    }();

    try {
      await _categoriesFetchFuture;
    } finally {
      // Keep the fetched cache; clear the in-flight future.
      _categoriesFetchFuture = null;
    }
  }

  Future<int?> getDiagnosisCategoryIdByName(String name) async {
    await _ensureDiagnosisCategoryIndexLoaded();
    return _categoryIdByName[name];
  }

  Future<void> fetchAssesmentId( String name,
      Future<void> Function(int) fetchDiagnosisCategoryFn,) async {
    isLoading.value = true;
    try {
      final id = await getDiagnosisCategoryIdByName(name);
      if (id != null) {
        await fetchDiagnosisCategoryFn(id);
      }
    } finally {
      isLoading.value = false;
    }
}
  void showOthersDialog(
    BuildContext context, {
    required String label,
    required ValueChanged<String> onChanged,
    String? dialogTitle,
    String? dialogHint,
  }) {
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(dialogTitle ?? 'Add  $label'),
            content: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: dialogHint ?? 'Enter $label',
              ),
            ),
            actions: [
              TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
              TextButton(
                onPressed: () {
                  final customValue = textController.text.trim();
                  if (customValue.isNotEmpty) {
                    onChanged(customValue);
                  }
                  Get.back();
                },
                child: Text('Add'),
              ),
            ],
          ),
    );
  }
}


class DiagnosisChildCategory {
  final int id;
  final String name;

  DiagnosisChildCategory({required this.id, required this.name});

  factory DiagnosisChildCategory.fromJson(Map<String, dynamic> json) {
    return DiagnosisChildCategory(
      id: json['id'],
      name: json['name'],
    );
  }
}

class DiagnosisSubCategory {
  final int id;
  final String name;
  final List<DiagnosisChildCategory> childCategories;

  DiagnosisSubCategory({
    required this.id,
    required this.name,
    required this.childCategories,
  });

  factory DiagnosisSubCategory.fromJson(Map<String, dynamic> json) {
    var children = <DiagnosisChildCategory>[];
    if (json['diagnosis_childcategories'] != null) {
      children = (json['diagnosis_childcategories'] as List)
          .map((e) => DiagnosisChildCategory.fromJson(e))
          .toList();
    }
    return DiagnosisSubCategory(
      id: json['id'],
      name: json['name'],
      childCategories: children,
    );
  }
}

class DiagnosisCategorys {
  final int id;
  final String name;
  final List<DiagnosisSubCategory> subCategories;

  DiagnosisCategorys({
    required this.id,
    required this.name,
    required this.subCategories,
  });

  factory DiagnosisCategorys.fromJson(Map<String, dynamic> json) {
    var subs = <DiagnosisSubCategory>[];
    if (json['diagnosis_subcategories'] != null) {
      subs = (json['diagnosis_subcategories'] as List)
          .map((e) => DiagnosisSubCategory.fromJson(e))
          .toList();
    }
    return DiagnosisCategorys(
      id: json['id'],
      name: json['name'],
      subCategories: subs,
    );
  }
}
