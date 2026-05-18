import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/controllers/authentication_controller/otp_controller/quick_tech_otp_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/responsive.dart';
import 'package:e_prescription/screens/homepage/quick_tech_main_home.dart';
import 'package:e_prescription/widgets/quick_tech_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickTechOtpVerification extends StatefulWidget {
  final String mobile;
  final String verifyToken;
  const QuickTechOtpVerification({Key? key, required this.mobile, required this.verifyToken}) : super(key: key);

  @override
  State<QuickTechOtpVerification> createState() => _QuickTechOtpVerificationState();
}

class _QuickTechOtpVerificationState extends State<QuickTechOtpVerification> {
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechOtpController otpController = locator.get<QuickTechOtpController>();
  final List<TextEditingController> otpFields = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  bool get isDay => themeController.isDay.value;
  Color get mainColor => isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor;
  String get otpValue => otpFields.map((c) => c.text).join();

  @override
  void initState() {
    super.initState();
    otpController.setVerifyToken(widget.verifyToken);
  }

  @override
  void dispose() {
    for (final c in otpFields) c.dispose();
    for (final f in focusNodes) f.dispose();
    super.dispose();
  }

  Future<void> _verify() async {
    final otp = otpValue;
    if (otp.length != 6) {
      otpController.errorText.value = 'Please enter the 6-digit code';
      return;
    }
    final verified = await otpController.verifyOtpWithApi(mobile: widget.mobile, otp: otp);
    if (verified) Get.offAll(() => QuickTechMainHome());
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
                    Icon(Icons.shield_rounded, size: 80.sp, color: Colors.white.withValues(alpha: 0.9)),
                    SizedBox(height: 24.h),
                    Text('Phone Verification', style: myStyle(32.sp, Colors.white, FontWeight.bold)),
                    SizedBox(height: 10.h),
                    Text(
                      'One step away from access',
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
                  constraints: BoxConstraints(maxWidth: 440.w),
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
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20.w : 48.w,
            vertical: 24.h,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 520.w),
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
        Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: mainColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(Icons.phone_forwarded_rounded, color: mainColor, size: isDesktop ? 32.sp : 26.sp),
        ),
        SizedBox(height: 20.h),
        Text(
          'Verify your phone',
          style: myStyle(
            isDesktop ? 28.sp : isTablet ? 24.sp : 22.sp,
            isDay ? QuickTechAppColors.lightmaintextcolor : QuickTechAppColors.darkmaintextcolor,
            FontWeight.bold,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'We sent a verification code to',
          style: myStyle(
            isDesktop ? 15.sp : 13.sp,
            isDay ? QuickTechAppColors.lightsecondarytextcolor : QuickTechAppColors.darksecondarytextcolor,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          widget.mobile.isNotEmpty ? widget.mobile : '+880XXXXXXXXXX',
          style: myStyle(isDesktop ? 16.sp : 14.sp, mainColor, FontWeight.w600),
        ),
        SizedBox(height: 36.h),

        // OTP boxes
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(6, (index) => _buildOtpBox(context, index)),
        ),
        SizedBox(height: 28.h),

        // Error
        if (otpController.errorText.value.isNotEmpty)
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
                    otpController.errorText.value,
                    style: myStyle(isDesktop ? 13.sp : 12.sp, Colors.red.shade700),
                  ),
                ),
              ],
            ),
          ),

        // Verify button
        QuickTechCustomButton(
          onTab: _verify,
          color: mainColor,
          title: 'Verify',
          height: 52.h,
        ),
        SizedBox(height: 24.h),

        // Resend
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Didn't receive code? ",
              style: myStyle(
                13.sp,
                isDay ? QuickTechAppColors.lightsecondarytextcolor : QuickTechAppColors.darksecondarytextcolor,
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (widget.mobile.isNotEmpty) {
                  await otpController.resendOtpWithApi(mobile: widget.mobile);
                }
              },
              child: Text('Resend', style: myStyle(13.sp, mainColor, FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOtpBox(BuildContext context, int index) {
    final boxSize = Responsive.isDesktop(context) ? 52.w : Responsive.isTablet(context) ? 48.w : 44.w;
    return SizedBox(
      width: boxSize,
      height: boxSize,
      child: TextFormField(
        controller: otpFields[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: myStyle(
          22.sp,
          isDay ? QuickTechAppColors.lightmaintextcolor : QuickTechAppColors.darkmaintextcolor,
          FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: isDay ? Colors.grey.shade50 : Colors.grey.shade900,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: mainColor, width: 2),
          ),
        ),
        onChanged: (value) {
          otpController.errorText.value = '';
          if (value.length == 1 && index < 5) {
            focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            focusNodes[index - 1].requestFocus();
          }
        },
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
        onPressed: () => Get.back(),
      ),
    );
  }
}