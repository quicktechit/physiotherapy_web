import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class QuickTechThemeController extends GetxController {
  final _storage = GetStorage();
  RxBool isDay = RxBool(true);

  // Theme data
  ThemeMode get currentTheme => isDay.value ? ThemeMode.light : ThemeMode.dark;

  @override
  void onInit() {
    super.onInit();

    isDay.value = _storage.read('isDay') ?? true;
  }

  void toggleTheme() {
    isDay.value = !isDay.value;
    _storage.write('isDay', isDay.value);
    Get.changeThemeMode(currentTheme);
  }
}
