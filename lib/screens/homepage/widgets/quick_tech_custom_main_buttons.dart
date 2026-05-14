import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/screens/add_prescription/quick_tech_add_prescription_form.dart';
import 'package:e_prescription/widgets/quick_tech_custom_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../responsive.dart';

final themeController = locator.get<QuickTechThemeController>();
Widget customMainButtons(BuildContext context) {
  double containerWidth = Responsive.isDesktop(context)?0.25.sw: 0.40.sw;
  return Column(
    children: [
      Container(
        width: 1.sw,

        child: customCard(
          title: 'Add Patient',
          lottieAsset: 'assets/animations/addpatient.json',
          cardColor:
              themeController.isDay.value
                  ? QuickTechAppColors.white
                  : QuickTechAppColors.bkdarktxtfld,
          borderRadius: 18,
          elevation: 4,
          titleColor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : Colors.white,
          subtitleColor: Colors.white.withValues(alpha: 0.9),
          lottieHeight: 80.h,
          padding: EdgeInsets.all(Responsive.isDesktop(context)?2.w:16.w),
          onTap: () {
            Get.toNamed('/addassessment');
          },
          isCenterTitle: true,
          hasBorder: true,
        ),
      ),
      SizedBox(height: 10.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            //height: containerHeight,
            width: containerWidth,
            margin: EdgeInsets.only(right: 10.w),
            child: customCard(
              title: 'Add Prescription',
              lottieAsset: 'assets/animations/prescription.json',
              cardColor:
                  themeController.isDay.value
                      ? Colors.white
                      : QuickTechAppColors.darkmaincolor,
              borderRadius: 18,
              elevation: 4,
              titleColor:
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaincolor
                      : Colors.white,
              lottieHeight: 80.h,
              padding: EdgeInsets.all(Responsive.isDesktop(context)?3.w: 16.w),
              onTap: () {
                Get.to(() => QuickTechPrescriptionForm());
              },
            ),
          ),
          Container(
            // height: containerHeight,
            width: containerWidth,
            margin: EdgeInsets.only(left: 10.w),
            child: customCard(
              title: 'Add Assessment',
              lottieAsset: 'assets/animations/assessment.json',
              cardColor:
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaincolor.withValues(alpha: 0.7)
                      : QuickTechAppColors.bkdarktxtfld,
              borderRadius: 18,
              elevation: 4,
              titleColor: Colors.white,
              subtitleColor: Colors.white.withValues(alpha: 0.9),
              lottieHeight: 80.h,
              padding: EdgeInsets.all(Responsive.isDesktop(context)?3.w:16.w),
              onTap: () {
                Get.toNamed('/addassessment');
              },
            ),
          ),

        ],
      ),
    ],
  );
}
