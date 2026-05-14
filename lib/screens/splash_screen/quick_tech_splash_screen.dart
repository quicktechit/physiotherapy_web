import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/splash_screen/quick_tech_splash_screen_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/widgets/quick_tech_custom_spinner.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../responsive.dart';



class QuickTechSplashScreen extends StatelessWidget {
  QuickTechSplashScreen({Key? key}) : super(key: key);

  final QuickTechSplashScreenController splashScreenController = locator.get<QuickTechSplashScreenController>();
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      splashScreenController.startNavigation();
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/mainlogo.png',
              height: 250.h,
              width: 250.w,
            ),
            Text(
              'E-Prescription',
              style: myStyle(
                Responsive.isDesktop(context)?10.sp:  26.sp,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaincolor
                    : QuickTechAppColors.darkmaincolor,
                FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            // Tagline
            Text(
              'Digital Prescriptions for PhysioTherapists',
              textAlign: TextAlign.center,
              style: myStyle(
                Responsive.isDesktop(context)?6.sp:  18.sp,
                themeController.isDay.value
                    ? QuickTechAppColors.lightsecondarytextcolor
                    : QuickTechAppColors.darksecondarytextcolor,
                FontWeight.bold,
              ),
            ),
            SizedBox(height: 50.h),
            CustomSpinner(),
          ],
        ),
      ),
    );
  }
}
