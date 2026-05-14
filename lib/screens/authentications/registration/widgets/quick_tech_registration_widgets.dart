
import 'dart:io';


import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/authentication_controller/registration_controller/quick_tech_registration_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_prescription/locator.dart';

final QuickTechRegistrationController registrationController = locator.get<QuickTechRegistrationController>();
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

final bool isDay = themeController.isDay.value;

// ✅ WEB-SAFE: Profile image widget that works on both web and native
Widget customProfileImageSection() {
  return Column(
    children: [
      GestureDetector(
        onTap: registrationController.pickImage,
        child: Obx(
          () {
            final xfile = registrationController.profileImage.value;
            return CircleAvatar(
              radius: 50.r,
              backgroundColor: QuickTechAppColors.greyOpacity5,
              // ✅ Use web-safe image helper
              backgroundImage: xfile != null
                  ? (kIsWeb
                      ? null // Will use child widget instead on web
                      : null)
                  : null,
              child: xfile != null && kIsWeb
                  ? FutureBuilder<List<int>>(
                      future: xfile.readAsBytes(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ClipOval(
                            child: Image.memory(
                              Uint8List.fromList(snapshot.data!),
                              fit: BoxFit.cover,
                              width: 100.r,
                              height: 100.r,
                            ),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        return Icon(Icons.camera_alt, size: 40.sp);
                      },
                    )
                  : xfile != null && !kIsWeb
                      ? ClipOval(
                          child: Image.file(
                            File(xfile.path),
                            fit: BoxFit.cover,
                            width: 100.r,
                            height: 100.r,
                          ),
                        )
                      : Icon(
                          Icons.camera_alt,
                          size: 40.sp,
                          color: themeController.isDay.value
                              ? QuickTechAppColors.lightScaffoldColor
                              : QuickTechAppColors.darkScaffoldColor,
                        ),
            );
          },
        ),
      ),
    ],
  );
}

Widget customForm() {
  return Obx(
    () => Column(
      children: [
        QuickTechCustomTextField(
          lebelcolor:
              isDay
                  ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                  : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
          keyboardType: TextInputType.name,
          label: 'Full Name',
          controller: registrationController.fullNameController,
          icon: Icons.person,
          iconcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
          backcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.bktxtfld
                  : QuickTechAppColors.bkdarktxtfld,
          txtcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
        ),
        QuickTechCustomTextField(
          lebelcolor:
              isDay
                  ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                  : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
          keyboardType: TextInputType.emailAddress,
          label: 'Email',
          controller: registrationController.emailController,
          icon: Icons.email,
          iconcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
          backcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.bktxtfld
                  : QuickTechAppColors.bkdarktxtfld,
          txtcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
        ),

        QuickTechCustomTextField(
          lebelcolor:
              isDay
                  ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                  : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
          keyboardType: TextInputType.phone,
          label: 'Phone Number',
          controller: registrationController.phoneController,
          icon: Icons.phone,
          iconcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
          backcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.bktxtfld
                  : QuickTechAppColors.bkdarktxtfld,
          txtcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
        ),

        QuickTechCustomTextField(
          lebelcolor:
              isDay
                  ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                  : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
          keyboardType: TextInputType.streetAddress,
          label: 'Address',
          controller: registrationController.addressController,
          icon: Icons.location_on,
          iconcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
          backcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.bktxtfld
                  : QuickTechAppColors.bkdarktxtfld,
          txtcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
        ),
        QuickTechCustomTextField(
          lebelcolor:
              isDay
                  ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                  : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
          keyboardType: TextInputType.visiblePassword,
          label: 'Password',
          controller: registrationController.passwordController,
          icon: Icons.lock,
          iconcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
          backcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.bktxtfld
                  : QuickTechAppColors.bkdarktxtfld,
          txtcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
          obscureText: true,
        ),
        QuickTechCustomTextField(
          lebelcolor:
              isDay
                  ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                  : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
          keyboardType: TextInputType.visiblePassword,
          label: 'Confirm Password',
          controller: registrationController.confirmPasswordController,
          icon: Icons.lock_outline,
          iconcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
          backcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.bktxtfld
                  : QuickTechAppColors.bkdarktxtfld,
          txtcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
          obscureText: true,
        ),
      ],
    ),
  );
}

Widget customSocialRegistrationButton() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ClipOval(
        child: Image.asset('assets/icons/google.png', height: 50.h, width: 50.w),
      ),
      ClipOval(
        child: Image.asset('assets/icons/facebook.png', height: 70.h, width: 70.w),
      ),
    ],
  );
}

Widget customErrorText() {
  return Padding(
    padding: EdgeInsets.only(top: 10.h),
    child: Text(
      registrationController.errorMessage.value,
      style: myStyle(10.sp, Colors.red),
      textAlign: TextAlign.center,
    ),
  );
}
