

class ElectrotherapyCategory {
  final String name;
  final List<ElectrotherapyOption> options;

  ElectrotherapyCategory({required this.name, required this.options});
}

class ElectrotherapyOption {
  final int id;
  final String name;
  final List<ElectrotherapyPerameter> parameters;

  ElectrotherapyOption({required this.id, required this.name, required this.parameters});
}

class ElectrotherapyPerameter {
  final String name;
  final ParameterType type;
  final List<String>? options; // Display names for UI
  final List<int>? areaIds;    // Store area IDs for backend/API
  final String? unit;
  final String? range;

  /// When storing selected area options, always use areaIds (int) not names.
  /// The UI should display names, but selection and API should use IDs.
  ElectrotherapyPerameter({
    required this.name,
    required this.type,
    this.options,
    this.areaIds,
    this.unit,
    this.range,
  });
}

enum ParameterType {
  textInput,
  singleSelect,
  multiSelect,
}

class ElectrotherapyPrescription {
  final String category;
  final String option;
  final Map<String, dynamic> parameters;
  final DateTime createdAt;

  ElectrotherapyPrescription({
    required this.category,
    required this.option,
    required this.parameters,
  }) : createdAt = DateTime.now();
}

/// ✅ NEW: Model for extra/custom electrotherapy (Others)
class ExtraElectrotherapy {
  final String name;

  ExtraElectrotherapy({required this.name});

  /// Convert to JSON for API submission
  Map<String, dynamic> toJson() => {'name': name};
}

class ElectroTherapy {
  final int id;
  final String name;
  final String type;
  final List<TherapyArea> therapyAreas;

  ElectroTherapy({
    required this.id,
    required this.name,
    required this.type,
    required this.therapyAreas,
  });

  factory ElectroTherapy.fromJson(Map<String, dynamic> json) {
    return ElectroTherapy(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      therapyAreas: (json['therapy_areas'] as List)
          .map((e) => TherapyArea.fromJson(e))
          .toList(),
    );
  }
}

class TherapyArea {
  final int id;
  final String name;

  TherapyArea({required this.id, required this.name});

  factory TherapyArea.fromJson(Map<String, dynamic> json) {
    return TherapyArea(
      id: json['id'],
      name: json['name'],
    );
  }
}