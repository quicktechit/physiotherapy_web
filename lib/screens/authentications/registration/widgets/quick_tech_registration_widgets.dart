
import 'dart:io' as io;

import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';

import 'package:e_prescription/widgets/quick_tech_custom_text_style.dart';
import 'package:e_prescription/controllers/authentication_controller/registration_controller/quick_tech_registration_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_prescription/locator.dart';

final QuickTechRegistrationController registrationController =
    locator.get<QuickTechRegistrationController>();
final QuickTechThemeController themeController =
    locator.get<QuickTechThemeController>();

final bool isDay = themeController.isDay.value;

// ✅ WEB-SAFE: Profile image widget with improved styling
Widget customProfileImageSection() {
  return Column(
    children: [
      GestureDetector(
        onTap: registrationController.pickImage,
        child: Obx(() {
          final xfile = registrationController.profileImage.value;
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              width: 120.r,
              height: 120.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    QuickTechAppColors.lightmaincolor.withValues(alpha: 0.2),
                    QuickTechAppColors.lightmaincolor.withValues(alpha: 0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: QuickTechAppColors.lightmaincolor.withValues(
                    alpha: 0.5,
                  ),
                  width: 2.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: QuickTechAppColors.lightmaincolor.withValues(
                      alpha: 0.15,
                    ),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Image or placeholder
                  if (xfile == null)
                    Icon(
                      Icons.person_outline,
                      size: 50.sp,
                      color: QuickTechAppColors.lightmaincolor.withValues(
                        alpha: 0.6,
                      ),
                    )
                  else if (kIsWeb)
                    FutureBuilder<List<int>>(
                      future: xfile.readAsBytes(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ClipOval(
                            child: Image.memory(
                              Uint8List.fromList(snapshot.data!),
                              fit: BoxFit.cover,
                              width: 120.r,
                              height: 120.r,
                            ),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(
                            color: QuickTechAppColors.lightmaincolor,
                            strokeWidth: 2.5,
                          );
                        }
                        return Icon(
                          Icons.camera_alt_outlined,
                          size: 40.sp,
                          color: QuickTechAppColors.lightmaincolor,
                        );
                      },
                    )
                  else
                    FutureBuilder<bool>(
                      future: _fileExists(xfile.path),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data == true) {
                          return ClipOval(
                            child: Image.file(
                              io.File(xfile.path),
                              fit: BoxFit.cover,
                              width: 120.r,
                              height: 120.r,
                            ),
                          );
                        }
                        return Icon(
                          Icons.camera_alt_outlined,
                          size: 40.sp,
                          color: QuickTechAppColors.lightmaincolor,
                        );
                      },
                    ),

                  // Camera icon overlay
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: QuickTechAppColors.lightmaincolor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              themeController.isDay.value
                                  ? const Color(0xFFF4F6FA)
                                  : QuickTechAppColors.darkScaffoldColor,
                          width: 2.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: QuickTechAppColors.lightmaincolor.withValues(
                              alpha: 0.3,
                            ),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
      SizedBox(height: 12.h),
      Text(
        'Click to upload photo',
        style: QuickTechAppTextStyle.bodyText3().copyWith(
          fontSize: 11.sp,
          color:
              themeController.isDay.value
                  ? const Color(0xFF64748B)
                  : Colors.grey[400],
        ),
      ),
    ],
  );
}

// Helper function to check if file exists on native platforms
Future<bool> _fileExists(String path) async {
  if (kIsWeb) return false;
  try {
    return await io.File(path).exists();
  } catch (e) {
    return false;
  }
}

Widget customForm() {
  return Column(
    children: [
      QuickTechCustomTextField(
        label: 'Full Name',
        controller: registrationController.fullNameController,
        icon: Icons.person_outline,
        keyboardType: TextInputType.name,
        onchanged: (v) {},
      ),
      SizedBox(height: 14.h),
      QuickTechCustomTextField(
        label: 'Email Address',
        controller: registrationController.emailController,
        icon: Icons.email_outlined,
        keyboardType: TextInputType.emailAddress,
        onchanged: (v) {},
      ),
      SizedBox(height: 14.h),
      QuickTechCustomTextField(
        label: 'Phone Number',
        controller: registrationController.phoneController,
        icon: Icons.phone_outlined,
        keyboardType: TextInputType.phone,
        onchanged: (v) {},
      ),
      SizedBox(height: 14.h),
      QuickTechCustomTextField(
        label: 'Address',
        controller: registrationController.addressController,
        icon: Icons.location_on_outlined,
        keyboardType: TextInputType.streetAddress,
        onchanged: (v) {},
      ),
      SizedBox(height: 14.h),
      QuickTechCustomTextField(
        label: 'Password',
        controller: registrationController.passwordController,
        icon: Icons.lock_outline,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        onchanged: (v) {},
      ),
      SizedBox(height: 14.h),
      QuickTechCustomTextField(
        label: 'Confirm Password',
        controller: registrationController.confirmPasswordController,
        icon: Icons.lock_open_outlined,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        onchanged: (v) {},
      ),
    ],
  );
}

Widget customErrorText() {
  return Obx(
    () => Text(
      registrationController.errorMessage.value,
      style: QuickTechAppTextStyle.bodyText1().copyWith(
        fontSize: 12.sp,
        color: Colors.red[700],
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
