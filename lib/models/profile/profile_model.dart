class Profile {
  final String? message;
  final User? user;

  Profile({
    this.message,
    this.user,
  });

  Profile.fromJson(Map<String, dynamic> json)
    : message = json['message'] as String?,
      user = (json['user'] as Map<String,dynamic>?) != null ? User.fromJson(json['user'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'message' : message,
    'user' : user?.toJson()
  };
}

class User {
  final int? id;
  final String? centerName;
  final String? centerAddress;
  final String? bnFirstName;
  final String? firstName;
  final String? therapyCenter;
  final String? bnTherapyCenter;
  final String? designation;
  final String? bnDesignation;
  final String? clinicAddress;
  final String? bnClinicAddress;
  final String? verifyToken;
  final String? passresetToken;
  final String? lastName;
  final String? mobile;
  final String? address;
  final String? profilePhoto;
  final String? email;
  final String? createdBy;
  final String? updatedBy;
  final String? permissions;
  final String? lastLogin;
  final String? isDeleted;
  final String? createdAt;
  final String? updatedAt;

  User({
    this.id,
    this.centerName,
    this.centerAddress,
    this.bnFirstName,
    this.firstName,
    this.therapyCenter,
    this.bnTherapyCenter,
    this.designation,
    this.bnDesignation,
    this.clinicAddress,
    this.bnClinicAddress,
    this.verifyToken,
    this.passresetToken,
    this.lastName,
    this.mobile,
    this.address,
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

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        centerName = json['center_name']?.toString(),
        centerAddress = json['center_address']?.toString(),
        bnFirstName = json['bn_first_name']?.toString(),
        firstName = json['first_name']?.toString(),
        therapyCenter = json['therapy_center']?.toString(),
        bnTherapyCenter = json['bn_therapy_center']?.toString(),
        designation = json['designation']?.toString(),
        bnDesignation = json['bn_designation']?.toString(),
        clinicAddress = json['clinic_address']?.toString(),
        bnClinicAddress = json['bn_clinic_address']?.toString(),
        verifyToken = json['verifyToken']?.toString(),
        passresetToken = json['passresetToken']?.toString(),
        lastName = json['last_name']?.toString(),
        mobile = json['mobile']?.toString(),
        address = json['address']?.toString(),
        profilePhoto = json['profile_photo']?.toString(),
        email = json['email']?.toString(),
        createdBy = json['created_by']?.toString(),
        updatedBy = json['updated_by']?.toString(),
        permissions = json['permissions']?.toString(),
        lastLogin = json['last_login']?.toString(),
        isDeleted = json['is_deleted']?.toString(),
        createdAt = json['created_at']?.toString(),
        updatedAt = json['updated_at']?.toString();

  Map<String, dynamic> toJson() => {
    'id' : id,
    'center_name' : centerName,
    'center_address' : centerAddress,
    'bn_first_name' : bnFirstName,
    'first_name' : firstName,
    'therapy_center' : therapyCenter,
    'bn_therapy_center' : bnTherapyCenter,
    'designation' : designation,
    'bn_designation' : bnDesignation,
    'clinic_address' : clinicAddress,
    'bn_clinic_address' : bnClinicAddress,
    'verifyToken' : verifyToken,
    'passresetToken' : passresetToken,
    'last_name' : lastName,
    'mobile' : mobile,
    'address' : address,
    'profile_photo' : profilePhoto,
    'email' : email,
    'created_by' : createdBy,
    'updated_by' : updatedBy,
    'permissions' : permissions,
    'last_login' : lastLogin,
    'is_deleted' : isDeleted,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}