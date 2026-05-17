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



class QuickTechSplashScreen extends StatefulWidget {
  const QuickTechSplashScreen({Key? key}) : super(key: key);

  @override
  State<QuickTechSplashScreen> createState() => _QuickTechSplashScreenState();
}

class _QuickTechSplashScreenState extends State<QuickTechSplashScreen> {
  final QuickTechSplashScreenController splashScreenController =
      locator.get<QuickTechSplashScreenController>();
  final QuickTechThemeController themeController =
      locator.get<QuickTechThemeController>();

  @override
  void initState() {
    super.initState();
    // Call startNavigation in initState, not in build(), so it fires exactly
    // once and does not reschedule on hot-restart / rebuild.
    splashScreenController.startNavigation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Responsive(
        mobile: MobileSplash(context),
        tablet: TabletSplash(context),
        desktop: DesktopSplash(context),
      ),
    );
  }

  // ── Mobile Layout ──
  Widget MobileSplash(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/mainlogo.png',
            height: 200.h,
            width: 200.w,
          ),
          SizedBox(height: 20.h),
          Text(
            'E-Prescription',
            style: myStyle(
              22.sp,
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
              FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Digital Prescriptions for PhysioTherapists',
              textAlign: TextAlign.center,
              style: myStyle(
                13.sp,
                themeController.isDay.value
                    ? QuickTechAppColors.lightsecondarytextcolor
                    : QuickTechAppColors.darksecondarytextcolor,
                FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 40.h),
          CustomSpinner(),
        ],
      ),
    );
  }

  // ── Tablet Layout ──
  Widget TabletSplash(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/mainlogo.png',
            height: 260.h,
            width: 260.w,
          ),
          SizedBox(height: 28.h),
          Text(
            'E-Prescription',
            style: myStyle(
              26.sp,
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
              FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              'Digital Prescriptions for PhysioTherapists',
              textAlign: TextAlign.center,
              style: myStyle(
                15.sp,
                themeController.isDay.value
                    ? QuickTechAppColors.lightsecondarytextcolor
                    : QuickTechAppColors.darksecondarytextcolor,
                FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 50.h),
          CustomSpinner(),
        ],
      ),
    );
  }

  // ── Desktop Layout ──
  Widget DesktopSplash(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/mainlogo.png',
            height: 320.h,
            width: 320.w,
          ),
          SizedBox(height: 36.h),
          Text(
            'E-Prescription',
            style: myStyle(
              32.sp,
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
              FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: 500.w,
            child: Text(
              'Digital Prescriptions for PhysioTherapists',
              textAlign: TextAlign.center,
              style: myStyle(
                17.sp,
                themeController.isDay.value
                    ? QuickTechAppColors.lightsecondarytextcolor
                    : QuickTechAppColors.darksecondarytextcolor,
                FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 60.h),
          CustomSpinner(),
        ],
      ),
    );
  }
}
