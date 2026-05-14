import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/controllers/authentication_controller/login_controller/quick_tech_forgot_pass_controller.dart';
import 'package:e_prescription/locator.dart';

import 'package:e_prescription/screens/authentications/login/forgot_password/widgets/quick_tech_forgot_password_widgets.dart';
import 'package:e_prescription/widgets/quick_tech_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickTechForgotPassword extends StatelessWidget {
  QuickTechForgotPassword({super.key});
final QuickTechForgotPassController forgotPassController=locator.get<QuickTechForgotPassController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      isDay
          ? QuickTechAppColors.lightScaffoldColor
          : QuickTechAppColors.darkScaffoldColor,
      appBar: AppBar(
        backgroundColor:
        isDay
            ? QuickTechAppColors.lightScaffoldColor
            : QuickTechAppColors.darkScaffoldColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color:
            isDay
                ? QuickTechAppColors.lightmaintextcolor
                : QuickTechAppColors.darkmaintextcolor,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Obx(
              () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(),
              SizedBox(height: 32.h),
              if (!forgotPassController.otpSent.value)
                buildPhoneNumberField(),
              //if (forgotPassController.otpSent.value) buildOtpField(context),
              SizedBox(height: 24.h),
              QuickTechCustomButton(
                onTab: () {
                  forgotPassController.sendOtp();
                },
                color:
                isDay
                    ? QuickTechAppColors.lightmaincolor
                    : QuickTechAppColors.darkmaincolor,
                height: 50.h,
                width: double.infinity,
                title: 'Send Otp',
              ),
              //buildActionButton(),
              SizedBox(height: 16.h),
              buildMessages(),
            ],
          ),
        ),
      ),
    );
  }
}
