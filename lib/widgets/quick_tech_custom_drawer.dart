import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/package_controller/quick_tech_package_controller.dart';
import 'package:e_prescription/controllers/profile_controller/quick_tech_profile_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/add_prescription/quick_tech_add_prescription_form.dart';
import 'package:e_prescription/screens/packages/quick_tech_packages.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_prescription/controllers/authentication_controller/login_controller/quick_tech_login_controller.dart';
import 'package:e_prescription/locator.dart';

import '../responsive.dart';

final themeController = locator.get<QuickTechThemeController>();
final profileController = locator.get<QuickTechProfileController>();
final packageController = locator.get<QuickTechPackageController>();
Widget customDrawer(BuildContext context) {
  // Do NOT call fetchProfile() here — the controller already calls it in
  // onInit(), and calling it on every drawer open triggers redundant API
  // requests and causes the "multiple fetchProfile" log spam.
  return Obx(
    () => Drawer(
      backgroundColor:
          themeController.isDay.value
              ? QuickTechAppColors.lightScaffoldColor
              : QuickTechAppColors.darkScaffoldColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color:
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaincolor
                      : QuickTechAppColors.darkmaincolor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                profileController.profilePhoto.value.isNotEmpty
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(
                          // profilePhoto from API starts with '/' so strip it
                          // to avoid a double-slash in the URL.
                          "${Api.baseUrl}/${profileController.profilePhoto.value.replaceFirst(RegExp(r'^/+'), '')}",
                        ),
                        radius: 40.r,
                      )
                    : CircleAvatar(
                        backgroundColor: QuickTechAppColors.white,
                        radius: 40.r,
                        backgroundImage: AssetImage('assets/images/mainlogo.png'),
                      ),
                SizedBox(height: 8.h),
                Text(
                  profileController.name.value.isNotEmpty
                      ? profileController.name.value
                      : 'Therapy Center',
                  style: myStyle(
                    Responsive.isDesktop(context)?14.w: 14.sp,
                    QuickTechAppColors.darkmaintextcolor,
                    FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Home',
              style: myStyle(
                Responsive.isDesktop(context)?18.w:14.sp,
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor
                      : QuickTechAppColors.darkmaintextcolor,
                  FontWeight.w600,
                ),
            ),
            onTap: () {
              Get.offNamed('/mainhome');
            },
          ),
          ListTile(
            title: Text(
              'Add Prescription',
              style: myStyle(
                Responsive.isDesktop(context)?14.w:14,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
                FontWeight.w600,
              ),
            ),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.off(()=> QuickTechPrescriptionForm());
              });
            },
          ),
          ListTile(
            title: Text(
              'Add Assessment',
              style: myStyle(
                Responsive.isDesktop(context)?14.w: 14.sp,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
                FontWeight.w600,
              ),
            ),
            onTap: () {
              Get.offNamed('/addassessment');
            },
          ),
          ListTile(
            title: Text(
              'Patient List',
              style: myStyle(
                Responsive.isDesktop(context)?14.w:14.sp,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
                FontWeight.w600,
              ),
            ),
            onTap: () {
              Get.toNamed('/patientrecords');
            },
          ),

          ListTile(
            title: Text(
              'Packages',
              style: myStyle(
                Responsive.isDesktop(context)?14.w:14.sp,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
                FontWeight.w600,
              ),
            ),
            onTap: () {
              Get.off(() => QuickTechPackages());
            },
          ),
          ListTile(
            title: Text(
              'Templates',
              style: myStyle(
                Responsive.isDesktop(context)?14.w:14.sp,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
                FontWeight.w600,
              ),
            ),
            onTap: () {
              Get.toNamed('/templateselect');
            },
          ),
          ListTile(
            title: Text(
              'Profile',
              style: myStyle(
                Responsive.isDesktop(context)?14.w: 14.sp,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
                FontWeight.w600,
              ),
            ),
            onTap: () {
              Get.toNamed('/profile');
            },
          ),
          ListTile(
            title: Text(
              'Settings',
              style: myStyle(
                Responsive.isDesktop(context)?14.w: 14.sp,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
                FontWeight.w600,
              ),
            ),
            onTap: () {
              Get.toNamed('/settings');
            },
          ),
          ListTile(
            title: Text(
              'Logout',
              style: myStyle(
                Responsive.isDesktop(context)?14.w:14.sp,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
                FontWeight.w600,
              ),
            ),
            onTap: () async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: Text('Confirm Logout'),
                      content: Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(result: false),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Get.back(result: true),
                          child: Text('Logout'),
                        ),
                      ],
                    ),
              );
              if (shouldLogout == true) {
                
                final loginController = locator.get<QuickTechLoginController>();
                await loginController.logout();
              }
            },
          ),
        ],
      ),
    ),
  );
}
