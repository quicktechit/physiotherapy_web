import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/controllers/authentication_controller/login_controller/quick_tech_forgot_pass_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/responsive.dart';
import 'package:e_prescription/screens/authentications/login/forgot_password/reset_password/quick_tech_reset_password.dart';
import 'package:e_prescription/widgets/quick_tech_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassOtp extends StatefulWidget {
  ForgotPassOtp({super.key});

  @override
  State<ForgotPassOtp> createState() => _ForgotPassOtpState();
}

class _ForgotPassOtpState extends State<ForgotPassOtp> {
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechForgotPassController forgotPassController = locator.get<QuickTechForgotPassController>();
  final List<TextEditingController> otpControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  late String passresetToken;
  late String mobile;
  final RxString errorText = ''.obs;
  final RxBool isLoading = false.obs;

  String get otpValue => otpControllers.map((c) => c.text).join();
  bool get isDay => themeController.isDay.value;
  Color get mainColor => isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    passresetToken = args?['passresetToken']?.toString() ?? '';
    mobile = args?['mobile']?.toString() ?? '';
  }

  @override
  void dispose() {
    for (final c in otpControllers) c.dispose();
    for (final f in focusNodes) f.dispose();
    super.dispose();
  }

  void _verifyOtp() {
    final otp = otpValue;
    if (otp.length != 6) {
      errorText.value = 'Please enter the 6-digit code';
      return;
    }
    if (otp != passresetToken) {
      errorText.value = 'Invalid OTP. Please try again.';
      return;
    }
    Get.to(() => QuickTechResetPassword(mobile: mobile, passresetToken: passresetToken));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Responsive(
      mobile: _buildScaffold(context, isMobile: true),
      tablet: _buildScaffold(context, isMobile: false),
      desktop: _buildDesktopLayout(context),
    ));
  }

  // ── Desktop ──────────────────────────────────────────────────────────────────

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      backgroundColor: isDay ? QuickTechAppColors.lightScaffoldColor : QuickTechAppColors.darkScaffoldColor,
      appBar: _buildAppBar(),
      body: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [mainColor, mainColor.withValues(alpha: 0.7)],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.verified_user_rounded, size: 80.sp, color: Colors.white.withValues(alpha: 0.9)),
                    SizedBox(height: 24.h),
                    Text('Verify OTP', style: myStyle(32.sp, Colors.white, FontWeight.bold)),
                    SizedBox(height: 10.h),
                    Text(
                      'Secure your account',
                      style: myStyle(16.sp, Colors.white.withValues(alpha: 0.8), FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 40.h),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 480.w),
                  child: _buildContent(context),
                ),
              ),
            ),
          ),
        ],
      ),
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
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  // ── Shared content ───────────────────────────────────────────────────────────

  Widget _buildContent(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Icon
        Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: mainColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(
            Icons.verified_rounded,
            color: mainColor,
            size: isDesktop ? 32.sp : 26.sp,
          ),
        ),
        SizedBox(height: 20.h),

        // Title
        Text(
          'Verify your phone',
          style: myStyle(
            isDesktop ? 28.sp : isTablet ? 24.sp : 22.sp,
            isDay ? QuickTechAppColors.lightmaintextcolor : QuickTechAppColors.darkmaintextcolor,
            FontWeight.bold,
          ),
        ),
        SizedBox(height: 6.h),

        // Subtitle
        Text(
          'We sent a verification code to',
          style: myStyle(
            isDesktop ? 15.sp : 13.sp,
            isDay ? QuickTechAppColors.lightsecondarytextcolor : QuickTechAppColors.darksecondarytextcolor,
          ),
        ),
        SizedBox(height: 2.h),

        // Mobile number
        Text(
          mobile.isNotEmpty ? mobile : '+880XXXXXXXXXX',
          style: myStyle(
            isDesktop ? 16.sp : 14.sp,
            mainColor,
            FontWeight.w600,
          ),
        ),
        SizedBox(height: isDesktop ? 40.h : 32.h),

        // OTP Input Fields - Fixed sizing
        _buildOtpInputs(context),
        SizedBox(height: 28.h),

        // Error message
        if (errorText.value.isNotEmpty)
          Container(
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline_rounded, color: Colors.red.shade600, size: 16.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    errorText.value,
                    style: myStyle(isDesktop ? 13.sp : 12.sp, Colors.red.shade700),
                  ),
                ),
              ],
            ),
          ),

        // Verify button
        QuickTechCustomButton(
          onTab: isLoading.value ? null : _verifyOtp,
          color: mainColor,
          title: isLoading.value ? 'Verifying...' : 'Verify OTP',
          height: 52.h,
          width: double.infinity,
        ),
        SizedBox(height: 24.h),

        // Resend section
        Center(
          child: Column(
            children: [
              Text(
                "Didn't receive code?",
                style: myStyle(
                  13.sp,
                  isDay ? QuickTechAppColors.lightsecondarytextcolor : QuickTechAppColors.darksecondarytextcolor,
                ),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () {
                  // Clear OTP fields when resending
                  for (var controller in otpControllers) {
                    controller.clear();
                  }
                  errorText.value = '';
                  forgotPassController.sendOtp();
                },
                child: Text(
                  'Resend OTP',
                  style: myStyle(13.sp, mainColor, FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── OTP Input Boxes ──────────────────────────────────────────────────────────

  Widget _buildOtpInputs(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    // Calculate box size based on screen width
    double boxSize;
    double spacing;

    if (isDesktop) {
      boxSize = 56.w;
      spacing = 12.w;
    } else if (isTablet) {
      boxSize = 50.w;
      spacing = 10.w;
    } else {
      // Mobile - more conservative calculation to prevent overflow
      final screenWidth = MediaQuery.of(context).size.width;
      // Total: 6 boxes + 5 gaps between + side padding
      final availableWidth = screenWidth - 40.w;
      spacing = 6.w;
      // Adjust for padding on each side of each box (spacing/2 * 2 per box)
      final totalSpacingNeeded = spacing * 5; // 5 gaps between 6 boxes
      boxSize = (availableWidth - totalSpacingNeeded) / 6;
      // Ensure boxSize doesn't get too small
      boxSize = boxSize.clamp(40.0, 60.0);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          6,
          (index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: spacing / 2),
            child: SizedBox(
              width: boxSize,
              height: boxSize,
              child: TextFormField(
                controller: otpControllers[index],
                focusNode: focusNodes[index],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                style: myStyle(
                  boxSize * 0.5,
                  isDay ? QuickTechAppColors.lightmaintextcolor : QuickTechAppColors.darkmaintextcolor,
                  FontWeight.bold,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: isDay ? Colors.grey.shade50 : Colors.grey.shade900,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide(color: mainColor, width: 2.5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide(color: Colors.red.shade300),
                  ),
                ),
                onChanged: (value) {
                  errorText.value = '';
                  if (value.length == 1 && index < 5) {
                    focusNodes[index + 1].requestFocus();
                  } else if (value.isEmpty && index > 0) {
                    focusNodes[index - 1].requestFocus();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

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
          // Clear OTP data when going back
          for (var controller in otpControllers) {
            controller.clear();
          }
          errorText.value = '';
          Get.back();
        },
      ),
    );
  }
}