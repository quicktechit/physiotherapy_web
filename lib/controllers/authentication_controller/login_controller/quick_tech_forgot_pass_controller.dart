import 'dart:convert';
import 'package:e_prescription/screens/authentications/login/forgot_password/otp_verification/forgot_pass_otp.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class QuickTechForgotPassController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpcontroller = TextEditingController();

  final RxString resetErrorText = ''.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString successMessage = ''.obs;
  final RxString phoneNumber = ''.obs;
  final RxBool otpSent = false.obs;
  final RxString otp = ''.obs;

  bool get isValidPhone => phoneNumber.value.length >= 10;
  bool get isValidOtp => otp.value.length == 6;

  @override
  void onClose() {
    passwordController.dispose();
    confirmController.dispose();
    phoneController.dispose();
    otpcontroller.dispose();
    super.onClose();
  }

  void _clearAllData() {
    phoneNumber.value = '';
    phoneController.clear();
    otpcontroller.clear();
    otp.value = '';
    errorMessage.value = '';
    successMessage.value = '';
    otpSent.value = false;
    resetErrorText.value = '';
    isLoading.value = false;
  }

  Future<void> resetPassword({required String mobile, required String passresetToken}) async {
    if (passwordController.text.isEmpty || confirmController.text.isEmpty) {
      resetErrorText.value = 'Please fill all fields';
      return;
    }
    if (passwordController.text != confirmController.text) {
      resetErrorText.value = 'Passwords do not match';
      return;
    }
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse(Api.resetPassword),
        body: {
          'mobile': mobile,
          'passresetToken': passresetToken,
          'password': passwordController.text,
        },
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['message'] != null) {
        _clearAllData();
        passwordController.clear();
        confirmController.clear();
        Get.snackbar('Success', data['message'], backgroundColor: Colors.green.shade100, colorText: Colors.black);
        Get.offAllNamed('/login');
      } else {
        resetErrorText.value = data['message'] ?? 'Failed to reset password.';
        Get.snackbar('Error', resetErrorText.value, backgroundColor: Colors.red.shade100, colorText: Colors.black);
      }
    } catch (e) {
      resetErrorText.value = 'Failed to reset password. Please try again.';
      Get.snackbar('Error', resetErrorText.value, backgroundColor: Colors.red.shade100, colorText: Colors.black);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendOtp() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      successMessage.value = '';

      // Clear previous OTP data if resending
      if (otpSent.value) {
        otpcontroller.clear();
        otp.value = '';
      }

      final response = await http.post(
        Uri.parse(Api.forgetPassword),
        body: {'mobile': phoneNumber.value},
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['passresetToken'] != null) {
        otpSent.value = true;
        successMessage.value = 'OTP sent to ${phoneNumber.value}';
        
        Get.snackbar(
          'Success',
          '${data['message']}\nToken: ${data['passresetToken']}\nMobile: ${data['mobile']}',
          backgroundColor: Colors.green.shade100,
          colorText: Colors.black,
          duration: const Duration(seconds: 4),
        );
        
        Get.to(() => ForgotPassOtp(), arguments: {
          'passresetToken': data['passresetToken'],
          'mobile': data['mobile'],
        });
      } else {
        errorMessage.value = data['message'] ?? 'Failed to send OTP.';
        Get.snackbar('Error', errorMessage.value, backgroundColor: Colors.red.shade100, colorText: Colors.black);
      }
    } catch (e) {
      errorMessage.value = 'Failed to send OTP. Please try again.';
      Get.snackbar('Error', errorMessage.value, backgroundColor: Colors.red.shade100, colorText: Colors.black);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await Future.delayed(const Duration(seconds: 2));
      Get.toNamed('/reset-password', arguments: phoneNumber.value);
    } catch (e) {
      errorMessage.value = 'Invalid OTP. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  // Clear data when going back to forgot password screen
  void resetForgotPasswordState() {
    _clearAllData();
  }
}