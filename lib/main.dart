// main.dart
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setUp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// Determine design size based on screen width
  Size _getDesignSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Mobile
    if (width < 600) {
      return const Size(375, 812);
    }
    // Tablet
    else if (width < 1024) {
      return const Size(768, 1024);
    }
    // Desktop / Large Web
    else {
      return const Size(1440, 900);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeController = locator.get<QuickTechThemeController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final designSize = _getDesignSize(context);

        return ScreenUtilInit(
          designSize: designSize,
          minTextAdapt: true,
          splitScreenMode: true,
          useInheritedMediaQuery: true,
          builder: (context, child) {
            return GetMaterialApp(
                title: 'PhysioTherapy',
                debugShowCheckedModeBanner: false,
                initialRoute: '/',
                getPages: AppPages.pages,
                themeMode: themeController.currentTheme,

                // Light Theme
                theme: ThemeData(
                  primarySwatch: Colors.teal,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  useMaterial3: true,
                ),

                // Dark Theme
                darkTheme: ThemeData(
                  brightness: Brightness.dark,
                  primarySwatch: Colors.teal,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  useMaterial3: true,
                ),

                // Prevent browser text scaling from breaking layout
                builder: (context, widget) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaler: const TextScaler.linear(1.0),
                    ),
                    child: widget!,
                  );
                },
              );
          },
        );
      },
    );
  }
}