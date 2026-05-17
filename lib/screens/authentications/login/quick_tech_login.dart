import 'package:e_prescription/const/quick_tech_app_colors.dart';

import 'package:e_prescription/controllers/authentication_controller/login_controller/quick_tech_login_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/responsive.dart';
import 'package:e_prescription/screens/authentications/registration/quick_tech_registration.dart';

import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuickTechLogin extends StatelessWidget {
  QuickTechLogin({Key? key}) : super(key: key);

  final QuickTechThemeController themeController =
      locator.get<QuickTechThemeController>();
  final QuickTechLoginController loginController =
      locator.get<QuickTechLoginController>();

  @override
  Widget build(BuildContext context) {
 
    

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await loginController.onWillPop();
        if (shouldPop) Navigator.of(context).pop();
      },
      child: Obx(
        () => Scaffold(
          backgroundColor: themeController.isDay.value
              ? QuickTechAppColors.lightScaffoldColor
              : QuickTechAppColors.darkScaffoldColor,
          body: Responsive(
            mobile: MobileLogin(context),
            tablet: DesktopLogin(context),
            desktop: DesktopLogin(context),
          ),
        ),
      ),
    );
  }

  // ── Desktop: left brand panel + right form panel ──────────────────────────
  Widget DesktopLogin(BuildContext context) {
    final isDay = themeController.isDay.value;
    return Row(
      children: [
        // Left — brand/hero panel
        Expanded(
          flex: 5,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDay
                    ? [
                        QuickTechAppColors.lightmaincolor,
                        QuickTechAppColors.lightmaincolor.withBlue(200),
                        const Color(0xFF1565C0),
                      ]
                    : [
                        const Color(0xFF1A237E),
                        QuickTechAppColors.darkmaincolor,
                        const Color(0xFF0D47A1),
                      ],
              ),
            ),
            child: Stack(
              children: [
                // Decorative circles
                Positioned(
                  top: -60,
                  left: -60,
                  child: _decorCircle(240, Colors.white.withValues(alpha: 0.06)),
                ),
                Positioned(
                  bottom: -80,
                  right: -80,
                  child: _decorCircle(320, Colors.white.withValues(alpha: 0.05)),
                ),
                Positioned(
                  top: 180,
                  right: -40,
                  child: _decorCircle(160, Colors.white.withValues(alpha: 0.07)),
                ),
                // Content
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(48),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo with glass card
                        Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                                width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 30,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Image.asset('assets/images/mainlogo.png',
                              fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          'E-Prescription',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Smart digital prescriptions\nfor modern healthcare',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withValues(alpha: 0.75),
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 48),
                        // Feature chips
                        ...[
                          ('✦', 'Instant PDF generation'),
                          ('✦', 'Bilingual support (EN / বাংলা)'),
                          ('✦', 'Secure patient records'),
                        ].map((f) => Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(f.$1,
                                      style: const TextStyle(
                                          color: Colors.white70, fontSize: 14)),
                                  const SizedBox(width: 10),
                                  Text(f.$2,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Right — form panel
        Expanded(
          flex: 4,
          child: Container(
            color: isDay ? Colors.white : const Color(0xFF161B27),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 40),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: _buildForm(context, isDesktop: true),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Mobile: single centered card ─────────────────────────────────────────
  Widget MobileLogin(BuildContext context) {
    final isDay = themeController.isDay.value;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDay
              ? [QuickTechAppColors.lightScaffoldColor,QuickTechAppColors.lightScaffoldColor]
              : [QuickTechAppColors.darkScaffoldColor, const Color(0xFF161B27)],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              // Logo
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: QuickTechAppColors.lightmaincolor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: QuickTechAppColors.lightmaincolor.withValues(alpha: 0.3)),
                ),
                padding: const EdgeInsets.all(12),
                child: Image.asset('assets/images/mainlogo.png', fit: BoxFit.contain),
              ),
              const SizedBox(height: 16),
              Text(
                'E-Prescription',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: QuickTechAppColors.lightmaincolor,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 32),
              _buildForm(context, isDesktop: false),
            ],
          ),
        ),
      ),
    );
  }

  // ── Shared form ───────────────────────────────────────────────────────────
  Widget _buildForm(BuildContext context, {required bool isDesktop}) {
    final isDay = themeController.isDay.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back',
          style: TextStyle(
            fontSize: isDesktop ? 28 : 22,
            fontWeight: FontWeight.w800,
            color: isDay
                ? QuickTechAppColors.lightmaintextcolor
                : QuickTechAppColors.darkmaintextcolor,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Sign in to your account',
          style: TextStyle(
            fontSize: 14,
            color: isDay ? Colors.grey[500] : Colors.grey[400],
          ),
        ),
        const SizedBox(height: 36),

        // Phone field
        _fieldLabel('Phone Number', isDay),
        const SizedBox(height: 8),
       QuickTechCustomTextField(
              icon: Icons.phone_outlined,
              iconcolor: isDay
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
              hint: 'Enter your phone number',
              lebelcolor: isDay
                  ? QuickTechAppColors.lightsecondarytextcolor
                  : QuickTechAppColors.darksecondarytextcolor,
              backcolor: isDay ? const Color(0xFFF8F9FF) : const Color(0xFF1E2433),
              label: 'Phone Number',
              validator: loginController.validatePhoneNumber,
              controller: loginController.phonenumberController,
              keyboardType: TextInputType.phone,
            ),
        const SizedBox(height: 20),

        // Password field
        _fieldLabel('Password', isDay),
        const SizedBox(height: 8),
        QuickTechCustomTextField(
              iconcolor: isDay
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
              icon: Icons.lock_outline,
              onSuffixIconPressed: loginController.togglePasswordVisibility,
              backcolor: isDay ? const Color(0xFFF8F9FF) : const Color(0xFF1E2433),
              hint: 'Enter your password',
              lebelcolor: isDay
                  ? QuickTechAppColors.lightsecondarytextcolor
                  : QuickTechAppColors.darksecondarytextcolor,
              label: 'Password',
              validator: loginController.validatePassword,
              controller: loginController.passwordController,
              obscureText: !loginController.isPasswordVisible.value,
              suffixicon: loginController.isPasswordVisible.value
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              suffixiconColor: isDay ? Colors.grey[500] : Colors.grey[400],
            ),

        // Forgot password
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => Get.toNamed('/forgotpass'),
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: QuickTechAppColors.lightmaincolor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Login button
        Obx(() => SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: loginController.isLoading.value
                    ? null
                    : loginController.login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: QuickTechAppColors.lightmaincolor,
                  disabledBackgroundColor:
                      QuickTechAppColors.lightmaincolor.withValues(alpha: 0.6),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: loginController.isLoading.value
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor:
                                AlwaysStoppedAnimation(Colors.white)),
                      )
                    : const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
              ),
            )),

        const SizedBox(height: 28),

        // Divider
        Row(
          children: [
            Expanded(child: Divider(color: isDay ? Colors.grey[200] : Colors.grey[800])),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text('or continue with',
                  style: TextStyle(
                      fontSize: 12,
                      color: isDay ? Colors.grey[400] : Colors.grey[600])),
            ),
            Expanded(child: Divider(color: isDay ? Colors.grey[200] : Colors.grey[800])),
          ],
        ),
        const SizedBox(height: 20),

        // Google sign-in
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton(
            onPressed: loginController.googleSignIn,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                  color: isDay ? const Color(0xFFE0E4EE) : Colors.grey[700]!),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              backgroundColor:
                  isDay ? Colors.white : const Color(0xFF1E2433),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset('assets/icons/google.png',
                      width: 22, height: 22),
                ),
                const SizedBox(width: 12),
                Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDay
                        ? QuickTechAppColors.lightmaintextcolor
                        : QuickTechAppColors.darkmaintextcolor,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 28),

        // Register link
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(
                  fontSize: 13,
                  color: isDay ? Colors.grey[500] : Colors.grey[400],
                ),
              ),
              GestureDetector(
                onTap: () => Get.off(() => QuickTechRegistration()),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: QuickTechAppColors.lightmaincolor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _fieldLabel(String text, bool isDay) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: isDay
            ? QuickTechAppColors.lightmaintextcolor
            : QuickTechAppColors.darkmaintextcolor,
      ),
    );
  }

  Widget _decorCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}