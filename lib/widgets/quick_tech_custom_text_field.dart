import 'package:e_prescription/const/quick_tech_app_colors.dart';

import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:e_prescription/locator.dart';

class QuickTechCustomTextField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final TextEditingController controller;
  final bool obscureText;
  final double height;
  final Color? backcolor;
  final Color? txtcolor;
  final Color? lebelcolor;
  final Color? iconcolor;
  final String? hint;
  final IconData? suffixicon;
  final Color? suffixiconColor;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final VoidCallback? onSuffixIconPressed;
  final ValueChanged<String>? onchanged;
  final AutovalidateMode? autovalidateMode;
  final int? maxline;

  const QuickTechCustomTextField({
    Key? key,
    required this.label,
    this.icon,
    required this.controller,
    this.obscureText = false,
    this.height = 56.0,
    this.backcolor,
    this.txtcolor,
    this.lebelcolor,
    this.hint,
    this.iconcolor,
    this.suffixicon,
    this.suffixiconColor,
    this.validator,
    this.keyboardType,
    this.onSuffixIconPressed,
    this.onchanged,
    this.autovalidateMode,
    this.maxline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = locator.get<QuickTechThemeController>();
    final isDay = themeController.isDay.value;
    final bool shouldObscure = obscureText && ((maxline ?? 1) == 1);

    final mainColor = isDay
        ? QuickTechAppColors.lightmaincolor
        : QuickTechAppColors.darkmaincolor;

    return TextFormField(
      maxLines: obscureText ? 1 : (maxline ?? 1),
      autovalidateMode: autovalidateMode,
      onChanged: onchanged,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: shouldObscure,
      style: TextStyle(
        fontSize: 14,
        color: txtcolor ??
            (isDay
                ? QuickTechAppColors.lightmaintextcolor
                : QuickTechAppColors.darkmaintextcolor),
        fontWeight: FontWeight.w500,
      ),
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 13,
          color: isDay ? Colors.grey[400] : Colors.grey[600],
        ),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 13,
          color: lebelcolor ?? (isDay ? Colors.grey[500] : Colors.grey[500]),
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: icon != null
            ? Icon(icon, color: iconcolor ?? mainColor, size: 20)
            : null,
        suffixIcon: suffixicon != null
            ? IconButton(
                icon: Icon(suffixicon,
                    color: suffixiconColor ?? Colors.grey[500], size: 20),
                onPressed: onSuffixIconPressed,
                splashRadius: 20,
              )
            : null,
        filled: true,
        fillColor: backcolor ??
            (isDay ? const Color(0xFFF8F9FF) : const Color(0xFF1E2433)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDay ? const Color(0xFFE0E4EE) : Colors.grey[800]!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDay ? const Color(0xFFE0E4EE) : Colors.grey[800]!,
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: mainColor, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.8),
        ),
      ),
    );
  }
}