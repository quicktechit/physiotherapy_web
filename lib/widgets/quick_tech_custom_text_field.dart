import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:flutter/material.dart';


import 'package:e_prescription/locator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../responsive.dart';

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
    this.height = 60.0,
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
    final themecontroller = locator.get<QuickTechThemeController>();
   bool shouldObscureText = obscureText && ((maxline ?? 1) == 1);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
      ),
      margin: EdgeInsets.only(top: 8.h),
      height: height.h,
      child: TextFormField(
  maxLines: obscureText ? 1 : (maxline ?? 1),
        autovalidateMode: autovalidateMode,
        onChanged: onchanged,
        keyboardType: keyboardType,
        controller: controller,
        obscureText: shouldObscureText,
        style: myStyle(Responsive.isDesktop(context)?5.sp:12.sp, txtcolor),
        validator: validator,
        decoration: InputDecoration(
          hintStyle: myStyle(
            Responsive.isDesktop(context)?4.sp: 12.sp,
            themecontroller.isDay.value ? Colors.grey : Colors.white,
          ),
          hintText: hint,
          labelText: label,
          labelStyle: myStyle(Responsive.isDesktop(context)?4.sp:9.sp, lebelcolor),
          prefixIcon: Icon(icon, color: iconcolor, size: Responsive.isDesktop(context)?5.sp:20.sp),
          suffixIcon:
              suffixicon != null
                  ? IconButton(
                      icon: Icon(suffixicon, color: suffixiconColor, size:Responsive.isDesktop(context)?8.sp: 20.sp),
                      onPressed: onSuffixIconPressed,
                    )
                  : null, 
          filled: true,
          fillColor: backcolor,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(
              color:
                  themecontroller.isDay.value
                      ? QuickTechAppColors.lightmaincolor
                      : QuickTechAppColors.darkmaincolor,
            ),
          ),
        ),
      ),
    );
  }
}
