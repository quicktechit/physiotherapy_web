class TherapyCategory {
  int? id;
  String name;
  bool isSelected;
  List<TherapySubcategory>? subcategories;
  List<bool>? subcategorySelections;
  List<String>? subcategoryNotes;

  TherapyCategory({
    this.id,
    required this.name,
    this.isSelected = false,
    this.subcategories,
    this.subcategorySelections,
    this.subcategoryNotes,
  });

  factory TherapyCategory.fromApiJson(Map<String, dynamic> json) {
    List<TherapySubcategory> subs = [];
    if (json['therapy_subcategories'] != null) {
      subs = (json['therapy_subcategories'] as List)
          .map((e) => TherapySubcategory.fromApiJson(e))
          .toList();
    }
    return TherapyCategory(
      id: json['id'],
      name: json['name'],
      isSelected: false,
      subcategories: subs.isNotEmpty ? subs : null,
      subcategorySelections: subs.isNotEmpty ? List.filled(subs.length, false) : null,
      subcategoryNotes: subs.isNotEmpty ? List.filled(subs.length, '') : null,
    );
  }
}

class TherapySubcategory {
  int? id;
  String name;
  String valueType;
  bool isSelected;
  String? note;

  TherapySubcategory({
    this.id,
    required this.name,
    required this.valueType,
    this.isSelected = false,
    this.note,
  });

  factory TherapySubcategory.fromApiJson(Map<String, dynamic> json) {
    return TherapySubcategory(
      id: json['id'],
      name: json['name'],
      valueType: json['value_type'] ?? 'Without note',
      isSelected: false,
      note: null,
    );
  }

  factory TherapySubcategory.fromJson(Map<String, dynamic> json) {
    return TherapySubcategory(
      id: json['id'],
      name: json['name'],
      valueType: json['value_type'] ?? 'Without note',
      isSelected: false,
      note: null,
    );
  }
}