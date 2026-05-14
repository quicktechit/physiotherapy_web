import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/authentication_controller/otp_controller/quick_tech_otp_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/models/user_model/quick_tech_user_model.dart';
import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:e_prescription/utils/api.dart';

import 'package:e_prescription/widgets/quick_tech_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_prescription/controllers/authentication_controller/login_controller/quick_tech_login_controller.dart';



class QuickTechLoginVerification extends StatefulWidget {
   final String staticMobile;

  QuickTechLoginVerification({super.key, required this.staticMobile});
  @override
  State<QuickTechLoginVerification> createState() => _QuickTechLoginVerificationState();
}



class _QuickTechLoginVerificationState extends State<QuickTechLoginVerification> {
   final QuickTechOtpController otpController =locator.get<QuickTechOtpController>();
  final bool isDay = true;
  final List<TextEditingController> otpFields = List.generate(6, (_) => TextEditingController());
  String errorText = '';
  bool isLoading = false;
  String? _password;

  @override
  void dispose() {
    for (final c in otpFields) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> verifyAndLogin() async {
    final otp = otpValue;
    final mobile = widget.staticMobile;
    setState(() {
      isLoading = true;
      errorText = '';
    });
    try {

      final verifyResponse = await http.post(
        Uri.parse('${Api.baseUrl}/api/verify'),
        headers: {'Accept': 'application/json'},
        body: {'mobile': mobile, 'otp': otp},
      );
      if (verifyResponse.statusCode == 200) {
        final verifyData = json.decode(verifyResponse.body);
        if (verifyData['status'] == 'success' ||
            (verifyData['message']?.toString().toLowerCase().contains('success') ?? false)) {
    
          String? password = _password;
          if (password == null || password.isEmpty) {
            setState(() {
              errorText = 'Password is required to login.';
            });
            return;
          }
          final loginResponse = await http.post(
            Uri.parse('${Api.baseUrl}/api/login'),
            headers: {'Accept': 'application/json'},
            body: {'mobile': mobile, 'password': password},
          );
          if (loginResponse.statusCode == 200) {
            final loginData = json.decode(loginResponse.body);
            if (loginData['status'] == 'success') {
               final token = loginData['access_token'];
        final user = QuickTechUserModel.fromJson(loginData['user']);
        await QuickTechAuthStorageService.saveToken(token);
        await QuickTechAuthStorageService.saveUser(user);
            Get.toNamed('/mainhome');
            
            } else {
              setState(() {
                errorText = loginData['message'] ?? 'Login failed. Please try again.';
              });
            }
          } else {
            setState(() {
              errorText = 'Login failed. Please try again.';
            });
          }
        } else {
          setState(() {
            errorText = verifyData['message'] ?? 'Verification failed.';
          });
        }
      } else {
        setState(() {
          errorText = 'Verification failed. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        errorText = 'An error occurred: ${e.toString()}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  
  String get otpValue => otpFields.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QuickTechAppColors.lightScaffoldColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: QuickTechAppColors.lightScaffoldColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: QuickTechAppColors.lighttextcolor,
          ),
          onPressed: () => Get.back()
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
                      QuickTechAppColors.lightmaintextcolor,
                      FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'We sent a verification code to',
                    style: myStyle(
                      16.sp,
                      QuickTechAppColors.lightsecondarytextcolor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    widget.staticMobile,
                    style: myStyle(
                      17.sp,
                      QuickTechAppColors.lightmaintextcolor,
                    ),
                  ),
                  SizedBox(height: 40.h),
             
                  Form(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        6, 
                        (index) => SizedBox(
                          width: 48.w,
                          child: TextFormField(
                            controller: otpFields[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            style: myStyle(
                              24.sp,
                              QuickTechAppColors.lightmaintextcolor,
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
                                  color: QuickTechAppColors.lightmaincolor,
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
                  if (errorText.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Text(
                        errorText,
                        style: myStyle(12.sp, Colors.red),
                      ),
                    ),
                  QuickTechCustomButton(
                    onTab: isLoading
                        ? null
                        : () async {
                            final otp = otpValue;
                            if (otp.length != 6) {
                              setState(() {
                                errorText = 'Please enter the 6-digit code';
                              });
                              return;
                            }
                       
                            if (_password == null || _password!.isEmpty) {
                              try {
                                final loginController = locator.get<QuickTechLoginController>();
                                _password = loginController.passwordController.text.trim();
                              } catch (e) {
                                setState(() {
                                  errorText = 'Password not found. Please login again.';
                                });
                                return;
                              }
                            }
                            await verifyAndLogin();
                          },
                    color: QuickTechAppColors.lightmaincolor,
                    title: isLoading ? 'Verifying...' : 'Verify',
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
                          QuickTechAppColors.lightsecondarytextcolor,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                   otpController.resendOtpWithApi(mobile: widget.staticMobile);
                        },
                        child: Text(
                          'Resend',
                          style: myStyle(
                            16.sp,
                            QuickTechAppColors.lightmaincolor,
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
    );
  }
}
