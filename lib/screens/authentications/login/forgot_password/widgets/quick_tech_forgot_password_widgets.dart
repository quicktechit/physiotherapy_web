import 'package:e_prescription/const/const.dart';



final QuickTechForgotPassController forgotPassController = locator.get<QuickTechForgotPassController>();
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
final isDay = themeController.isDay.value;
Widget buildHeader() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Reset Password',
        style: myStyle(
         Responsive.isDesktop(Get.context!)?8.sp: 22.sp,
          isDay
              ? QuickTechAppColors.lightmaintextcolor
              : QuickTechAppColors.darkmaintextcolor,
          FontWeight.bold,
        ),
      ),
      SizedBox(height: 8.h),
      Text(
        forgotPassController.otpSent.value
            ? 'Enter the 6-digit OTP sent to your phone'
            : 'Enter your phone number to receive OTP',
        style: myStyle(
          Responsive.isDesktop(Get.context!)?4.sp: 14.sp,
          isDay
              ? QuickTechAppColors.lightsecondarytextcolor
              : QuickTechAppColors.darksecondarytextcolor,
        ),
      ),
    ],
  );
}

Widget buildPhoneNumberField() {
  return TextFormField(
    decoration: InputDecoration(
      labelStyle: TextStyle(
        color: isDay
            ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
            : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
        fontSize: Responsive.isDesktop(Get.context!)?5.sp: 14.sp,
      ),
      labelText: 'Phone Number',
      prefixIcon: const Icon(Icons.phone),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
    ),
    keyboardType: TextInputType.phone,
    onChanged: forgotPassController.phoneNumber,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your phone number';
      } else if (value.length < 11) {
        return 'Phone number must be 11 digits';
      }
      return null;
    },
  );
}

/*Widget buildOtpField(BuildContext context) {
  return Column(
    children: [
     QuickTechCustomTextField(
        maxline: 6,
        onchanged: forgotPassController.otp,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter OTP';
          } else if (value.length != 6) {
            return 'OTP must be 6 digits';
          }
          return null;
        },
        label: '6-digit OTP',
        controller: forgotPassController.otpcontroller,
        keyboardType: TextInputType.number,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
 
      const SizedBox(height: 8),
      Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed:
              forgotPassController.isLoading.value
                  ? null
                  : forgotPassController.sendOtp,
          child: const Text('Resend OTP'),
        ),
      ),
    ],
  );
}*/

Widget buildActionButton() {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: getButtonAction(),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        backgroundColor:
            isDay
                ? QuickTechAppColors.lightmaincolor
                : QuickTechAppColors.darkmaincolor,
      ),
      child:
          forgotPassController.isLoading.value
              ? SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: CircularProgressIndicator(
                    color: QuickTechAppColors.lightmaincolor,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  'Send OTP',
                  //forgotPassController.otpSent.value ? 'Verify OTP' : 'Send OTP',
                  style: myStyle(16.sp, Colors.white, FontWeight.bold),
                ),
    ),
  );
}

VoidCallback? getButtonAction() {
  if (forgotPassController.isLoading.value) return null;
  if (forgotPassController.otpSent.value) {
    return forgotPassController.isValidOtp
        ? forgotPassController.verifyOtp
        : null;
  } else {
    return forgotPassController.isValidPhone
        ? forgotPassController.sendOtp
        : null;
  }
}

Widget buildMessages() {
  return Column(
    children: [
      if (forgotPassController.errorMessage.isNotEmpty)
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Text(
            forgotPassController.errorMessage.value,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      if (forgotPassController.successMessage.isNotEmpty)
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Text(
            forgotPassController.successMessage.value,
            style: TextStyle(color: Get.theme.primaryColor),
            textAlign: TextAlign.center,
          ),
        ),
    ],
  );
}
