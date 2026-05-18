import 'package:e_prescription/const/const.dart';

final QuickTechForgotPassController forgotPassController = locator.get<QuickTechForgotPassController>();
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
final isDay = themeController.isDay.value;

Widget buildHeader() {
  final context = Get.context!;
  final isDesktop = Responsive.isDesktop(context);
  final isTablet = Responsive.isTablet(context);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: (isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor)
              .withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(
          Icons.lock_reset_rounded,
          color: isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor,
          size: isDesktop ? 32.sp : isTablet ? 28.sp : 26.sp,
        ),
      ),
      SizedBox(height: 20.h),
      Text(
        'Reset Password',
        style: myStyle(
          isDesktop ? 28.sp : isTablet ? 24.sp : 22.sp,
          isDay ? QuickTechAppColors.lightmaintextcolor : QuickTechAppColors.darkmaintextcolor,
          FontWeight.bold,
        ),
      ),
      SizedBox(height: 6.h),
      Text(
        forgotPassController.otpSent.value
            ? 'Enter the 6-digit OTP sent to your phone'
            : 'Enter your registered phone number to receive a verification code',
        style: myStyle(
          isDesktop ? 15.sp : isTablet ? 14.sp : 13.sp,
          isDay ? QuickTechAppColors.lightsecondarytextcolor : QuickTechAppColors.darksecondarytextcolor,
        ),
      ),
    ],
  );
}

Widget buildPhoneNumberField() {
  final context = Get.context!;
  final isDesktop = Responsive.isDesktop(context);
  final isTablet = Responsive.isTablet(context);
  final mainColor = isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Phone Number',
        style: myStyle(
          isDesktop ? 14.sp : 13.sp,
          isDay ? QuickTechAppColors.lightmaintextcolor : QuickTechAppColors.darkmaintextcolor,
          FontWeight.w600,
        ),
      ),
      SizedBox(height: 8.h),
      TextFormField(
        decoration: InputDecoration(
          hintText: '+880 XXXX-XXXXXX',
          hintStyle: TextStyle(
            color: (isDay ? QuickTechAppColors.lightmaintextcolor : QuickTechAppColors.darkmaintextcolor)
                .withValues(alpha: 0.35),
            fontSize: isDesktop ? 14.sp : isTablet ? 13.sp : 13.sp,
          ),
          prefixIcon: Container(
            margin: EdgeInsets.all(10.w),
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: mainColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.phone_android_rounded, color: mainColor, size: 18.sp),
          ),
          filled: true,
          fillColor: isDay ? Colors.grey.shade50 : Colors.grey.shade900,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(color: mainColor, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(color: Colors.red.shade300),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        ),
        keyboardType: TextInputType.phone,
        onChanged: forgotPassController.phoneNumber,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) return 'Please enter your phone number';
          if (value.length < 11) return 'Phone number must be 11 digits';
          return null;
        },
      ),
    ],
  );
}

Widget buildMessages() {
  final context = Get.context!;
  final isDesktop = Responsive.isDesktop(context);

  return Column(
    children: [
      if (forgotPassController.errorMessage.isNotEmpty)
        Container(
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
                  forgotPassController.errorMessage.value,
                  style: TextStyle(color: Colors.red.shade700, fontSize: isDesktop ? 14.sp : 13.sp),
                ),
              ),
            ],
          ),
        ),
      if (forgotPassController.successMessage.isNotEmpty)
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle_outline_rounded, color: Colors.green.shade600, size: 18.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  forgotPassController.successMessage.value,
                  style: TextStyle(color: Colors.green.shade700, fontSize: isDesktop ? 14.sp : 13.sp),
                ),
              ),
            ],
          ),
        ),
    ],
  );
}

VoidCallback? getButtonAction() {
  if (forgotPassController.isLoading.value) return null;
  if (forgotPassController.otpSent.value) {
    return forgotPassController.isValidOtp ? forgotPassController.verifyOtp : null;
  } else {
    return forgotPassController.isValidPhone ? forgotPassController.sendOtp : null;
  }
}