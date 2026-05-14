// models/diagnosis_model.dart
class DiagnosisCategory {
  final int id;
  final String name;
  final List<DiagnosisSubcategory> subcategories;

  DiagnosisCategory({
    required this.id,
    required this.name,
    required this.subcategories,
  });

  factory DiagnosisCategory.fromJson(Map<String, dynamic> json) {
    return DiagnosisCategory(
      id: json['id'],
      name: json['name'],
      subcategories: (json['diagnosis_subcategories'] as List<dynamic>)
          .map((sub) => DiagnosisSubcategory.fromJson(sub))
          .toList(),
    );
  }
}

class DiagnosisSubcategory {
  final int id;
  final int categoryId;
  final String type;
  final String name;
  final List<DiagnosisChildcategory> childcategories;

  DiagnosisSubcategory({
    required this.id,
    required this.categoryId,
    required this.type,
    required this.name,
    required this.childcategories,
  });

  factory DiagnosisSubcategory.fromJson(Map<String, dynamic> json) {
    return DiagnosisSubcategory(
      id: json['id'],
      categoryId: json['diagnosis_category_id'],
      type: json['type'],
      name: json['name'],
      childcategories: (json['diagnosis_childcategories'] as List<dynamic>)
          .map((child) => DiagnosisChildcategory.fromJson(child))
          .toList(),
    );
  }
}

class DiagnosisChildcategory {
  final int id;
  final int categoryId;
  final int subcategoryId;
  final String type;
  final String name;

  DiagnosisChildcategory({
    required this.id,
    required this.categoryId,
    required this.subcategoryId,
    required this.type,
    required this.name,
  });

  factory DiagnosisChildcategory.fromJson(Map<String, dynamic> json) {
    return DiagnosisChildcategory(
      id: json['id'],
      categoryId: json['diagnosis_category_id'],
      subcategoryId: json['diagnosis_subcategory_id'],
      type: json['type'],
      name: json['name'],
    );
  }
}