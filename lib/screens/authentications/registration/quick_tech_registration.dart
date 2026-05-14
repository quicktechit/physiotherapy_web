import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/screens/authentications/registration/widgets/quick_tech_registration_widgets.dart';
import 'package:e_prescription/widgets/quick_tech_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickTechRegistration extends StatelessWidget {
  QuickTechRegistration({super.key});

  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

  @override
  Widget build(BuildContext context) {
  

      registrationController.clearAllFields();
      return Obx(() => Scaffold(
        backgroundColor:
            themeController.isDay.value
                ? QuickTechAppColors.lightScaffoldColor
                : QuickTechAppColors.darkScaffoldColor,
        appBar: AppBar(
          backgroundColor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightScaffoldColor
                  : QuickTechAppColors.darkScaffoldColor,
          title: Text(
            'Registration',
            style: myStyle(
              22,
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
              FontWeight.bold,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              registrationController.clearAllFields();
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_sharp,
              color:
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor
                      : QuickTechAppColors.darkmaintextcolor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal:  60.w,vertical: 20.w),
          child: Obx(
            () => Column(
              children: [
                customProfileImageSection(),
                SizedBox(height: 20.h),
                customForm(),
                SizedBox(height: 20.h),
                QuickTechCustomButton(
                  onTab: () {
                    registrationController.register();
                  },
                  color:
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaincolor
                          : QuickTechAppColors.darkmaincolor,
                  title: 'Registration',
                  height: 50.h,
                  width: double.infinity,
                ),
                SizedBox(height: 10.h),
                // customSocialRegistrationButton(),
                if (registrationController.errorMessage.isNotEmpty)
                  customErrorText(),
              ],
            ),
          ),
        ),
      ));
}
}