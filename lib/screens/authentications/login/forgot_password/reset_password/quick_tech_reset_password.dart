import 'package:e_prescription/const/const.dart';

import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';


class QuickTechResetPassword extends StatefulWidget {
  final String mobile;
  final String passresetToken;
  const QuickTechResetPassword({Key? key, required this.mobile, required this.passresetToken}) : super(key: key);

  @override
  State<QuickTechResetPassword> createState() => _QuickTechResetPasswordState();
}

class _QuickTechResetPasswordState extends State<QuickTechResetPassword> {
  final QuickTechForgotPassController controller = locator.get<QuickTechForgotPassController>();

  @override
  void initState() {
    super.initState();
    controller.passwordController.clear();
    controller.confirmController.clear();
    controller.resetErrorText.value = '';
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
      body: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    QuickTechAppColors.lightmaincolor,
                    QuickTechAppColors.lightmaincolor.withValues(alpha: 0.7),
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_rounded, size: 80.sp, color: Colors.white.withValues(alpha: 0.9)),
                    SizedBox(height: 24.h),
                    Text('New Password', style: myStyle(32.sp, Colors.white, FontWeight.bold)),
                    SizedBox(height: 10.h),
                    Text(
                      'Keep your account secure',
                      style: myStyle(16.sp, Colors.white.withValues(alpha: 0.8), FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: QuickTechAppColors.lightScaffoldColor,
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
          ),
        ],
      ),
    );
  }

  // ── Mobile & Tablet ──────────────────────────────────────────────────────────

  Widget _buildScaffold(BuildContext context, {required bool isMobile}) {
    return Scaffold(
      backgroundColor: QuickTechAppColors.lightScaffoldColor,
      appBar: AppBar(
        backgroundColor: QuickTechAppColors.lightmaincolor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Reset Password', style: myStyle(isMobile ? 20.sp : 22.sp, Colors.white, FontWeight.w700)),
      ),
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
        if (isDesktop) ...[
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: QuickTechAppColors.lightmaincolor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(Icons.lock_reset_rounded, color: QuickTechAppColors.lightmaincolor, size: 32.sp),
          ),
          SizedBox(height: 20.h),
          Text('Create New Password', style: myStyle(28.sp, Colors.black, FontWeight.bold)),
          SizedBox(height: 6.h),
          Text(
            'Enter a strong new password for your account',
            style: myStyle(15.sp, Colors.grey.shade600),
          ),
          SizedBox(height: 32.h),
        ] else ...[
          SizedBox(height: 8.h),
          Text(
            'Create New Password',
            style: myStyle(isTablet ? 24.sp : 20.sp, Colors.black, FontWeight.w700),
          ),
          SizedBox(height: 6.h),
          Text(
            'Enter a strong new password for your account',
            style: myStyle(13.sp, Colors.grey.shade600),
          ),
          SizedBox(height: 24.h),
        ],

        // Mobile info card
        Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: QuickTechAppColors.lightmaincolor.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: QuickTechAppColors.lightmaincolor.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: QuickTechAppColors.lightmaincolor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.phone_android_rounded, color: QuickTechAppColors.lightmaincolor, size: 18.sp),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mobile Number', style: myStyle(12.sp, Colors.grey.shade600, FontWeight.w500)),
                  SizedBox(height: 2.h),
                  Text(widget.mobile, style: myStyle(15.sp, Colors.black, FontWeight.w600)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),

        // Password fields card
        Container(
          padding: EdgeInsets.all(18.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.08),
                spreadRadius: 2,
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              QuickTechCustomTextField(
                label: 'New Password',
                controller: controller.passwordController,
                backcolor: QuickTechAppColors.lightScaffoldColor,
                height: 52.h,
                icon: Icons.lock_outline_rounded,
                iconcolor: QuickTechAppColors.lightmaincolor,
              ),
              SizedBox(height: 12.h),
              QuickTechCustomTextField(
                label: 'Confirm Password',
                controller: controller.confirmController,
                backcolor: QuickTechAppColors.lightScaffoldColor,
                height: 52.h,
                icon: Icons.lock_outline_rounded,
                iconcolor: QuickTechAppColors.lightmaincolor,
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),

        // Error message
        if (controller.resetErrorText.value.isNotEmpty)
          Container(
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline_rounded, color: Colors.red.shade600, size: 18.sp),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    controller.resetErrorText.value,
                    style: myStyle(isDesktop ? 14.sp : 13.sp, Colors.red.shade700),
                  ),
                ),
              ],
            ),
          ),

        // Reset button
        QuickTechCustomButton(
          onTab: controller.isLoading.value
              ? null
              : () => controller.resetPassword(
                    mobile: widget.mobile,
                    passresetToken: widget.passresetToken,
                  ),
          color: QuickTechAppColors.lightmaincolor,
          title: controller.isLoading.value ? 'Processing...' : 'Reset Password',
          height: 52.h,
          width: double.infinity,
        ),

        if (controller.isLoading.value) ...[
          SizedBox(height: 20.h),
          Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(QuickTechAppColors.lightmaincolor),
              strokeWidth: 2.5,
            ),
          ),
        ],
        SizedBox(height: 24.h),
      ],
    );
  }
}