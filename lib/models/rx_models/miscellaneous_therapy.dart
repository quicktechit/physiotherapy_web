class TherapySubcategory {
  final int id;
  final String name;
  final String valueType; // "With note" or "Without note"
  String? note; // For storing note if needed
  bool isSelected;

  TherapySubcategory({
    required this.id,
    required this.name,
    required this.valueType,
    this.note,
    this.isSelected = false,
  });

  factory TherapySubcategory.fromJson(Map<String, dynamic> json) {
    return TherapySubcategory(
      id: json['id'],
      name: json['name'],
      valueType: json['value_type'],
    );
  }
}

class MiscellaneousTherapy {
  final int id;
  final String name;
  final List<TherapySubcategory> subcategories;
  bool isSelected;

  MiscellaneousTherapy({
    required this.id,
    required this.name,
    required this.subcategories,
    this.isSelected = false,
  });

  factory MiscellaneousTherapy.fromJson(Map<String, dynamic> json) {
    return MiscellaneousTherapy(
      id: json['id'],
      name: json['name'],
      subcategories: (json['therapy_subcategories'] as List)
          .map((e) => TherapySubcategory.fromJson(e))
          .toList(),
    );
  }

  MiscellaneousTherapy copyWith({
    int? id,
    String? name,
    List<TherapySubcategory>? subcategories,
    bool? isSelected,
  }) {
    return MiscellaneousTherapy(
      id: id ?? this.id,
      name: name ?? this.name,
      subcategories: subcategories ?? this.subcategories,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}