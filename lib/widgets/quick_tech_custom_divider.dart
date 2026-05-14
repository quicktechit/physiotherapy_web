

import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    required this.themeController,
  });

  final QuickTechThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.5, 
      width: double.infinity, 
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.transparent,
            themeController.isDay.value
                    ? QuickTechAppColors.lightmaincolor
                    : QuickTechAppColors.white, 
            Colors.transparent, 
          ],
          stops: [
            0.0,
            0.5,
            1.0,
          ], 
        ),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ), 
    );
  }
}
