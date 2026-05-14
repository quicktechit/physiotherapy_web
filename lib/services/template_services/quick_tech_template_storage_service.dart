
import 'package:get_storage/get_storage.dart';

class QuickTechTemplateStorageService {
	static final GetStorage _box = GetStorage();
	static const String _templateIdKey = 'selected_template_id';

	static void saveSelectedTemplateId(String id) {
		_box.write(_templateIdKey, id);
	}

	static dynamic getSelectedTemplateId() {
		return _box.read(_templateIdKey);
	}

	static void clearSelectedTemplateId() {
		_box.remove(_templateIdKey);
	}
}
