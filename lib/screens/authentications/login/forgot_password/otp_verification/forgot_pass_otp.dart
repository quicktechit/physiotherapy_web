import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';

import 'package:e_prescription/locator.dart';
import 'package:e_prescription/screens/authentications/login/forgot_password/reset_password/quick_tech_reset_password.dart';
import 'package:e_prescription/screens/authentications/login/forgot_password/widgets/quick_tech_forgot_password_widgets.dart';
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

  // OTP input controllers
  final List<TextEditingController> otpControllers = List.generate(6, (_) => TextEditingController());
  String get otpValue => otpControllers.map((c) => c.text).join();

  late String passresetToken;
  late String mobile;
  final RxString errorText = ''.obs;
  final RxBool isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    passresetToken = args != null && args['passresetToken'] != null ? args['passresetToken'].toString() : '';
    mobile = args != null && args['mobile'] != null ? args['mobile'].toString() : '';
  }

  // Future<void> resetPassword(String password) async {
  //   isLoading.value = true;
  //   try {
  //     final response = await http.post(
  //       Uri.parse('http://physiotherapy.eclecticdesignsbd.com/api/reset/password'),
  //       body: {
  //         'mobile': mobile,
  //         'passresetToken': passresetToken,
  //         'password': password,
  //       },
  //     );
  //     final data = jsonDecode(response.body);
  //     if (response.statusCode == 200 && data['message'] != null) {
  //       Get.snackbar('Success', data['message'], backgroundColor: Colors.green.shade100, colorText: Colors.black);
  //       Get.offAllNamed('/login');
  //     } else {
  //       errorText.value = data['message'] ?? 'Failed to reset password.';
  //       Get.snackbar('Error', errorText.value, backgroundColor: Colors.red.shade100, colorText: Colors.black);
  //     }
  //   } catch (e) {
  //     errorText.value = 'Failed to reset password. Please try again.';
  //     Get.snackbar('Error', errorText.value, backgroundColor: Colors.red.shade100, colorText: Colors.black);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // void showResetPasswordDialog() {
  //   final passwordController = TextEditingController();
  //   final confirmController = TextEditingController();
  //   Get.defaultDialog(
  //     title: 'Reset Password',
  //     content: Column(
  //       children: [
  //         TextField(
  //           controller: passwordController,
  //           obscureText: true,
  //           decoration: const InputDecoration(labelText: 'New Password'),
  //         ),
  //         TextField(
  //           controller: confirmController,
  //           obscureText: true,
  //           decoration: const InputDecoration(labelText: 'Confirm Password'),
  //         ),
  //       ],
  //     ),
  //     textConfirm: 'Submit',
  //     textCancel: 'Cancel',
  //     onConfirm: () {
  //       if (passwordController.text.isEmpty || confirmController.text.isEmpty) {
  //         Get.snackbar('Error', 'Please fill all fields', backgroundColor: Colors.red.shade100, colorText: Colors.black);
  //         return;
  //       }
  //       if (passwordController.text != confirmController.text) {
  //         Get.snackbar('Error', 'Passwords do not match', backgroundColor: Colors.red.shade100, colorText: Colors.black);
  //         return;
  //       }
  //       Get.back();
  //       resetPassword(passwordController.text);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: themeController.isDay.value
            ? QuickTechAppColors.lightScaffoldColor
            : QuickTechAppColors.darkScaffoldColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: themeController.isDay.value
              ? QuickTechAppColors.lightScaffoldColor
              : QuickTechAppColors.darkScaffoldColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: themeController.isDay.value
                  ? QuickTechAppColors.lighttextcolor
                  : QuickTechAppColors.darktextcolor,
            ),
            onPressed: () => Get.back(),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    Text(
                      'Verify your phone',
                      style: myStyle(
                        20.sp,
                        themeController.isDay.value
                            ? QuickTechAppColors.lightmaintextcolor
                            : QuickTechAppColors.darkmaintextcolor,
                        FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'We sent a verification code to',
                      style: myStyle(
                        16.sp,
                        themeController.isDay.value
                            ? QuickTechAppColors.lightsecondarytextcolor
                            : QuickTechAppColors.darksecondarytextcolor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      mobile.isNotEmpty ? mobile : '+880XXXXXXXXXX',
                      style: myStyle(
                        17.sp,
                        themeController.isDay.value
                            ? QuickTechAppColors.lightmaintextcolor
                            : QuickTechAppColors.darkmaintextcolor,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    // OTP Input Fields
                    Form(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          6,
                          (index) => SizedBox(
                            width: 48.w,
                            child: TextFormField(
                              controller: otpControllers[index],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              style: myStyle(
                                24.sp,
                                themeController.isDay.value
                                    ? QuickTechAppColors.lightmaintextcolor
                                    : QuickTechAppColors.darkmaintextcolor,
                              ),
                              decoration: InputDecoration(
                                counterText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide(
                                    color: themeController.isDay.value
                                        ? QuickTechAppColors.lightmaincolor
                                        : QuickTechAppColors.darkmaincolor,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if (value.length == 1 && index < 5) {
                                  FocusScope.of(context).nextFocus();
                                } else if (value.isEmpty && index > 0) {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    if (errorText.value.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Text(
                          errorText.value,
                          style: myStyle(12.sp, Colors.red),
                        ),
                      ),
                    QuickTechCustomButton(
                      onTab: isLoading.value
                          ? null
                          : () {
                              final otp = otpValue;
                              if (otp.length != 6) {
                                errorText.value = 'Please enter the 6-digit code';
                                return;
                              }
                              if (otp != passresetToken) {
                                errorText.value = 'Invalid OTP code.';
                                return;
                              }
                              Get.to(() => QuickTechResetPassword(mobile: mobile, passresetToken: passresetToken));
                            },
                      color: themeController.isDay.value
                          ? QuickTechAppColors.lightmaincolor
                          : QuickTechAppColors.darkmaincolor,
                      title: isLoading.value ? 'Processing...' : 'Verify',
                      height: 50.h,
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(onPressed: () {
                         forgotPassController.sendOtp(); 
                        }, child: Text(
                          "Didn't receive code?",
                          style: myStyle(
                            14.sp,
                            themeController.isDay.value
                                ? QuickTechAppColors.lightsecondarytextcolor
                                : QuickTechAppColors.darksecondarytextcolor,
                          ),
                        ),)
                    
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
