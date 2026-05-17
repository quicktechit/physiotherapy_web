

import 'package:e_prescription/screens/authentications/login/quick_tech_login.dart';

import '../../../const/const.dart';

class QuickTechRegistration extends StatefulWidget {
  QuickTechRegistration({super.key});

  @override
  State<QuickTechRegistration> createState() => _QuickTechRegistrationState();
}

class _QuickTechRegistrationState extends State<QuickTechRegistration> {
  final QuickTechThemeController themeController =
      locator.get<QuickTechThemeController>();

  @override
  void initState() {
    super.initState();
    registrationController.clearAllFields();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _MobileRegistration(themeController: themeController),
      tablet: _TabletRegistration(themeController: themeController),
      desktop: _DesktopRegistration(themeController: themeController),
    );
  }
}

class _MobileRegistration extends StatelessWidget {
  final QuickTechThemeController themeController;

  const _MobileRegistration({required this.themeController});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            themeController.isDay.value
                ? const Color(0xFFF4F6FA)
                : QuickTechAppColors.darkScaffoldColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
          centerTitle: true,
          title: Text(
            'Create Account',
            style: QuickTechAppTextStyle.headline3().copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Section
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color:
                      themeController.isDay.value
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: themeController.isDay.value ? 0.08 : 0.2,
                      ),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    customProfileImageSection(),
                    SizedBox(height: 16.h),
                    Text(
                      'Register Your Account',
                      style: QuickTechAppTextStyle.headline4().copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color:
                            themeController.isDay.value
                                ? const Color(0xFF0F172A)
                                : Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Fill in your details to get started',
                      style: QuickTechAppTextStyle.bodyText2().copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color:
                            themeController.isDay.value
                                ? const Color(0xFF64748B)
                                : Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Form Section
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color:
                      themeController.isDay.value
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: themeController.isDay.value ? 0.08 : 0.2,
                      ),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: customForm(),
              ),
              SizedBox(height: 24.h),

              Obx(
                () => QuickTechCustomButton(
                  onTab:
                      registrationController.isLoading.value
                          ? null
                          : () => registrationController.register(),
                  color:
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaincolor
                          : QuickTechAppColors.darkmaincolor,
                  title:
                      registrationController.isLoading.value
                          ? 'Creating...'
                          : 'Create Account',
                  height: 50.h,
                  width: double.infinity,
                ),
              ),

              // Error Message
              if (registrationController.errorMessage.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: Colors.red.withValues(alpha: 0.5),
                      ),
                    ),
                    child: customErrorText(),
                  ),
                ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabletRegistration extends StatelessWidget {
  final QuickTechThemeController themeController;

  const _TabletRegistration({required this.themeController});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            themeController.isDay.value
                ? const Color(0xFFF4F6FA)
                : QuickTechAppColors.darkScaffoldColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
          centerTitle: true,
          title: Text(
            'Create Account',
            style: QuickTechAppTextStyle.headline3().copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 24.w),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header Section
                  Container(
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color:
                          themeController.isDay.value
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: themeController.isDay.value ? 0.08 : 0.2,
                          ),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        customProfileImageSection(),
                        SizedBox(height: 18.h),
                        Text(
                          'Register Your Account',
                          style: QuickTechAppTextStyle.headline4().copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color:
                                themeController.isDay.value
                                    ? const Color(0xFF0F172A)
                                    : Colors.white,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          'Complete the form below to create your account',
                          style: QuickTechAppTextStyle.bodyText2().copyWith(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color:
                                themeController.isDay.value
                                    ? const Color(0xFF64748B)
                                    : Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 28.h),

                  // Form Section
                  Container(
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color:
                          themeController.isDay.value
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: themeController.isDay.value ? 0.08 : 0.2,
                          ),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: customForm(),
                  ),
                  SizedBox(height: 28.h),

                  Obx(
                    () => QuickTechCustomButton(
                      onTab:
                          registrationController.isLoading.value
                              ? null
                              : () => registrationController.register(),
                      color:
                          themeController.isDay.value
                              ? QuickTechAppColors.lightmaincolor
                              : QuickTechAppColors.darkmaincolor,
                      title:
                          registrationController.isLoading.value
                              ? 'Creating...'
                              : 'Create Account',
                      height: 50.h,
                      width: double.infinity,
                    ),
                  ),

                  // Error Message
                  if (registrationController.errorMessage.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: Container(
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: Colors.red.withValues(alpha: 0.5),
                          ),
                        ),
                        child: customErrorText(),
                      ),
                    ),

                  SizedBox(height: 28.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopRegistration extends StatelessWidget {
  final QuickTechThemeController themeController;

  const _DesktopRegistration({required this.themeController});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            themeController.isDay.value
                ? const Color(0xFFF4F6FA)
                : QuickTechAppColors.darkScaffoldColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
          centerTitle: true,
          title: Text(
            'Create Account',
            style: QuickTechAppTextStyle.headline3().copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
         onPressed: () {
              Get.offAll(() => QuickTechLogin());
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 32.w),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 750.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Side - Image and Info
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(32.w),
                          decoration: BoxDecoration(
                            color:
                                themeController.isDay.value
                                    ? Colors.white
                                    : Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(
                                  alpha:
                                      themeController.isDay.value ? 0.08 : 0.2,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              customProfileImageSection(),
                              SizedBox(height: 24.h),
                              Text(
                                'Join Our Platform',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      themeController.isDay.value
                                          ? const Color(0xFF0F172A)
                                          : Colors.white,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                'Create your account to access our comprehensive healthcare management system',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      themeController.isDay.value
                                          ? const Color(0xFF64748B)
                                          : Colors.grey[400],
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 32.w),

                      // Right Side - Form
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(32.w),
                          decoration: BoxDecoration(
                            color:
                                themeController.isDay.value
                                    ? Colors.white
                                    : Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(
                                  alpha:
                                      themeController.isDay.value ? 0.08 : 0.2,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Account Details',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      themeController.isDay.value
                                          ? const Color(0xFF0F172A)
                                          : Colors.white,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              customForm(),
                              SizedBox(height: 24.h),
                              Obx(
                                () => QuickTechCustomButton(
                                  onTab:
                                      registrationController.isLoading.value
                                          ? null
                                          : () =>
                                              registrationController.register(),
                                  color:
                                      themeController.isDay.value
                                          ? QuickTechAppColors.lightmaincolor
                                          : QuickTechAppColors.darkmaincolor,
                                  title:
                                      registrationController.isLoading.value
                                          ? 'Creating...'
                                          : 'Create Account',
                                  height: 50.h,
                                  width: double.infinity,
                                ),
                              ),
                              if (registrationController
                                  .errorMessage
                                  .isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.only(top: 16.h),
                                  child: Container(
                                    padding: EdgeInsets.all(14.w),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(
                                        color: Colors.red.withValues(
                                          alpha: 0.5,
                                        ),
                                      ),
                                    ),
                                    child: customErrorText(),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
