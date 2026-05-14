class SpeechLanguageTherapySubcategory {
  final int? id;
  final String name;
  bool isSelected;
  String? note;

  SpeechLanguageTherapySubcategory({
    this.id,
    required this.name,
    this.isSelected = false,
    this.note,
  });

  factory SpeechLanguageTherapySubcategory.fromJson(Map<String, dynamic> json) {
    return SpeechLanguageTherapySubcategory(
      id: json['id'],
      name: json['name'],
      isSelected: false,
      note: null,
    );
  }
}

class SpeechLanguageTherapy {
  final int? id;
  final String name;
  final List<SpeechLanguageTherapySubcategory>? subcategories;
  bool isSelected;

  SpeechLanguageTherapy({
    this.id,
    required this.name,
    this.subcategories,
    this.isSelected = false,
  });

  factory SpeechLanguageTherapy.fromJson(Map<String, dynamic> json) {
    List<SpeechLanguageTherapySubcategory>? subs;
    if (json['therapy_subcategories'] != null) {
      subs = (json['therapy_subcategories'] as List)
          .map((e) => SpeechLanguageTherapySubcategory.fromJson(e))
          .toList();
    }
    return SpeechLanguageTherapy(
      id: json['id'],
      name: json['name'],
      subcategories: subs,
    );
  }
}
