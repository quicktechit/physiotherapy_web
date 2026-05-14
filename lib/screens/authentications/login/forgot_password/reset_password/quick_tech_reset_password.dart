import 'package:e_prescription/const/const.dart';
import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/widgets/quick_tech_custom_button.dart';
import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_prescription/controllers/authentication_controller/login_controller/quick_tech_forgot_pass_controller.dart';

class QuickTechResetPassword extends StatefulWidget {
  final String mobile;
  final String passresetToken;
  const QuickTechResetPassword({
    Key? key,
    required this.mobile,
    required this.passresetToken,
  }) : super(key: key);

  @override
  State<QuickTechResetPassword> createState() => _QuickTechResetPasswordState();
}

class _QuickTechResetPasswordState extends State<QuickTechResetPassword> {
  final QuickTechForgotPassController controller = locator.get<QuickTechForgotPassController>();

  @override
  void initState() {
    super.initState();
    // Optionally clear fields on open
    controller.passwordController.clear();
    controller.confirmController.clear();
    controller.resetErrorText.value = '';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            'Reset Password',
            style: myStyle( Responsive.isDesktop(context)?12.sp: 22.sp, QuickTechAppColors.white, FontWeight.w700),
          ),
          backgroundColor: QuickTechAppColors.lightmaincolor,
          elevation: 0,

          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                QuickTechAppColors.lightmaincolor.withValues(alpha: 0.1),
                Colors.grey[50]!,
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  Text(
                    'Create New Password',
                    style: myStyle(24.sp, Colors.black, FontWeight.w700),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Enter a new password for your account',
                    style: myStyle(16.sp, Colors.grey[600]!, FontWeight.w400),
                  ),
                  SizedBox(height: 32.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.1),
                          spreadRadius: 2.w,
                          blurRadius: 8.r,
                          offset: Offset(0, 2.h),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.phone_android,
                              size: 18.sp,
                              color: QuickTechAppColors.lightmaincolor,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Mobile Number',
                              style: myStyle(
                                14.sp,
                                Colors.grey[600]!,
                                FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          widget.mobile,
                          style: myStyle(16.sp, Colors.black, FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.1),
                          spreadRadius: 2.w,
                          blurRadius: 8.r,
                          offset: Offset(0, 2.h),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        QuickTechCustomTextField(
                          label: 'New Password',
                          controller: controller.passwordController,
                          backcolor: QuickTechAppColors.lightScaffoldColor,
                          height: 50.h,
                          icon: Icons.lock_outline,
                          iconcolor: QuickTechAppColors.lightmaincolor,
                        ),
                        SizedBox(height: 8.h),
                        QuickTechCustomTextField(
                          label: 'Confirm Password',
                          controller: controller.confirmController,
                          backcolor: QuickTechAppColors.lightScaffoldColor,
                          height: 50.h,
                          icon: Icons.lock_outline,
                          iconcolor: QuickTechAppColors.lightmaincolor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  if (controller.resetErrorText.value.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 20.sp,
                            color: Colors.red[700],
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              controller.resetErrorText.value,
                              style: myStyle(14.sp, Colors.red[700]!),
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 16.h),
                  QuickTechCustomButton(
                    onTab:
                        controller.isLoading.value
                            ? null
                            : () => controller.resetPassword(
                              mobile: widget.mobile,
                              passresetToken: widget.passresetToken,
                            ),
                    color: QuickTechAppColors.lightmaincolor,
                    title:
                        controller.isLoading.value
                            ? 'Processing...'
                            : 'Reset Password',
                    height: 50.h,
                  ),
                  SizedBox(height: 24.h),
                  if (controller.isLoading.value)
                    Column(
                      children: [
                        SizedBox(height: 16.h),
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            QuickTechAppColors.lightmaincolor,
                          ),
                        ),
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
