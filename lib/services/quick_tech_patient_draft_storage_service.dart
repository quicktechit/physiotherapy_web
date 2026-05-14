import 'package:get_storage/get_storage.dart';

class QuickTechPatientDraft {
  final String name;
  final String phone;

  const QuickTechPatientDraft({required this.name, required this.phone});
}

class QuickTechPatientDraftStorageService {
  static final GetStorage _box = GetStorage();

  static const String _keyName = 'patientDraft.name';
  static const String _keyPhone = 'patientDraft.phone';

  static Future<void> saveDraft({required String name, required String phone}) async {
    await _box.write(_keyName, name.trim());
    await _box.write(_keyPhone, phone.trim());
  }

  static QuickTechPatientDraft? readDraft() {
    final name = _box.read<String>(_keyName);
    final phone = _box.read<String>(_keyPhone);

    if (name == null || name.trim().isEmpty) return null;
    if (phone == null || phone.trim().isEmpty) return null;

    return QuickTechPatientDraft(name: name.trim(), phone: phone.trim());
  }

  static Future<void> clearDraft() async {
    await _box.remove(_keyName);
    await _box.remove(_keyPhone);
  }
}
