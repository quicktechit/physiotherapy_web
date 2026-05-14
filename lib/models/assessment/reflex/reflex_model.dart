

class ReflexSubcategory {
  final int? id;
  final String? deepTendonId;
  final String? numericValue;
  final String? textValue;
  final String? createdAt;
  final String? updatedAt;

  ReflexSubcategory({
    this.id,
    this.deepTendonId,
    this.numericValue,
    this.textValue,
    this.createdAt,
    this.updatedAt,
  });

  factory ReflexSubcategory.fromJson(Map<String, dynamic> json) {
    return ReflexSubcategory(
      id: json['id'],
      deepTendonId: json['deep_tendon_id'],
      numericValue: json['numeric_value'],
      textValue: json['text_value'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}


class DeepTendon {
  final int? id;
  final String? reflexId;
  final String? name;
  final String? type;
  final String? createdAt;
  final String? updatedAt;
  final List<ReflexSubcategory>? reflexSubcategories;

  DeepTendon({
    this.id,
    this.reflexId,
    this.name,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.reflexSubcategories,
  });

  factory DeepTendon.fromJson(Map<String, dynamic> json) {
    return DeepTendon(
      id: json['id'],
      reflexId: json['reflex_id'],
      name: json['name'],
      type: json['type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      reflexSubcategories: (json['reflex_subcategories'] as List<dynamic>?)?.map((e) => ReflexSubcategory.fromJson(e)).toList(),
    );
  }
}


class ReflexModel {
  final int? id;
  final String? name;
  final String? createdAt;
  final String? updatedAt;
  final List<DeepTendon>? deepTendons;

  ReflexModel({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deepTendons,
  });

  factory ReflexModel.fromJson(Map<String, dynamic> json) {
    return ReflexModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deepTendons: (json['deep_tendons'] as List<dynamic>?)?.map((e) => DeepTendon.fromJson(e)).toList(),
    );
  }
}

class ReflexGrade {
  final String? message;
  final List<ReflexGrades>? reflexGrades;

  ReflexGrade({
    this.message,
    this.reflexGrades,
  });

  ReflexGrade.fromJson(Map<String, dynamic> json)
    : message = json['message'] as String?,
      reflexGrades = (json['reflex_grades'] as List?)?.map((dynamic e) => ReflexGrades.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'message' : message,
    'reflex_grades' : reflexGrades?.map((e) => e.toJson()).toList()
  };
}

class ReflexGrades {
  final int? id;
  final String? fieldType;
  final String? numericValue;
  final String? textValue;
  final String? createdAt;
  final String? updatedAt;

  ReflexGrades({
    this.id,
    this.fieldType,
    this.numericValue,
    this.textValue,
    this.createdAt,
    this.updatedAt,
  });

  ReflexGrades.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      fieldType = json['field_type'] as String?,
      numericValue = json['numeric_value'] as String?,
      textValue = json['text_value'] as String?,
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'field_type' : fieldType,
    'numeric_value' : numericValue,
    'text_value' : textValue,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}