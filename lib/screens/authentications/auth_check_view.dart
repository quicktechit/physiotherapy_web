import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';


class AuthCheckView extends StatefulWidget {
  const AuthCheckView({super.key});

  @override
  State<AuthCheckView> createState() => _AuthCheckViewState();
}

class _AuthCheckViewState extends State<AuthCheckView> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final token = QuickTechAuthStorageService.getToken();

    print("🔥 COLD START TOKEN: $token");

    if (token != null && token.isNotEmpty) {
      Get.offAllNamed('/mainhome');
    } else {
      Get.offAllNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final token = QuickTechAuthStorageService.getToken();

    if (token == null || token.isEmpty) {
      return const RouteSettings(name: '/login');
    }
    return null;
  }
}