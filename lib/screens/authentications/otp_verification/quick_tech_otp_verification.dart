import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';

import 'package:e_prescription/controllers/authentication_controller/otp_controller/quick_tech_otp_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/screens/homepage/quick_tech_main_home.dart';
import 'package:e_prescription/widgets/quick_tech_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class QuickTechOtpVerification extends StatefulWidget {
  final String mobile;
  final String verifyToken;
  QuickTechOtpVerification({Key? key, required this.mobile, required this.verifyToken}) : super(key: key);
  @override
  State<QuickTechOtpVerification> createState() => _QuickTechOtpVerificationState();
}



class _QuickTechOtpVerificationState extends State<QuickTechOtpVerification> {

  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechOtpController otpController = locator.get<QuickTechOtpController>();
  final List<TextEditingController> otpFields = List.generate(6, (_) => TextEditingController());


  @override
  void initState() {
    super.initState();
    otpController.setVerifyToken(widget.verifyToken);
  }

  @override
  void dispose() {
    for (final c in otpFields) {
      c.dispose();
    }
    super.dispose();
  }


  String get otpValue => otpFields.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            themeController.isDay.value
                ? QuickTechAppColors.lightScaffoldColor
                : QuickTechAppColors.darkScaffoldColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor:  themeController.isDay.value
                ? QuickTechAppColors.lightScaffoldColor
                : QuickTechAppColors.darkScaffoldColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color:
                  themeController.isDay.value
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
                      widget.mobile.isNotEmpty
                          ? widget.mobile
                          : '+880XXXXXXXXXX',
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
                          6, //Number of digits
                          (index) => SizedBox(
                            width: 48.w,
                            child: TextFormField(
                              controller: otpFields[index],
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
                                    color:
                                        themeController.isDay.value
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
                    if (otpController.errorText.value.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Text(
                          otpController.errorText.value,
                          style: myStyle(12.sp, Colors.red),
                        ),
                      ),
                    QuickTechCustomButton(
                      onTab: () async {
                        final otp = otpValue;
                        final mobile = widget.mobile;
                        if (otp.length != 6) {
                          otpController.errorText.value = 'Please enter the 6-digit code';
                          return;
                        }
                        final verified = await otpController.verifyOtpWithApi(mobile: mobile, otp: otp);
                        if (verified) {
                          Get.offAll(() => QuickTechMainHome());
                        }
                      },
                      color:
                          themeController.isDay.value
                              ? QuickTechAppColors.lightmaincolor
                              : QuickTechAppColors.darkmaincolor,
                      title: 'Verify',
                      height: 50.h,
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive code?",
                          style: myStyle(
                            14.sp,
                            themeController.isDay.value
                                ? QuickTechAppColors.lightsecondarytextcolor
                                : QuickTechAppColors.darksecondarytextcolor,
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            final mobile = widget.mobile;
                            if (mobile.isNotEmpty) {
                              await otpController.resendOtpWithApi(mobile: mobile);
                            }
                          },
                          child: Text(
                            'Resend',
                            style: myStyle(
                              16.sp,
                              themeController.isDay.value
                                  ? QuickTechAppColors.lightmaincolor
                                  : QuickTechAppColors.darkmaincolor,
                              FontWeight.bold,
                            ),
                          ),
                        ),
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
