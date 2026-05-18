import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/authentication_controller/login_controller/quick_tech_forgot_pass_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/responsive.dart';
import 'package:e_prescription/screens/authentications/login/forgot_password/widgets/quick_tech_forgot_password_widgets.dart';
import 'package:e_prescription/widgets/quick_tech_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickTechForgotPassword extends StatefulWidget {
  QuickTechForgotPassword({super.key});

  @override
  State<QuickTechForgotPassword> createState() => _QuickTechForgotPasswordState();
}

class _QuickTechForgotPasswordState extends State<QuickTechForgotPassword> {
  final QuickTechForgotPassController forgotPassController = locator.get<QuickTechForgotPassController>();

  @override
  void initState() {
    super.initState();
    // Clear previous OTP data when entering this screen
    forgotPassController.resetForgotPasswordState();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _buildScaffold(context, isMobile: true),
      tablet: _buildScaffold(context, isMobile: false),
      desktop: _buildDesktopLayout(context),
    );
  }

  // ── Mobile & Tablet ──────────────────────────────────────────────────────────

  Widget _buildScaffold(BuildContext context, {required bool isMobile}) {
    return Scaffold(
      backgroundColor: isDay ? QuickTechAppColors.lightScaffoldColor : QuickTechAppColors.darkScaffoldColor,
      appBar: _buildAppBar(),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20.w : 48.w,
            vertical: 24.h,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 560.w),
            child: _buildFormCard(context, isMobile: isMobile),
          ),
        ),
      ),
    );
  }

  // ── Desktop ──────────────────────────────────────────────────────────────────

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      backgroundColor: isDay ? QuickTechAppColors.lightScaffoldColor : QuickTechAppColors.darkScaffoldColor,
      appBar: _buildAppBar(),
      body: Row(
        children: [
          // Left decorative panel
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    (isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor),
                    (isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor)
                        .withValues(alpha: 0.7),
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.health_and_safety_rounded, size: 80.sp, color: Colors.white.withValues(alpha: 0.9)),
                    SizedBox(height: 24.h),
                    Text(
                      'e-Prescription',
                      style: myStyle(32.sp, Colors.white, FontWeight.bold),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Secure & Smart Healthcare',
                      style: myStyle(16.sp, Colors.white.withValues(alpha: 0.8), FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Right form panel
          Expanded(
            flex: 4,
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 40.h),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 440.w),
                  child: _buildFormCard(context, isMobile: false),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Shared form card ─────────────────────────────────────────────────────────

  Widget _buildFormCard(BuildContext context, {required bool isMobile}) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeader(),
        SizedBox(height: 32.h),
        if (!forgotPassController.otpSent.value) buildPhoneNumberField(),
        SizedBox(height: 24.h),
        QuickTechCustomButton(
          onTab: forgotPassController.isLoading.value
              ? null
              : () => forgotPassController.sendOtp(),
          color: isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor,
          height: 52.h,
          width: double.infinity,
          title: forgotPassController.isLoading.value ? 'Sending...' : 'Send OTP',
        ),
        SizedBox(height: 16.h),
        buildMessages(),
        if (forgotPassController.isLoading.value) ...[
          SizedBox(height: 16.h),
          Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor,
              ),
              strokeWidth: 2.5,
            ),
          ),
        ],
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Remember your password? ',
              style: myStyle(
                13.sp,
                isDay ? QuickTechAppColors.lightsecondarytextcolor : QuickTechAppColors.darksecondarytextcolor,
              ),
            ),
            GestureDetector(
              onTap: () => Get.back(),
              child: Text(
                'Sign In',
                style: myStyle(
                  13.sp,
                  isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor,
                  FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    ));
  }

  // ── AppBar ───────────────────────────────────────────────────────────────────

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: isDay ? QuickTechAppColors.lightScaffoldColor : QuickTechAppColors.darkScaffoldColor,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: isDay ? QuickTechAppColors.lightmaintextcolor : QuickTechAppColors.darkmaintextcolor,
        ),
        onPressed: () {
          // Clear state when going back
          forgotPassController.resetForgotPasswordState();
          Get.back();
        },
      ),
    );
  }
}