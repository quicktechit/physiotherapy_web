import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/authentication_controller/login_controller/quick_tech_login_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/screens/authentications/registration/quick_tech_registration.dart';

import 'package:e_prescription/widgets/quick_tech_custom_button.dart';
import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../responsive.dart';

class QuickTechLogin extends StatelessWidget {
  QuickTechLogin({Key? key}) : super(key: key);
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechLoginController loginController = locator.get<QuickTechLoginController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final shouldPop = await loginController.onWillPop();
        if (shouldPop) {
          Navigator.of(context).pop();
        }
      },
      child: Obx(
            () => Scaffold(
          backgroundColor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightScaffoldColor
                  : QuickTechAppColors.darkScaffoldColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.isDesktop(context)?100.w: 30.w,vertical:  20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/mainlogo.png',
                      height: 150.h,
                      width: 150.w,
                    ),
                  ),

                  Center(
                    child: Text(
                      'E-Prescription',
                      style: myStyle(
                        Responsive.isDesktop(context)?12.sp: 22.sp,
                        QuickTechAppColors.lightmaincolor,
                        FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Text(
                    'Phone Number',
                    style: myStyle(
                      Responsive.isDesktop(context)?6.sp: 12.sp,
                      themeController.isDay.value
                          ? QuickTechAppColors.lightsecondarycolor
                          : QuickTechAppColors.darksecondarytextcolor,
                      FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Obx(
                    () => QuickTechCustomTextField(
                      icon: Icons.person,
                      iconcolor:
                          themeController.isDay.value
                              ? QuickTechAppColors.lightmaintextcolor
                              : QuickTechAppColors.darkmaintextcolor,
                      hint: 'Phone Number',
                      lebelcolor:
                          themeController.isDay.value
                              ? QuickTechAppColors.lightsecondarytextcolor
                              : QuickTechAppColors.darksecondarytextcolor,

                      backcolor:
                          themeController.isDay.value
                              ? QuickTechAppColors.bktxtfld
                              : QuickTechAppColors.bkdarktxtfld,

                      label: 'Phone Number',
                      validator: loginController.validatePhoneNumber,
                      controller: loginController.phonenumberController,

                      keyboardType: TextInputType.phone,
                    ),
                  ),
           8.verticalSpace,
                  // Password Field
                  Text(
                    'Password',
                    style: myStyle(
                      Responsive.isDesktop(context)?6.sp: 12.sp,
                      themeController.isDay.value
                          ? QuickTechAppColors.lightsecondarycolor
                          : QuickTechAppColors.darksecondarytextcolor,
                      FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Obx(
                    () => QuickTechCustomTextField(
                      iconcolor:
                          themeController.isDay.value
                              ? QuickTechAppColors.lightmaintextcolor
                              : QuickTechAppColors.darkmaintextcolor,
                      icon: Icons.password,
                      onSuffixIconPressed: () {
                        loginController.togglePasswordVisibility();
                      },
                      backcolor:
                          themeController.isDay.value
                              ? QuickTechAppColors.bktxtfld
                              : QuickTechAppColors.bkdarktxtfld,
                      hint: 'Enter Your Password',
                      lebelcolor:
                          themeController.isDay.value
                              ? QuickTechAppColors.lightsecondarytextcolor
                              : QuickTechAppColors.darksecondarytextcolor,
                      label: 'Password',
                      validator: loginController.validatePassword,
                      controller: loginController.passwordController,
                      obscureText: !loginController.isPasswordVisible.value,
                      suffixicon:
                          loginController.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                      suffixiconColor:
                          themeController.isDay.value
                              ? QuickTechAppColors.lightsecondarycolor
                              : QuickTechAppColors.darksecondarytextcolor,
                    ),
                  ),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed('/forgotpass');
                      },
                      child: Text(
                        'Forgot Password?',
                        style: myStyle(
                          Responsive.isDesktop(context)?5.sp:12.sp,
                          themeController.isDay.value
                              ? QuickTechAppColors.lightsecondarycolor
                                  .withValues(alpha: 0.8)
                              : QuickTechAppColors.darksecondarycolor
                                  .withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                  ),
                 6.verticalSpace,
                  // Login Button
                  Obx(
                    () => QuickTechCustomButton(
                      onTab:
                          loginController.isLoading.value
                              ? null
                              : () {
                                loginController.login();
                              },
                      color:
                          themeController.isDay.value
                              ? QuickTechAppColors.lightmaincolor
                              : QuickTechAppColors.darkmaincolor,
                      title:
                          loginController.isLoading.value
                              ? 'Logging in...'
                              : 'Login',
                      height: 40.h,
                      width: double.infinity,
                    ),
                  ),
                  8.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: myStyle(
                          Responsive.isDesktop(context)?5.sp:  12.sp,
                          themeController.isDay.value
                              ? QuickTechAppColors.lightsecondarytextcolor
                                  .withValues(alpha: 0.8)
                              : QuickTechAppColors.darksecondarytextcolor
                                  .withValues(alpha: 0.8),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                     Get.to(()=> QuickTechRegistration());
                        },
                        child: Text(
                          'Sign Up',
                          style: myStyle(
                            Responsive.isDesktop(context)?6.sp: 14.sp,
                            themeController.isDay.value
                                ? QuickTechAppColors.lightmaincolor
                                : QuickTechAppColors.darkmaincolor,
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  8.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(onTap: () {
                      loginController.googleSignIn();
                      },
                        child: ClipOval(
                          child: Image.asset(
                            'assets/icons/google.png',
                            height: 50.h,
                            width: 50.w,
                          ),
                        ),
                      ),

                      // ClipOval(
                      //   child: Image.asset(
                      //     'assets/icons/facebook.png',
                      //     height: 70,
                      //     width: 70,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
