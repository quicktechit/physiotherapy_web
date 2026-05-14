import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/add_assesment/preview_assesment/widgets/quick_tech_assesment_preview_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

class QuickTechAssesmentPreview extends StatelessWidget {
  QuickTechAssesmentPreview({super.key});
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            themeController.isDay.value
                ? QuickTechAppColors.lightScaffoldColor
                : QuickTechAppColors.darkScaffoldColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: QuickTechAppColors.white,
            ),
          ),
          backgroundColor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
          elevation: 4,
          title: Text(
            'Assesment Preview',
            style: myStyle(18, QuickTechAppColors.white, FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(
                themeController.isDay.value
                    ? Icons.light_mode
                    : Icons.dark_mode,
                color:
                    themeController.isDay.value ? Colors.yellow : Colors.white,
              ),
              onPressed: themeController.toggleTheme,
            ),
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: AssementSummary(true),
        ),
      ),
    );
  }
}
