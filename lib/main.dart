import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage first (IndexedDB on web, Shared Preferences on mobile)
  try {
    await GetStorage.init();
  } catch (e) {
    debugPrint('GetStorage init error: $e');
  }

  // Firebase - skip on web to avoid engine initialization conflicts
  if (!kIsWeb) {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      debugPrint('Firebase init error: $e');
    }
  }

  // Setup GetX DI
  try {
    setUp();
  } catch (e) {
    debugPrint('SetUp error: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = locator.get<QuickTechThemeController>();
    return ScreenUtilInit(
      designSize: kIsWeb ? const Size(1440, 900) : const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Obx(
          () => GetMaterialApp(
            themeMode: themeController.currentTheme,
            title: 'PhysioTherapy',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.teal,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: '/',
            getPages: AppPages.pages,
          ),
        );
      },
    );
  }
}
