import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../responsive.dart';

Widget customCard({
  required String title,
  String? subtitle,
  String? lottieAsset,
  Color cardColor = Colors.white,
  Color titleColor = Colors.black87,
  Color subtitleColor = Colors.black54,
  double elevation = 6.0,
  double borderRadius = 20.0,
  double lottieHeight = 120,
  bool hasShadow = true,
  EdgeInsetsGeometry? padding,
  List<BoxShadow>? customShadow,
  Gradient? gradient,
  VoidCallback? onTap,
  bool? isCenterTitle = false,
  bool? hasBorder = false,
}) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius.r),
          boxShadow:
              hasShadow
                  ? customShadow ??
                      [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 6.r,
                          offset: Offset(0, 4.h),
                        ),
                      ]
                  : null,
        ),
        child: Card(
          elevation: 0,
          color: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius.r),border: hasBorder! ? Border.all(color: QuickTechAppColors.lightmaincolor, width: 3) : null,
              gradient: gradient,
            ),
            child: Padding(
              padding: padding ?? EdgeInsets.all(Responsive.isDesktop(Get.context!)?3.w:16.0.w),
              child: Column(
                crossAxisAlignment: isCenterTitle! ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: [
                  if (lottieAsset != null && lottieAsset.isNotEmpty)
                    SizedBox(
                      height: lottieHeight.h,
                      child: Center(
                        child: Lottie.asset(
                          lottieAsset,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 48.sp, color: Colors.grey),
                        ),
                      ),
                    ),
                  if (subtitle != null && subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: myStyle( Responsive.isDesktop(Get.context!)?4.sp:12.sp, subtitleColor, FontWeight.w400),
                    ),
                  Center(
                    child: Text(
                      title,
                      style: myStyle(Responsive.isDesktop(Get.context!)?4.sp: 14.sp, titleColor, FontWeight.w600),
                    ),
                  ),

           
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}



