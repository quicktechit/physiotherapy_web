
class Patient {
  final int id;
  final String name;
  final String age;
  final String userId;
  final String gender;
  final String date;

  Patient(this.name, this.age, this.gender, this.date, this.id, this.userId);

  factory Patient.fromJson(Map<String, dynamic> json) {
    // Parse date
    DateTime parsedDate = DateTime.now();
    if (json['prescription_date'] != null) {
      try {
        final parts = json['prescription_date'].toString().split('-');
        if (parts.length == 3) {
          parsedDate = DateTime(
            int.parse(parts[0]),
            int.parse(parts[1]),
            int.parse(parts[2]),
          );
        }
      } catch (_) {}
    } else if (json['created_at'] != null) {
      parsedDate = DateTime.tryParse(json['created_at']) ?? DateTime.now();
    }

    return Patient(
      json['name'] ?? '',
      json['age'] ?? '',
      json['gender'] ?? '',
      parsedDate.toIso8601String().split('T').first,
      json['id'] ?? 0,
      json['user_id'] ?? 0,
    );
  }
}