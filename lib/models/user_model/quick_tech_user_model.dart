import 'dart:convert';


class QuickTechUserModel {
  final int? id;
  final String? firstName;
  final int? verifyToken;
  final String? lastName;
  final String? mobile;
  final String? profilePhoto;
  final String? email;
  final String? createdBy;
  final String? updatedBy;
  final String? permissions;
  final String? lastLogin;
  final int? isDeleted;
  final String? createdAt;
  final String? updatedAt;

  QuickTechUserModel({
    this.id,
    this.firstName,
    this.verifyToken,
    this.lastName,
    this.mobile,
    this.profilePhoto,
    this.email,
    this.createdBy,
    this.updatedBy,
    this.permissions,
    this.lastLogin,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory QuickTechUserModel.fromJson(Map<String, dynamic> json) {
    return QuickTechUserModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? ''),
      firstName: json['first_name']?.toString(),
      verifyToken: json['verifyToken'] is int ? json['verifyToken'] : int.tryParse(json['verifyToken']?.toString() ?? ''),
      lastName: json['last_name']?.toString(),
      mobile: json['mobile']?.toString(),
      profilePhoto: json['profile_photo']?.toString(),
      email: json['email']?.toString(),
      createdBy: json['created_by']?.toString(),
      updatedBy: json['updated_by']?.toString(),
      permissions: json['permissions']?.toString(),
      lastLogin: json['last_login']?.toString(),
      isDeleted: json['is_deleted'] is int ? json['is_deleted'] : int.tryParse(json['is_deleted']?.toString() ?? ''),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'verifyToken': verifyToken,
      'last_name': lastName,
      'mobile': mobile,
      'profile_photo': profilePhoto,
      'email': email,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'permissions': permissions,
      'last_login': lastLogin,
      'is_deleted': isDeleted,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  static QuickTechUserModel fromRawJson(String str) => QuickTechUserModel.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());
}
