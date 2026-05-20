
class DiagnosisCategoryResponse {
    String? message;
    List<DiagnosisCategories>? diagnosisCategories;

    DiagnosisCategoryResponse({this.message, this.diagnosisCategories});

    DiagnosisCategoryResponse.fromJson(Map<String, dynamic> json) {
        message = json["message"];
        diagnosisCategories = json["diagnosis_categories"] == null ? null : (json["diagnosis_categories"] as List).map((e) => DiagnosisCategories.fromJson(e)).toList();
    }

    static List<DiagnosisCategoryResponse> fromList(List<Map<String, dynamic>> list) {
        return list.map(DiagnosisCategoryResponse.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["message"] = message;
        if(diagnosisCategories != null) {
            _data["diagnosis_categories"] = diagnosisCategories?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class DiagnosisCategories {
    int? id;
    String? name;
    String? createdAt;
    String? updatedAt;
    List<DiagnosisSubcategories>? diagnosisSubcategories;

    DiagnosisCategories({this.id, this.name, this.createdAt, this.updatedAt, this.diagnosisSubcategories});

    DiagnosisCategories.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        name = json["name"];
        createdAt = json["created_at"];
        updatedAt = json["updated_at"];
        diagnosisSubcategories = json["diagnosis_subcategories"] == null ? null : (json["diagnosis_subcategories"] as List).map((e) => DiagnosisSubcategories.fromJson(e)).toList();
    }

    static List<DiagnosisCategories> fromList(List<Map<String, dynamic>> list) {
        return list.map(DiagnosisCategories.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["name"] = name;
        _data["created_at"] = createdAt;
        _data["updated_at"] = updatedAt;
        if(diagnosisSubcategories != null) {
            _data["diagnosis_subcategories"] = diagnosisSubcategories?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class DiagnosisSubcategories {
    int? id;
    String? diagnosisCategoryId;
    String? type;
    String? appShow;
    String? name;
    String? createdAt;
    String? updatedAt;
    List<DiagnosisChildcategories>? diagnosisChildcategories;

    DiagnosisSubcategories({this.id, this.diagnosisCategoryId, this.type, this.appShow, this.name, this.createdAt, this.updatedAt, this.diagnosisChildcategories});

    DiagnosisSubcategories.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        diagnosisCategoryId = json["diagnosis_category_id"];
        type = json["type"];
        appShow = json["app_show"];
        name = json["name"];
        createdAt = json["created_at"];
        updatedAt = json["updated_at"];
        diagnosisChildcategories = json["diagnosis_childcategories"] == null ? null : (json["diagnosis_childcategories"] as List).map((e) => DiagnosisChildcategories.fromJson(e)).toList();
    }

    static List<DiagnosisSubcategories> fromList(List<Map<String, dynamic>> list) {
        return list.map(DiagnosisSubcategories.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["diagnosis_category_id"] = diagnosisCategoryId;
        _data["type"] = type;
        _data["app_show"] = appShow;
        _data["name"] = name;
        _data["created_at"] = createdAt;
        _data["updated_at"] = updatedAt;
        if(diagnosisChildcategories != null) {
            _data["diagnosis_childcategories"] = diagnosisChildcategories?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class DiagnosisChildcategories {
    int? id;
    String? diagnosisCategoryId;
    String? diagnosisSubcategoryId;
    String? type;
    String? name;
    String? createdAt;
    String? updatedAt;

    DiagnosisChildcategories({this.id, this.diagnosisCategoryId, this.diagnosisSubcategoryId, this.type, this.name, this.createdAt, this.updatedAt});

    DiagnosisChildcategories.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        diagnosisCategoryId = json["diagnosis_category_id"];
        diagnosisSubcategoryId = json["diagnosis_subcategory_id"];
        type = json["type"];
        name = json["name"];
        createdAt = json["created_at"];
        updatedAt = json["updated_at"];
    }

    static List<DiagnosisChildcategories> fromList(List<Map<String, dynamic>> list) {
        return list.map(DiagnosisChildcategories.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["diagnosis_category_id"] = diagnosisCategoryId;
        _data["diagnosis_subcategory_id"] = diagnosisSubcategoryId;
        _data["type"] = type;
        _data["name"] = name;
        _data["created_at"] = createdAt;
        _data["updated_at"] = updatedAt;
        return _data;
    }
}