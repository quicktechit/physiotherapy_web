// Package Model - Main package data
class PackageModel {
  final int id;
  final String template;
  final String type;
  final String title;
  final String dayDuration;
  final String maximumPrescription;
  final String price;
  final String status;
  final String createdAt;
  final String updatedAt;

  PackageModel({
    required this.id,
    required this.template,
    required this.type,
    required this.title,
    required this.dayDuration,
    required this.maximumPrescription,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      template: json['template']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      dayDuration: json['day_duration']?.toString() ?? '',
      maximumPrescription: json['maximum_prescription']?.toString() ?? '',
      price: json['price']?.toString() ?? '0.00',
      status: json['status']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'template': template,
      'type': type,
      'title': title,
      'day_duration': dayDuration,
      'maximum_prescription': maximumPrescription,
      'price': price,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

// All Packages Response
class AllPackagesResponse {
  final String message;
  final List<PackageModel> packages;

  AllPackagesResponse({
    required this.message,
    required this.packages,
  });

  factory AllPackagesResponse.fromJson(Map<String, dynamic> json) {
    return AllPackagesResponse(
      message: json['message'] ?? '',
      packages: (json['packages'] as List<dynamic>?)
              ?.map((e) => PackageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

// Package Payment Model
class PackagePaymentModel {
  final int id;
  final String userId;
  final String totalAmount;
  final String packageId;
  final String invoiceNo;
  final String orderDate;
  final String orderMonth;
  final String orderYear;
  final String status;
  final String? bkashNumber;
  final String? transactionId;
  final String? screenshot;
  final String createdAt;
  final String updatedAt;

  PackagePaymentModel({
    required this.id,
    required this.userId,
    required this.totalAmount,
    required this.packageId,
    required this.invoiceNo,
    required this.orderDate,
    required this.orderMonth,
    required this.orderYear,
    required this.status,
    this.bkashNumber,
    this.transactionId,
    this.screenshot,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PackagePaymentModel.fromJson(Map<String, dynamic> json) {
    return PackagePaymentModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      userId: json['user_id']?.toString() ?? '',
      totalAmount: json['total_amount']?.toString() ?? '0.00',
      packageId: json['package_id']?.toString() ?? '',
      invoiceNo: json['invoice_no']?.toString() ?? '',
      orderDate: json['order_date']?.toString() ?? '',
      orderMonth: json['order_month']?.toString() ?? '',
      orderYear: json['order_year']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      bkashNumber: json['bkash_number']?.toString(),
      transactionId: json['transaction_id']?.toString(),
      screenshot: json['screenshot']?.toString(),
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'total_amount': totalAmount,
      'package_id': packageId,
      'invoice_no': invoiceNo,
      'order_date': orderDate,
      'order_month': orderMonth,
      'order_year': orderYear,
      'status': status,
      'bkash_number': bkashNumber,
      'transaction_id': transactionId,
      'screenshot': screenshot,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

// Package Order Model
class PackageOrderModel {
  final int id;
  final int packagePaymentId;
  final int userId;
  final int packageId;
  final int totalPrescription;
  final String expiredAt;
  final String? paymentMessage;
  final String createdAt;
  final String updatedAt;
  final PackageModel? package;
  final PackagePaymentModel? packagePayment;

  PackageOrderModel({
    required this.id,
    required this.packagePaymentId,
    required this.userId,
    required this.packageId,
    required this.totalPrescription,
    required this.expiredAt,
    this.paymentMessage,
    required this.createdAt,
    required this.updatedAt,
    this.package,
    this.packagePayment,
  });

  factory PackageOrderModel.fromJson(Map<String, dynamic> json) {
    return PackageOrderModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      packagePaymentId: json['package_payment_id'] is int ? json['package_payment_id'] : int.tryParse(json['package_payment_id']?.toString() ?? '0') ?? 0,
      userId: json['user_id'] is int ? json['user_id'] : int.tryParse(json['user_id']?.toString() ?? '0') ?? 0,
      packageId: json['package_id'] is int ? json['package_id'] : int.tryParse(json['package_id']?.toString() ?? '0') ?? 0,
      totalPrescription: json['total_prescription'] is int ? json['total_prescription'] : int.tryParse(json['total_prescription']?.toString() ?? '0') ?? 0,
      expiredAt: json['expired_at']?.toString() ?? '',
      paymentMessage: json['payment_message']?.toString(),
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
      package: json['package'] != null
          ? PackageModel.fromJson(json['package'] as Map<String, dynamic>)
          : null,
      packagePayment: json['package_payment'] != null
          ? PackagePaymentModel.fromJson(
              json['package_payment'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'package_payment_id': packagePaymentId,
      'user_id': userId,
      'package_id': packageId,
      'total_prescription': totalPrescription,
      'expired_at': expiredAt,
      'payment_message': paymentMessage,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'package': package?.toJson(),
      'package_payment': packagePayment?.toJson(),
    };
  }
}

// Subscribe Package Response
class SubscribePackageResponse {
  final String status;
  final String message;
  final PackagePaymentModel packagePayment;
  final PackageOrderModel packageOrder;

  SubscribePackageResponse({
    required this.status,
    required this.message,
    required this.packagePayment,
    required this.packageOrder,
  });

  factory SubscribePackageResponse.fromJson(Map<String, dynamic> json) {
    return SubscribePackageResponse(
      status: json['status']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      packagePayment: PackagePaymentModel.fromJson(
          json['package_payment'] as Map<String, dynamic>),
      packageOrder: PackageOrderModel.fromJson(
          json['package_order'] as Map<String, dynamic>),
    );
  }
}

// Prescription Template Model
class PrescriptionTemplateModel {
  final int id;
  final String templateValue;
  final String packageId;
  final String image;
  final String? createdAt;
  final String? updatedAt;

  PrescriptionTemplateModel({
    required this.id,
    required this.templateValue,
    required this.packageId,
    required this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory PrescriptionTemplateModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionTemplateModel(
      id: json['id'] ?? 0,
      templateValue: json['template_value'] ?? 0,
      packageId: json['package_id'] ?? 0,
      image: json['image'] ?? '',
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'template_value': templateValue,
      'package_id': packageId,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

// User Package Response
class UserPackageResponse {
  final String message;
  final PackageOrderModel packageOrder;
  final List<PrescriptionTemplateModel> templates;
  final String timeRemain;
  final int prescriptionRemain;

  UserPackageResponse({
    required this.message,
    required this.packageOrder,
    required this.templates,
    required this.timeRemain,
    required this.prescriptionRemain,
  });

  factory UserPackageResponse.fromJson(Map<String, dynamic> json) {
    return UserPackageResponse(
      message: json['message'] ?? '',
      packageOrder: PackageOrderModel.fromJson(
          json['package_order'] as Map<String, dynamic>),
      templates: (json['templates'] as List<dynamic>?)
              ?.map((e) =>
                  PrescriptionTemplateModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      timeRemain: json['time_remain'] ?? '',
      prescriptionRemain: json['prescription_remain'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'package_order': packageOrder.toJson(),
      'templates': templates.map((t) => t.toJson()).toList(),
      'time_remain': timeRemain,
      'prescription_remain': prescriptionRemain,
    };
  }
}
